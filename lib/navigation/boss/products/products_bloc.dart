import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:linh_kien17/component/colors.dart';
import 'package:linh_kien17/component/dialog.dart';
import 'package:linh_kien17/object/category.dart';
import 'package:linh_kien17/object/product.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:linh_kien17/sqlite/category.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductsBloc extends ChangeNotifier {
  File image;
  Product product = new Product();
  bool isUploaded = false;
  bool isLoadingUpload = false;
  bool isLoadingCategory = true;

  Map<String, bool> colors = new Map<String, bool>();

  var categorys = new List<Category>();
  var listDM = new List<String>();
  var listColor =  new List<String>();
  TextEditingController textEditingControllerName;
  TextEditingController textEditingControllerDescription;
  TextEditingController textEditingControllerMoney;
  TextEditingController textEditingControllermasp;
  TextEditingController textEditingControllerhangsx;
  TextEditingController textEditingControllerxuatxu;
  TextEditingController textEditingControllerbaohanh;
  SqliteCategory sqliteCategory = new SqliteCategory();


  ProductsBloc() {
    this.getCategorys();

    linhKienColors.forEach((item) {
      colors[item]=false;
    });
    textEditingControllerName = new TextEditingController();
   textEditingControllerDescription = new TextEditingController();
   textEditingControllerMoney = new TextEditingController();
   textEditingControllermasp = new TextEditingController();
    textEditingControllerhangsx = new TextEditingController();
    textEditingControllerxuatxu = new TextEditingController();
    textEditingControllerbaohanh = new TextEditingController();

    getLocalGia();
    getLocalMaSP();
    getLocalHangSX();
    getLocalXuatXu();
    getLocalBaoHanh();
  }

  void getLocalGia() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String gia = prefs.getString('gia') ?? "";
    textEditingControllerMoney.text = gia;
  }

  void getLocalMaSP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String masp = prefs.getString('masp') ?? "";
    textEditingControllermasp.text = masp;
  }

  void getLocalHangSX() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String hangsx = prefs.getString('hangsx') ?? "";
    textEditingControllerhangsx.text = hangsx;
  }


  void getLocalXuatXu() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String xuatxu = prefs.getString('xuatxu') ?? "";
    textEditingControllerxuatxu.text = xuatxu;
  }
  void getLocalBaoHanh() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String baohanh = prefs.getString('baohanh') ?? "";
    textEditingControllerbaohanh.text = baohanh;
  }

  Future getImage(ImageSource imageSource) async {
    image = await ImagePicker.pickImage(source: imageSource);
    await testCompressAndGetFile(image, image.path);

    notifyListeners();
  }

  void showBottomSelectImage(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) => Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  title: Text("Thư viện"),
                  onTap: () {
                    getImage(ImageSource.gallery);
                  },
                ),
                ListTile(
                  title: Text("Chụp ảnh"),
                  onTap: () {
                    getImage(ImageSource.camera);
                  },
                )
              ],
            ));
  }

  void getCategorys() {
    isLoadingCategory = true;
    notifyListeners();
    sqliteCategory.getCategorys().then((data) {
      categorys = data;
      isLoadingCategory = false;
      notifyListeners();
    }).catchError((onError) {
      print(onError);
      isLoadingCategory = false;
      notifyListeners();
    });

    categorys.forEach((item) {
      item.status = false;
    });

        listDM=[];
  }

  void onChangeCategory() {
    listDM = [];
    categorys.forEach((item) {
      print(item.status);
      if (item.status == true) {
        listDM.add(item.name);
      }
    });
    notifyListeners();
  }

  void onChangeColor() {
    listColor = [];
    colors.forEach((color,value) {
      if(value) {
        listColor.add(color);
      }
    });
    notifyListeners();
  }

  Future<File> testCompressAndGetFile(File file, String targetPath) async {
    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: 20,
    );
    image = result;
    notifyListeners();

    return result;
  }

  void addProduct(
      {BuildContext context,
      String name,
      String description,
      File image,
      int money,
      String masp,
      String hangsx,
      String xuatxu,
      String baohanh}) {
    List<Map<String, dynamic>> listMapCategory = [];
    int s = 0;
    categorys.forEach((item) {
      if (item.status == true) {
        s++;
        listMapCategory
            .add({"id": item.id, "name": item.name, "slug": item.slug});
      }
    });

    if (name == "") {
      DialogLinhKien.showDialogError(
          context: context, errorMess: "Chưa điền tên sản phẩm!");
    } else if (image == null) {
      DialogLinhKien.showDialogError(
          context: context, errorMess: "Chưa chọn ảnh!");
    } else if (s == 0) {
      DialogLinhKien.showDialogError(
          context: context, errorMess: "Chưa chọn danh mục!");
    } else {
      isLoadingUpload = true;
      notifyListeners();
      product
          .createProductFromWooCommerceAPI(
              name: name,
              description: description,
              money: money,
              image: image,
              masp: masp,
              hangsx: hangsx,
              baohanh: baohanh,
              listMapCategory: listMapCategory,
              listColor: listColor,
              xuatxu: xuatxu)
          .then((data) {
        print(data);
        isUploaded = true;
        isLoadingUpload = false;
        notifyListeners();
      }).then((err) {
        if (!isUploaded) {
          DialogLinhKien.showDialogError(
              context: context, errorMess: "Lỗi khi đăng sản phẩm thử lại!");
        }
        isLoadingUpload = false;
        notifyListeners();
      });
    }
  }

  void reset() {
    this.getCategorys();
    isUploaded = false;
    textEditingControllerName.text = "";
    textEditingControllerDescription.text = "";
    textEditingControllerMoney.text = "";
    textEditingControllermasp.text = "";
    textEditingControllerhangsx.text = "";
    textEditingControllerxuatxu.text = "";
    textEditingControllerbaohanh.text = "";
    image = null;
    notifyListeners();
  }
}

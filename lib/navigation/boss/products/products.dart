import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:linh_kien17/navigation/boss/products/dialog_color/dialog_color.dart';
import 'package:linh_kien17/navigation/boss/products/products_bloc.dart';
import 'package:linh_kien17/object/category.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dialog_category/dialog_category.dart';

class AddProduct extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          builder: (context) => ProductsBloc(),
        )
      ],
      child: AddProductBody(),
    );
  }
}

class AddProductBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ProductsBloc productsBloc = Provider.of<ProductsBloc>(context);
    // TODO: implement build
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Center(
            child: productsBloc.isUploaded
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.cloud_done,
                        color: Colors.green,
                        size: 50,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Đã đăng sản phẩm thành công",
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w600,
                              fontSize: 17),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RaisedButton(
                          color: Colors.blue,
                          child: Text(
                            "Thêm tiếp",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            productsBloc.reset();
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RaisedButton(
                          color: Colors.redAccent,
                          child: Text(
                            "Trở về trang chủ",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      )
                    ],
                  )
                : Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: productsBloc.textEditingControllerName,
                          decoration:
                              InputDecoration(labelText: "Tên sản phẩm"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller:
                              productsBloc.textEditingControllerDescription,
                          decoration: InputDecoration(labelText: "Mô tả"),
                        ),
                      ),
                      Text("Ảnh"),
                      MaterialButton(
                        onPressed: () {
                          productsBloc.showBottomSelectImage(context);
                        },
                        padding: EdgeInsets.all(0),
                        child: Container(
                          height: 200,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blueAccent),
                          ),
                          child: productsBloc.image != null
                              ? Image.file(productsBloc.image)
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(Icons.add_a_photo,
                                        size: 100, color: Colors.blueAccent)
                                  ],
                                ),
                        ),
                      ),
                      productsBloc.isLoadingCategory
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  showDialogOpen(context);
                                },
                                child: Column(
                                  children: <Widget>[
                                    DropdownButton(
                                      hint: Text("Danh mục"),
                                    ),
                                    Text(productsBloc.listDM.toString(), style: TextStyle(color: Colors.grey, fontSize: 17),)
                                  ],
                                ),
                              )
                            ),

                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              showColorDialogOpen(context);
                            },
                            child: Column(
                              children: <Widget>[
                                DropdownButton(
                                  hint: Text("Màu"),
                                ),
                                Text(productsBloc.listColor.toString(), style: TextStyle(color: Colors.grey, fontSize: 17),)
                              ],
                            ),
                          )
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          onChanged: (value) async {
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            prefs.setString("gia", value);
                          },
                          keyboardType: TextInputType.number,
                          controller: productsBloc.textEditingControllerMoney,
                          decoration: InputDecoration(labelText: "Giá"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          onChanged: (value) async {
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            prefs.setString("masp", value);
                          },
                          controller: productsBloc.textEditingControllermasp,
                          decoration: InputDecoration(labelText: "Mã sản phẩm"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          onChanged: (value) async {
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            prefs.setString("hangsx", value);
                          },
                          controller: productsBloc.textEditingControllerhangsx,
                          decoration:
                              InputDecoration(labelText: "Hãng sản xuất"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          onChanged: (value) async {
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            prefs.setString("xuatxu", value);
                          },
                          controller: productsBloc.textEditingControllerxuatxu,
                          decoration: InputDecoration(labelText: "Xuất xứ"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          onChanged: (value) async {
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            prefs.setString("baohanh", value);
                          },
                          controller: productsBloc.textEditingControllerbaohanh,
                          decoration: InputDecoration(labelText: "Bảo hàng"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: productsBloc.isLoadingUpload
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : RaisedButton(
                                color: Colors.redAccent,
                                child: Text(
                                  "Thêm",
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {

                                  productsBloc.addProduct(
                                    context: context,
                                    name: productsBloc
                                        .textEditingControllerName.text,
                                    description: productsBloc
                                        .textEditingControllerDescription.text,
                                    money: productsBloc
                                                .textEditingControllerMoney
                                                .text ==
                                            ""
                                        ? 0
                                        : int.parse(productsBloc
                                            .textEditingControllerMoney.text),
                                    image: productsBloc.image,
                                    masp: productsBloc
                                        .textEditingControllermasp.text,
                                    hangsx: productsBloc
                                        .textEditingControllerhangsx.text,
                                    xuatxu: productsBloc
                                        .textEditingControllerxuatxu.text,
                                    baohanh: productsBloc
                                        .textEditingControllerbaohanh.text,
                                  );
                                },
                              ),
                      )
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  void showDialogOpen(BuildContext context) {
    ProductsBloc productsBloc = Provider.of<ProductsBloc>(context);
    showDialog(
        context: context,
        builder: (context) => DialogCategory(
              categorys: productsBloc.categorys,
              onChange: (categoryReturn) {
                productsBloc.categorys = categoryReturn;
                productsBloc.onChangeCategory();
              },
            ));
  }

  void showColorDialogOpen(BuildContext context) {
    ProductsBloc productsBloc = Provider.of<ProductsBloc>(context);
    showDialog(
        context: context,
        builder: (context) => DialogColor(
          onChange: () {
            productsBloc.onChangeColor();
          },
          colors: productsBloc.colors,
        ));
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:linh_kien17/component/dialog.dart';
import 'package:linh_kien17/navigation/order/pay/pay_success.dart';
import 'package:linh_kien17/object/product.dart';
import 'package:linh_kien17/sqlite/order.dart';
import 'package:linh_kien17/sqlite/product.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PayBloc extends ChangeNotifier {
  bool isLoadingPay;
  int sumPrice;
  List<Map<String, dynamic>> listOrder;

  TextEditingController textEditingControllerName;
  TextEditingController textEditingControllerPhone;
  TextEditingController textEditingControllerAddress;
  String typePay;

  PayBloc() {

    textEditingControllerName = new TextEditingController();
    textEditingControllerPhone = new TextEditingController();
    textEditingControllerAddress = new TextEditingController();
    getLocalAddress();
    getLocalName();
    getLocalPhone();
    typePay = "cod";
    isLoadingPay = true;
    listOrder = [];
    sumPrice = 0;
    getListOrder();
  }

  void getLocalAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String address = prefs.getString('address') ?? "";
    textEditingControllerAddress.text = address;
  }

  void getLocalPhone() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String phone = prefs.getString('phone') ?? "";
    textEditingControllerPhone.text = phone;
  }

  void getLocalName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String name = prefs.getString('name') ?? "";
    textEditingControllerName.text = name;
  }

  void getInfo() {
    print(textEditingControllerName.text +
        textEditingControllerPhone.text +
        textEditingControllerAddress.text +
        typePay);
  }

  void setTypePay(String typePay) {
    this.typePay = typePay;
    notifyListeners();
  }

  void createOrder({BuildContext context}) {
    if (textEditingControllerName.text == "") {
      DialogLinhKien.showDialogError(
          context: context, errorMess: "Chưa nhập tên!");
    } else if (textEditingControllerAddress.text == "") {
      DialogLinhKien.showDialogError(
          context: context, errorMess: "Chưa nhập địa chỉ!");
    } else if (textEditingControllerPhone.text.length < 9) {
      DialogLinhKien.showDialogError(
          context: context, errorMess: "Số điện thoại không hợp lệ");
    } else {
      var listProducts = new List<Map<String, dynamic>>();
      listProducts.clear();
      listOrder.forEach((itemMap) {
        listProducts.add({
          "name": itemMap["product"].name,
          "product_id": itemMap["product"].productId,
          "quantity": itemMap["quantity"],
        });
      });

      DialogLinhKien.showDialogLoading(context: context);
      Product product = new Product();
      product
          .createOrderFromWooCommerceAPI(
              name: textEditingControllerName.text,
              address: textEditingControllerAddress.text,
              phone: textEditingControllerPhone.text,
              mapProducts: listProducts)
          .then((data) {
        print(data);
        String status = data["data"];
        if (status != null) {
          DialogLinhKien.showDialogError(
              context: context, errorMess: data["message"]);
        } else {
          String typePayName = "";
          if (typePay == "cod") {
            typePayName = "Thanh toán COD";
          } else {
            typePayName = "Thanh toán chuyển khoản";
          }

          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => PaySuccess({
                        "name": textEditingControllerName.text,
                        "phone": textEditingControllerPhone.text,
                        "address": textEditingControllerAddress.text,
                        "typePayName": typePayName,
                        "code": "#" + data["id"].toString()
                      })));
        }
      });
    }
  }

  void getListOrder() {
    listOrder.clear();
    sumPrice = 0;
    isLoadingPay = true;
    notifyListeners();
    SqliteOrder sqliteOrder = new SqliteOrder();
    SqliteProduct sqliteProduct = new SqliteProduct();
    sqliteOrder.getOrders().then((data) {
      if (data.length == 0) {
        isLoadingPay = false;
        notifyListeners();
      }
      data.forEach((itemOrder) async {
        var mapOrderItem = new Map<String, dynamic>();
        mapOrderItem["quantity"] = itemOrder.quantity;

        await sqliteProduct
            .getProductByProductId(productId: itemOrder.productId)
            .then((listProductById) {
          mapOrderItem["product"] = listProductById[0];
          listProductById[0].price == -1
              ? sumPrice += 0
              : sumPrice += listProductById[0].price * itemOrder.quantity;
        });
        listOrder.add(mapOrderItem);

        isLoadingPay = false;
        notifyListeners();
      });
    });
  }
}

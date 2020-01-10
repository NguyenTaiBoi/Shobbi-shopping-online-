import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:linh_kien17/component/dialog.dart';
import 'package:linh_kien17/object/product.dart';

class FixBloc extends ChangeNotifier {
  bool isSent;
  TextEditingController textEditingControllerMade;
  TextEditingController textEditingControllerName;
  TextEditingController textEditingControllerPhone;
  TextEditingController textEditingControllerAddress;
  TextEditingController textEditingControllerDetailFix;

  String madeErr;
  String nameErr;
  String phoneErr;
  String addressErr;
  String detailFixErr;

  FixBloc() {
    isSent=false;
    textEditingControllerMade = new TextEditingController();
    textEditingControllerName= new TextEditingController();
    textEditingControllerPhone= new TextEditingController();
    textEditingControllerAddress= new TextEditingController();
    textEditingControllerDetailFix= new TextEditingController();

     madeErr=null;
     nameErr=null;
     phoneErr=null;
     addressErr=null;
     detailFixErr=null;
  }
  setIsSent() {
    isSent=!isSent;
    notifyListeners();
  }

  bool checkMade() {
    if(textEditingControllerMade.text=="") {
      madeErr = "Không được để trống";
      notifyListeners();
      return false;
    }
    madeErr=null;
    return true;
  }

  bool checkName() {
    if(textEditingControllerName.text=="") {
      nameErr = "Không được để trống";
      notifyListeners();
      return false;
    }
    nameErr=null;
    notifyListeners();
    return true;
  }

  bool checkPhone() {
    if(textEditingControllerPhone.text=="") {
      phoneErr = "Không được để trống";
      notifyListeners();
      return false;
    }
    phoneErr=null;
    notifyListeners();
    return true;
  }

  bool checkAddress() {
    if(textEditingControllerAddress.text=="") {
      addressErr = "Không được để trống";
      notifyListeners();
      return false;
    }
    addressErr=null;
    notifyListeners();
    return true;
  }

  bool checkDetailFix() {
    if(textEditingControllerDetailFix.text=="") {
      detailFixErr = "Không được để trống";
      notifyListeners();
      return false;
    }
    detailFixErr=null;
    notifyListeners();
    return true;
  }

  void sendInfoToServer(BuildContext context) {
    if (checkMade() && checkName() && checkPhone() && checkAddress() &&
        checkDetailFix()) {

String info="Hãng máy: " + textEditingControllerMade.text +
          "\n| Tên máy: " + textEditingControllerName.text +
          "\n| Thông tin sửa: " + textEditingControllerDetailFix.text+
          "\n| Địa chỉ: " + textEditingControllerAddress.text;

      Product product = new Product();
      product
          .createOrderFromWooCommerceAPI(
          name: " Sữa chữa máy: " + textEditingControllerName.text,
          address: info,
          phone: textEditingControllerPhone.text,
          mapProducts: [])
          .then((data) {
        print(data);
        String status = data["data"];
        if (status != null) {
          DialogLinhKien.showDialogError(
              context: context, errorMess: data["message"]);
        } else {
          setIsSent();
        }
      });



    }
  }



}
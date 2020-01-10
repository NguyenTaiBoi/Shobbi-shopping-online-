import 'package:flutter/foundation.dart';
import 'package:linh_kien17/object/orders.dart';

class OrdersBLoc extends ChangeNotifier {
  bool isLoadingOrders;
  List<Orders> listOrders;

  OrdersBLoc() {
    isLoadingOrders = false;
    listOrders = [];
    getOrders();
  }

  void getOrders() {
    isLoadingOrders = true;
    notifyListeners();
    Orders orders = new Orders();
    orders.getListOrder().then((data){
      if(data["status"]==true) {
        listOrders= data["data"];
        isLoadingOrders = false;
        notifyListeners();
      } else {
        isLoadingOrders=false;
        notifyListeners();
      }
    });
  }
}
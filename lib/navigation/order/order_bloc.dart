import 'package:flutter/cupertino.dart';
import 'package:linh_kien17/object/product.dart';
import 'package:linh_kien17/sqlite/order.dart';
import 'package:linh_kien17/sqlite/product.dart';

import '../linh_kien_navigator_bloc.dart';

class OrderBloc extends ChangeNotifier {
  bool isLoadingOrder;
  int sumPrice;
  List<Map<String, dynamic>> listOrder;
  OrderBloc() {
    isLoadingOrder = true;
    listOrder = [];
    getListOrder();
    sumPrice=0;
  }
  void getListOrder() {
    listOrder.clear();
    sumPrice=0;
    isLoadingOrder = true;
    notifyListeners();
    SqliteOrder sqliteOrder = new SqliteOrder();
    SqliteProduct sqliteProduct = new SqliteProduct();
    sqliteOrder.getOrders().then((data) {
      if(data.length==0) {
        isLoadingOrder = false;
        notifyListeners();
      }
      data.forEach((itemOrder) async {
        var mapOrderItem = new Map<String, dynamic>();
        mapOrderItem["quantity"] = itemOrder.quantity;

        await sqliteProduct
            .getProductByProductId(productId: itemOrder.productId)
            .then((listProductById) {
          mapOrderItem["product"] = listProductById[0];
          listProductById[0].price == -1 ? sumPrice+=0 : sumPrice+=listProductById[0].price*itemOrder.quantity;

        });
        listOrder.add(mapOrderItem);

        isLoadingOrder = false;
        notifyListeners();
      });
    });
  }

  void newOrUpdateOrder({Product product, int quantity}) async {
    SqliteOrder sqliteOrder = new SqliteOrder();

    await sqliteOrder.newOrder(product, quantity);
    getListOrder();
  }

  void deleteOrderByIdProduct(int id) {
    SqliteOrder sqliteOrder = new SqliteOrder();
    sqliteOrder.deleteOrder(id);
    getListOrder();
  }

  void deleteAll() {
    SqliteOrder sqliteOrder = new SqliteOrder();
    sqliteOrder.deleteAll();
    getListOrder();
  }
}

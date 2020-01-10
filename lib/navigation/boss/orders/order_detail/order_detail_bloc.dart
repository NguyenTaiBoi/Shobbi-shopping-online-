import 'package:flutter/foundation.dart';
import 'package:linh_kien17/object/order.dart';
import 'package:linh_kien17/object/orders.dart';
import 'package:linh_kien17/object/product.dart';
import 'package:linh_kien17/sqlite/product.dart';

class OrderDetailBloc extends ChangeNotifier {
  final Orders orders;
  List<Map<String, dynamic>> productOrders;
  bool isLoadingProducts = true;

  OrderDetailBloc(this.orders) {
    productOrders = [];
    getProducts();
    notifyListeners();
  }

  void getProducts() async{
    productOrders.clear();
    isLoadingProducts = true;
    notifyListeners();
    Orders orders = new Orders();
    SqliteProduct sqliteProduct = new SqliteProduct();

     await orders.getListProductByOrderID(this.orders.id.toString()).then(((data)  async {
      if (data["status"] == true) {
       await data["data"].forEach((OrderProduct item) async {


        print(item.productId);
          var productAndQuantity = new Map<String, dynamic>();
        await sqliteProduct.getProductByProductId(productId: item.productId).then((data) {

            if (data.length != null) {
              productAndQuantity["product"] = data[0];
            }
          });
          productAndQuantity["quantity"] = item.quantity;


            productOrders.add(productAndQuantity);
            print("sl: "+productAndQuantity["quantity"].toString());

        });

      } else {
        isLoadingProducts = false;
        notifyListeners();
      }
    }));

    await Future.delayed(const Duration(seconds: 1), () => "1");

    isLoadingProducts = false;
    notifyListeners();
  }
}

import 'package:linh_kien17/object/order.dart';
import 'package:linh_kien17/object/product.dart';
import 'package:woocommerce_api/woocommerce_api.dart';

class Orders {
  String timeOrder;
  String status;
  String name;
  String address;
  String phone;
  String id;
  String money;

  Orders({this.timeOrder, this.money,this.status, this.name, this.id, this.address, this.phone});

  Future<Map<String, dynamic>> getListOrder() async {
    var dataReturn = new List<Orders>();
    Map<String, dynamic> mapReturn = new Map<String, dynamic>();
    mapReturn["status"] = false;
    mapReturn["mess"] = "?";

    await getListOrderFromWooCommerceAPI().then((data) {
      mapReturn["status"] = true;
      mapReturn["mess"] = "OK";

      data.forEach((item) {
        dataReturn.add(new Orders(
            timeOrder: item["date_created"],
            name: item["billing"]["first_name"],
            status: item["status"],
            address: item["billing"]["address_1"],
            id: item["number"],
            money: item["total"],
            phone: item["billing"]["phone"]));
      });
      mapReturn["data"] = dataReturn;
    }).catchError((err) {
      mapReturn["status"] = false;
      mapReturn["data"] = [];
      mapReturn["mess"] = err.toString();
    });

    return mapReturn;
  }

  Future<Map<String, dynamic>> getListProductByOrderID(String id) async {

    var dataReturn = new List<OrderProduct>();
    Map<String, dynamic> mapReturn = new Map<String, dynamic>();
    mapReturn["status"] = false;
    mapReturn["mess"] = "?";

    await getListProductByOrderIDWooCommerceAPI(id).then((data) {
      mapReturn["status"] = true;
      mapReturn["mess"] = "OK";

      data["line_items"].forEach((item) {

        OrderProduct orderProduct = new OrderProduct(
            productId:item["product_id"],
          quantity: item["quantity"]
);

        dataReturn.add(orderProduct);

      });
      mapReturn["data"] = dataReturn;
    }).catchError((err) {
      mapReturn["status"] = false;
      mapReturn["data"] = [];
      mapReturn["mess"] = err.toString();
    });

    return mapReturn;
  }

  static WooCommerceAPI wcAPI() {
    return new WooCommerceAPI(
        "https://nhandoi.net",
        "ck_090c6a6b389f715ed3186b2ee12ca36dfee6a680",
        "cs_cf5fb095a618c982998abc234fb121e740899560");
  }

  Future<dynamic> getListOrderFromWooCommerceAPI() async {
    var p = await wcAPI().getAsync("orders?page=1&per_page=100");

    return p;
  }


  Future<dynamic> getListProductByOrderIDWooCommerceAPI(String id) async {
    var p = await wcAPI().getAsync("orders/"+id);

    return p;
  }

}

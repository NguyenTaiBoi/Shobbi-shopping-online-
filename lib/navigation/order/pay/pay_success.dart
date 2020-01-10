import 'package:flutter/material.dart';
import 'package:linh_kien17/navigation/linh_kien_navigator.dart';
import 'package:linh_kien17/navigation/order/order.dart';
import 'package:linh_kien17/sqlite/order.dart';

class PaySuccess extends StatelessWidget {
  List<int> listID;
  final Map<String,dynamic> mapInfo;

  PaySuccess(this.mapInfo) {
    SqliteOrder sqliteOrder = new SqliteOrder();
    sqliteOrder.deleteAll();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
        title: Text("Đơn hàng của bạn"),
      ),
      body: buildSuccessPay(context: context),
    );
  }

  Widget buildSuccessPay({BuildContext context}) {
    return Column(children: <Widget>[
      Padding(
        padding: EdgeInsets.all(5),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.all(Radius.circular(5))),
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(Icons.location_on),
                        Text("Thông tin giao hàng"),
                      ],
                    ),
                    Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text(
                          mapInfo["name"],
                          style: TextStyle(fontSize: 17, color: Colors.black54),
                        )),
                    Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text(
                          mapInfo["phone"],
                          style: TextStyle(fontSize: 17, color: Colors.black54),
                        )),
                    Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text(
                          mapInfo["address"],
                          style: TextStyle(fontSize: 17, color: Colors.black54),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.all(5),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.all(Radius.circular(5))),
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(Icons.location_on),
                        Text("Hình thức thanh toán"),
                      ],
                    ),
                    Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text(
                          mapInfo["typePayName"],
                          style: TextStyle(fontSize: 17, color: Colors.black54),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Text("Mã đơn hàng: "+ mapInfo["code"]),
            Text("Thời gian giao dịch: " + DateTime.now().toString()),
            Icon(
              Icons.assignment_turned_in,
              color: Colors.green,
              size: 50,
            ),
            Text(
              "Đặt hàng thành công",
              style: TextStyle(fontSize: 17, color: Colors.blueAccent),
            ),
            Center(
              child: RaisedButton(
                onPressed: () {
                  Route route = MaterialPageRoute(builder: (context) => LinhKienNavigation());


                  Navigator.pushReplacement(context,route);
                },
                child: Row(
                  children: <Widget>[
                    Icon(Icons.add_shopping_cart),
                    Text("Tiếp tục mua sắm")
                  ],
                ),
              ),
            )
          ],
        ),
      )
    ]);
  }

}
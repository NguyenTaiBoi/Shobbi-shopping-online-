import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:linh_kien17/navigation/boss/orders/order_detail/order_detail.dart';
import 'package:linh_kien17/navigation/boss/orders/orders_bloc.dart';
import 'package:linh_kien17/object/orders.dart' as prefix0;
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class Orders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          builder: (context) => OrdersBLoc(),
        )
      ],
      child: OrdersBody(),
    );
  }
}

class OrdersBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    OrdersBLoc ordersBLoc = Provider.of<OrdersBLoc>(context);
    // TODO: implement build
    return Scaffold(
        body: ordersBLoc.isLoadingOrders
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemBuilder: (context, index) {
                  DateTime dateTime =
                      DateTime.parse(ordersBLoc.listOrders[index].timeOrder);
                  String formattedDate =
                      DateFormat('dd/MM/yyyy – kk:mm').format(dateTime);
                  prefix0.Orders orders = new prefix0.Orders(
                      money: ordersBLoc.listOrders[index].money,
                      id: ordersBLoc.listOrders[index].id,
                      timeOrder: formattedDate,
                      status: ordersBLoc.listOrders[index].status,
                      phone: ordersBLoc.listOrders[index].phone,
                      address: ordersBLoc.listOrders[index].address,
                      name: ordersBLoc.listOrders[index].name);

                  return Card(
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OrderDetail(orders: orders)));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(
                                  "#" +
                                      ordersBLoc.listOrders[index].id +
                                      "    ",
                                  style: TextStyle(color: Colors.grey),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                          ordersBLoc.listOrders[index].name),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                          ordersBLoc.listOrders[index].phone),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(formattedDate),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Container(
                                  height: 40,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      color:
                                          ordersBLoc.listOrders[index].status ==
                                                  "completed"
                                              ? Colors.blueAccent
                                              : Colors.greenAccent,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  child: Center(
                                      child: Text(
                                    ordersBLoc.listOrders[index].status ==
                                            "completed"
                                        ? "Đã hoàn thành"
                                        : "Đang xử lý",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 13),
                                  )),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                itemCount: ordersBLoc.listOrders.length,
              ));
  }
}

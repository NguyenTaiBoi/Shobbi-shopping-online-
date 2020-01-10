import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:linh_kien17/navigation/order/pay/pay.dart';
import 'package:linh_kien17/object/orders.dart';
import 'package:linh_kien17/object/product.dart';
import 'package:provider/provider.dart';

import 'order_detail_bloc.dart';

class OrderDetail extends StatelessWidget {
  final Orders orders;

  const OrderDetail({Key key, this.orders}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          builder: (context) => OrderDetailBloc(orders),
        )
      ],
      child: OrderDetailBody(),
    );
  }
}

class OrderDetailBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    OrderDetailBloc orderDetailBloc = Provider.of<OrderDetailBloc>(context);

    FlutterMoneyFormatter sum = FlutterMoneyFormatter(
        amount: int.parse(orderDetailBloc.orders.money ?? "0") + .0);

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("#" + orderDetailBloc.orders.id),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8),
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
                                  padding: const EdgeInsets.all(8),
                                  child: Text(
                                    "Tên: " +
                                        orderDetailBloc
                                            .orders.name, // mapInfo["name"],
                                    style: TextStyle(
                                        fontSize: 17, color: Colors.black54),
                                  )),
                              Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Text(
                                    "Số điện thoại: " +
                                        orderDetailBloc
                                            .orders.phone, //  mapInfo["phone"],
                                    style: TextStyle(
                                        fontSize: 17, color: Colors.black54),
                                  )),
                              Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Text(
                                    "Địa chỉ: " +
                                        orderDetailBloc
                                            .orders.address, //  mapInfo["phone"],
                                    style: TextStyle(
                                        fontSize: 17, color: Colors.black54),
                                  )),
                              Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Text(
                                    "Thời gian đặt: " +
                                        orderDetailBloc.orders
                                            .timeOrder, //mapInfo["address"],
                                    style: TextStyle(
                                        fontSize: 17, color: Colors.black54),
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                orderDetailBloc.isLoadingProducts
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Expanded(
                        child: ListView.builder(
                          itemBuilder: (context, index) => buildItemProduct(
                              context: context,
                              product: orderDetailBloc.productOrders[index]
                                  ["product"],
                              quantity: orderDetailBloc.productOrders[index]
                                  ["quantity"]),
                          itemCount: orderDetailBloc.productOrders.length,
                        ),
                      )
              ],
            ),
          ),
          Column(
            children: <Widget>[
              Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey)),
                padding: EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Tổng",
                      style: TextStyle(fontSize: 17, color: Colors.black54),
                    ),
                    Text(
                      sum.output.withoutFractionDigits.toString() + "đ",
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.redAccent,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
//              MaterialButton(
//                height: 60,
//                onPressed: () {
//                  Navigator.push(
//                      context, MaterialPageRoute(builder: (context) => Pay()));
//                },
//                padding: EdgeInsets.all(0),
//                color: Colors.blueAccent,
//                child: Center(
//                  child: Container(
//                    child: Text(
//                      "ĐÃ HOÀN THÀNH",
//                      style: TextStyle(fontSize: 17, color: Colors.white),
//                    ),
//                  ),
//                ),
//              ),
            ],
          )
        ],
      ),
    );
  }

  Widget buildItemProduct(
      {BuildContext context, Product product, int quantity}) {
    FlutterMoneyFormatter fmf =
        FlutterMoneyFormatter(amount: product.price + .0);
    return Column(
      children: <Widget>[
        Card(
          child: Container(
            padding: EdgeInsets.all(8),
            height: 100,
            child: Row(
              children: <Widget>[
                Image(
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                  image: NetworkImage(product.linkImages),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Text(
                          product.name,
                          overflow: TextOverflow.clip,
                          maxLines: 2,
                          style: TextStyle(color: Colors.black54, fontSize: 17),
                        ),
                      ),
                      Text(fmf.output.withoutFractionDigits.toString() + "đ"),
                      Text("Số lượng: " + quantity.toString())
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

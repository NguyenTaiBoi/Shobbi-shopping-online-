import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:linh_kien17/navigation/notification/notification.dart' as prefix0;
import 'package:linh_kien17/navigation/order/order_bloc.dart';
import 'package:linh_kien17/navigation/order/pay/pay.dart';
import 'package:linh_kien17/object/product.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../linh_kien_navigator_bloc.dart';

class Order extends StatelessWidget {
  final int productId;

  const Order({Key key, this.productId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          builder: (context) => OrderBloc(),
        )
      ],
      child: OrderBody(),
    );
  }
}

class OrderBody extends StatelessWidget {
  List<int> listID;

  @override
  Widget build(BuildContext context) {
    OrderBloc orderBloc = Provider.of<OrderBloc>(context);

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Đơn hàng của bạn"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.white,),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => prefix0.Notification()
              ));
            },
          ),

        ],
      ),
      body: orderBloc.listOrder.length != 0 ? buildList(context: context) : buildEmpty(),
    );
  }

  Widget buildEmpty({BuildContext context}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Align(
          alignment: Alignment.center,
          child: CircleAvatar(
            radius: 40,
            child: Icon(
              Icons.add_shopping_cart,
              size: 30,
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "Bạn chưa có sản phẩm nào trong giỏ hàng",
          style: TextStyle(
              fontWeight: FontWeight.w600, color: Colors.red, fontSize: 17),
        ),
        SizedBox(
          height: 10,
        ),
        Text("Mua sản phẩm ngay")
      ],
    );
  }

  Widget buildList({BuildContext context}) {
    OrderBloc orderBloc = Provider.of<OrderBloc>(context);
    FlutterMoneyFormatter sum = FlutterMoneyFormatter(
        amount: orderBloc.sumPrice + .0
    );
    return orderBloc.isLoadingOrder
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[

              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) => buildItemProduct(
                      context: context,
                      product: orderBloc.listOrder[index]["product"],
                      quantity: orderBloc.listOrder[index]["quantity"]),
                  itemCount: orderBloc.listOrder.length,
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
                  MaterialButton(
                    height: 60,
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Pay()));
                    },
                    padding: EdgeInsets.all(0),
                    color: Colors.red[400],
                    child: Center(
                      child: Container(
                        child: Text(
                          "THANH TOÁN",
                          style: TextStyle(fontSize: 17, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          );
  }

  Widget buildItemProduct(
      {BuildContext context, Product product, int quantity}) {
    OrderBloc orderBloc = Provider.of<OrderBloc>(context);
    FlutterMoneyFormatter fmf = FlutterMoneyFormatter(
        amount: product.price + .0
    );
    return Column(
      children: <Widget>[
        Card(
          child: Container(
            padding: EdgeInsets.all(5),
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Image(
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                      image: NetworkImage(product.linkImages.isNotEmpty
                          ? product.linkImages
                          : "null"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          SizedBox(
                            width:MediaQuery.of(context).size.width*0.5,
                            child: Text(

                              product.name,
                              overflow: TextOverflow.clip,
                              maxLines: 2,
                              softWrap:true,
                              style: TextStyle(color: Colors.black54, fontSize: 17),
                            ),
                          ),
                          Text(product.price == -1
                              ? "Liên hệ "
                              : fmf.output.withoutFractionDigits.toString() + "đ")
                        ],
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {
                    orderBloc.deleteOrderByIdProduct(product.productId);
                  },
                  icon: Icon(Icons.delete_forever),
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text("Số lượng:"),
              InkWell(
                onTap: () {
                  orderBloc.newOrUpdateOrder(
                      product: product, quantity: quantity - 1);
                },
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey)),
                  child: Center(
                    child: Container(
                      height: 2,
                      width: 14,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
              Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey)),
                child: Center(
                    child: Text(
                  quantity.toString(),
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                )),
              ),
              InkWell(
                  onTap: () {
                    orderBloc.newOrUpdateOrder(
                        product: product, quantity: quantity + 1);
                  },
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey)),
                    child: Icon(Icons.add),
                  )),
            ],
          ),
        ),
      ],
    );
  }
}

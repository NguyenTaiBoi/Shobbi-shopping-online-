import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:linh_kien17/navigation/order/order.dart';
import 'package:linh_kien17/object/product.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:linh_kien17/sqlite/order.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailProduct extends StatelessWidget {
  final Product product;

  const DetailProduct({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    FlutterMoneyFormatter fmf = FlutterMoneyFormatter(
        amount: product.price + .0
    );

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          product.name,
          overflow: TextOverflow.clip,
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.local_grocery_store),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Order()));
              }),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
              child: ListView(
            children: <Widget>[
              PageImage(linkImages: product.linkImages),
              Container(
                height: 3,
                color: Colors.red,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(product.name,
                    style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w900,
                        fontSize: 17)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                   product.price == -1 ? "Liên hệ" : fmf.output.withoutFractionDigits.toString() +"đ",
                      style: TextStyle(
                          color: Colors.redAccent,
                          fontWeight: FontWeight.w900,
                          fontSize: 17),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Còn hàng",
                      style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w900,
                          fontSize: 17),
                    ),
                  ),
                ],
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  StarRating(
                    rating: 5,
                    color: Colors.yellow,
                    size: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Hotline: 0384.17.17.17",
                      style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w900,
                          fontSize: 17),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Hotline: 0974.88.81.81",
                      style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w900,
                          fontSize: 17),
                    ),
                  ),
                ],

              ),
            ],
          )),

          Center(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Expanded(
                  child: MaterialButton(
                    padding: EdgeInsets.all(0),
                    onPressed: () {
                      launch("https://zalo.me/0384171717");
                    },
                    child: Container(
                      height: 50,
                      decoration:
                          BoxDecoration(border: Border.all(color: Colors.red)),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.message,
                            color: Colors.red,
                          ),
                          Text("Chat ngay",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300))
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: MaterialButton(
                    onPressed: () async {
                      SqliteOrder sqliteOrder = new SqliteOrder();
                     await sqliteOrder.newOrder(product, 1);

                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => Order(productId: product.id,)
                      ));
                    },
                    padding: EdgeInsets.all(0),
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.red[400],
                          border: Border.all(color: Colors.red)),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.assignment,
                            color: Colors.white,
                          ),
                          Text(
                            "Mua ngay",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w300),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) => Order()));
                    },
                    padding: EdgeInsets.all(0),
                    child: Container(
                      height: 50,
                      decoration:
                          BoxDecoration(border: Border.all(color: Colors.red)),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.local_grocery_store,
                            color: Colors.red,
                          ),
                          Text("Giỏ hàng",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300))
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PageImage extends StatelessWidget {
  final String linkImages;

  const PageImage({Key key, this.linkImages}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Image(
      height: 300,
      fit: BoxFit.fitHeight,
      image: NetworkImage(linkImages),
    );
  }
}

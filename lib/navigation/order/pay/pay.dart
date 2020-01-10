import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:linh_kien17/navigation/order/pay/pay_bloc.dart';
import 'package:linh_kien17/object/product.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Pay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MultiProvider(providers: [
      ChangeNotifierProvider(
        builder: (context) => PayBloc(),
      ),
    ],
      child: PayBody(),);
  }
}

class PayBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PayBloc payBloc = Provider.of<PayBloc>(context);

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Đơn hàng của bạn"),
      ),
      body: payBloc.isLoadingPay ? Center(child: CircularProgressIndicator(),) : buildList(context: context),
    );
  }

  Widget buildEmpty() {
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
              fontWeight: FontWeight.w600, color: Colors.blue, fontSize: 17),
        ),
        SizedBox(
          height: 10,
        ),
        Text("Mua sản phẩm ngay")
      ],
    );
  }

  Widget buildList({BuildContext context}) {
    PayBloc payBloc = Provider.of<PayBloc>(context);

    List<Widget> listOrder = [];
    listOrder.clear();
    listOrder.add(buildInfo(context: context),);
   payBloc.listOrder.forEach((itemOrder) {
     listOrder.add(
         buildItemProduct(context: context,product:itemOrder["product"], quantity: itemOrder["quantity"])
     );
   });

    FlutterMoneyFormatter sum = FlutterMoneyFormatter(
        amount: payBloc.sumPrice + .0
    );


    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
            child: SingleChildScrollView(
          child: Column(
            children: listOrder,
          ),
        )),
        Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
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
                payBloc.createOrder(context: context);
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

  Widget buildInfo({BuildContext context}) {
    PayBloc payBloc = Provider.of<PayBloc>(context);
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
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: TextField(
                          onChanged: (value) async {
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            prefs.setString("name", value);
                          },
                          controller: payBloc.textEditingControllerName,
                          decoration: InputDecoration(labelText: "Tên"),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: TextField(
                          onChanged: (value) async {
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            prefs.setString("phone", value);
                          },
                          controller: payBloc.textEditingControllerPhone,
                          keyboardType: TextInputType.phone,
                          decoration:
                              InputDecoration(labelText: "Số điện thoại"),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: TextField(
                          onChanged: (value) async{
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            prefs.setString("address", value);
                          },
                          controller: payBloc.textEditingControllerAddress,
                          decoration:
                              InputDecoration(labelText: "Địa chỉ cụ thể"),
                        ),
                      ),
                    ),
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Radio(
                                onChanged: (value) {

                                  payBloc.setTypePay(value);

                                },
                                groupValue: payBloc.typePay,
                                value: "cod",
                              ),
                              Text("Thanh toán COD")
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Radio(
                                groupValue: payBloc.typePay,
                                onChanged: (value) {

                                  payBloc.setTypePay(value);

                                },
                                value: "cod2",
                              ),
                              Text("Thanh toán chuyển khoản")
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      )
    ]);
  }

  Widget buildItemProduct({BuildContext context, Product product, int quantity}) {
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
              children: <Widget>[
                Image(
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      product.linkImages),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width*0.6,
                        child: Text(
                          product.name,
                          overflow: TextOverflow.clip,
                          maxLines: 2,
                          style: TextStyle(color: Colors.black54, fontSize: 17),
                        ),
                      ),
                      Text( product.price == -1 ? "Liên hệ" : fmf.output.withoutFractionDigits.toString() + "đ"),
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

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:linh_kien17/navigation/notification/notification.dart' as prefix0;
import 'fix/fix.dart';
import 'package:linh_kien17/navigation/contact/contact.dart';
import 'package:linh_kien17/navigation/home/home.dart';
import 'package:linh_kien17/navigation/notification/notification.dart';
import 'package:linh_kien17/object/product.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'boss/boss.dart';

import 'linh_kien_navigator_bloc.dart';
import 'order/order.dart';


class LinhKienNavigation extends StatelessWidget {
  final List<Product> productsData;

  const LinhKienNavigation({Key key, this.productsData}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return MultiProvider(providers: [
      ChangeNotifierProvider(
        builder: (context) => LinhKienNavigatorBloc(productsData: productsData),
      )
    ], child: BodyLinhKienNavigationState());
  }
}

class BodyLinhKienNavigationState extends StatelessWidget {
  DateTime currentBackPressTime;
  @override
  Widget build(BuildContext context) {
    LinhKienNavigatorBloc linhKienNavigatorBloc = Provider.of<LinhKienNavigatorBloc>(context);
    final _kYab = <Widget>[
      Home(),
    //  Fix(),
      Order(),
      //Contact(),
      Boss()
      //Account()
    ];
    final _kBottom = <BottomNavigationBarItem>[
      BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
          ),
          title: Text("Trang chủ")),
//      BottomNavigationBarItem(
//          icon: Icon(
//            Icons.build,
//          ),
//          title: Text("Sửa chữa")),
      BottomNavigationBarItem(
          icon: Icon(
            Icons.local_grocery_store,
          ),
          title: Text("Giỏ hàng")),
//      BottomNavigationBarItem(
//          icon: Icon(
//            Icons.message,
//          ),
//          title: Text("Liên hệ")),
      BottomNavigationBarItem(
          icon: Icon(
            Icons.account_circle,
          ),
          title: Text("Quản lý")),
//      BottomNavigationBarItem(
//          icon: Icon(
//            Icons.assignment_ind,
//          ),
//          title: Text("Cá nhân")),
    ];
    assert(_kYab.length == _kBottom.length);
    final bottomBar = BottomNavigationBar(
      items: _kBottom,
      currentIndex: linhKienNavigatorBloc.indexTab,
      type: BottomNavigationBarType.fixed,
      onTap: (int index) {
        linhKienNavigatorBloc.setIndexTab(index);
      },
    );
    // TODO: implement build
    return Scaffold(
      body: WillPopScope(child: _kYab[linhKienNavigatorBloc.indexTab], onWillPop: onWillPop),
      bottomNavigationBar: bottomBar,
//      floatingActionButton: FloatingActionButton(
//
//        backgroundColor: Colors.white,
//        onPressed: () {
//          launch("https://zalo.me/0384171717");
//        },
//        child: Image.asset(
//          'assets/images/zalo.png',
//          width: 130.0,
//          height: 130.0,
//          fit: BoxFit.cover,
//
//        ),
//      ),
    );
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: "Nhấn thêm lần nữa để thoát");
      return Future.value(false);
    }
    return Future.value(true);
  }
}



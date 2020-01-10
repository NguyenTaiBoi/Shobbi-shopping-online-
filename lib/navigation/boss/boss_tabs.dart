import 'package:flutter/material.dart';
import 'package:linh_kien17/navigation/boss/products/products.dart';

import 'notifications/notifications.dart';
import 'orders/orders.dart';

class BossTabs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final kTabPage = <Widget>[
      AddProduct(),
      Orders(),
      Notications()
     // Center(child: Icon(Icons.build, size: 50, ),),
    ];
    final kTab = <Tab>[
      Tab(icon: Icon(Icons.list), text: "Thêm sản phẩm",),
      Tab(icon: Icon(Icons.assignment), text: "Đơn hàng",),
      Tab(icon: Icon(Icons.assignment), text: "Thông báo",),
      //Tab(icon: Icon(Icons.build), text: "Sữa chữa",)
    ];
    return DefaultTabController(
      length: kTab.length,
      child: Scaffold(
        appBar: AppBar(title: Text("Quản lý cửa hàng"),bottom: TabBar(
          tabs: kTab,
        ),),
        body: TabBarView(
          children: kTabPage,
        ),
      ),
    );
  }
}
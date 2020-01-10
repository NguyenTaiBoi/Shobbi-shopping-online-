import 'package:flutter/material.dart';
import 'package:linh_kien17/navigation/contact/contact.dart';
import 'package:linh_kien17/navigation/fix/fix.dart';
import 'package:linh_kien17/navigation/home/detail_category/detail_category.dart';
import 'package:linh_kien17/navigation/notification/notification.dart' as prefix0;
import 'package:linh_kien17/navigation/order/order.dart';
import 'package:linh_kien17/object/category.dart';
import 'package:provider/provider.dart';

import 'navigation_drawer_bloc.dart';

class NavigatorDrawer extends StatelessWidget {
  final mapList;

  const NavigatorDrawer({Key key, this.mapList}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(builder: (context) => NavigationDrawerBLoc())
      ],
      child: NavigationDrawerBody(),
    );
  }
}

class NavigationDrawerBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    NavigationDrawerBLoc navigationDrawerBLoc =
        Provider.of<NavigationDrawerBLoc>(context);
    // TODO: implement build
    return Column(
      children: <Widget>[
        SizedBox(
          height: 25,
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.redAccent,
              borderRadius: BorderRadius.all(Radius.circular(8))),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 50,
              ),
              Image.asset(
                'assets/images/logo_tran_gia.jpg',
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "shopping",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
              ),

            ],
          ),
        ),
        Divider(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: ListView.builder(
              itemBuilder: (context, index) => Column(
                children: [
                  ListTile(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    title: Row(
                      children: <Widget>[
                        Icon(
                          Icons.home,
                          color: Colors.black54,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Trang chủ",
                          style: TextStyle(color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) => Fix()));
                    },
                    title: Row(
                      children: <Widget>[
                        Icon(
                          Icons.build,
                          color: Colors.black54,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Sửa chữa",
                          style: TextStyle(color: Colors.black54),
                        ),
                      ],
                    ),
                  ),

                  Divider(),
                  ListTile(
                    onTap: () {
    Navigator.push(
    context, MaterialPageRoute(builder: (context) => Order()));

                    },
                    title: Row(
                      children: <Widget>[
                        Icon(
                          Icons.local_grocery_store,
                          color: Colors.black54,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Giỏ hàng",
                          style: TextStyle(color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) => Contact()));
                    },
                    title: Row(
                      children: <Widget>[
                        Icon(
                          Icons.announcement,
                          color: Colors.black54,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Liên hệ",
                          style: TextStyle(color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    height: 2,
                  ),
                ]..addAll(buildListCategory(context)),
              ),
              itemCount: 1,
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> buildListCategory(BuildContext context) {
    NavigationDrawerBLoc navigationDrawerBLoc =
        Provider.of<NavigationDrawerBLoc>(context);
    var listReturn = new List<Widget>();
    navigationDrawerBLoc.categorys.forEach((item) {
      if (item.parent == 0) {
        listReturn.add(item.parent == 0
            ? buildItemCheck(context, item.name, item.slug)
            : buildItemCheck(context, item.name, item.slug));

        navigationDrawerBLoc.categorys.forEach((item2) {
          if (item2.parent == item.id) {
            listReturn.add(buildItemCheck(context, item2.name, item2.slug));
          }
        });
      }
    });

    return listReturn;
  }

  Widget buildItemCheck(BuildContext context, String title, String slug) {
    return ListTile(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailCategory(
                      slug: slug,
                      title: title,
                    )));
      },
      title: Row(
        children: <Widget>[
          CircleAvatar(
            radius: 5,
            backgroundColor: Colors.redAccent,
          ),
          SizedBox(
            width: 10,
          ),
          Text(title),
        ],
      ),
    );
  }
//  Widget buildSubCategory(String title, String slug) {
//    return ListTile(
//      title: Text("      "+title),
//    );
//  }

}

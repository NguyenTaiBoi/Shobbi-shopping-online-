import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:linh_kien17/component/image_scroll.dart';
import 'package:linh_kien17/navigation/home/detail_category/detail_category.dart';
import 'package:linh_kien17/navigation/home/home_bloc.dart';
import 'package:linh_kien17/navigation/linh_kien_navigator_bloc.dart';
import 'package:linh_kien17/navigation/notification/notification.dart' as prefix0;
import 'package:linh_kien17/navigation/order/order.dart';
import 'package:linh_kien17/object/product.dart';
import 'package:linh_kien17/sqlite/product.dart';
import 'package:provider/provider.dart';

//import 'package:flutter_money_formatter/flutter_money_formatter.dart';

import 'detail_product/detail_product.dart';
import 'navigation_drawer.dart';
import 'home_bloc.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          builder: (context) => HomeBloc(),
        ),
      ],
      child: HomeBody(),
    );
  }
}

class HomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HomeBloc homeBloc = Provider.of<HomeBloc>(context);

    Map<String, dynamic> mapList = new Map<String, dynamic>();

    homeBloc.products.forEach((item) {
      if (item.category != null && item.category != "other") {
        if (mapList[item.category] != null) {
          mapList[item.category]["list"].add(item);
        } else {
          mapList[item.category] = new Map<String, dynamic>();
          mapList[item.category]["name"] = item.categoryName;
          mapList[item.category]["list"] = new List<Product>();
          mapList[item.category]["list"].add(item);
        }
      }
    });

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        centerTitle: true,
        title: TextField(
          onSubmitted: (key) {
            homeBloc.searchString = key;

            homeBloc.searchProduct();
          },
          style: TextStyle(color: Colors.grey),
          decoration: new InputDecoration(
              filled: true,

              fillColor: Colors.white,
              hintText: 'Tìm kiếm',
              contentPadding: const EdgeInsets.only(top: 15),
              focusedBorder: OutlineInputBorder(
                borderSide: new BorderSide(color: Colors.white),
                borderRadius: new BorderRadius.circular(25.7),
              ),
              enabledBorder: UnderlineInputBorder(

                borderSide: new BorderSide(color: Colors.white),
                borderRadius: new BorderRadius.circular(25.7),
              ),


             // hintText: 'Tìm kiếm',


              hintStyle: TextStyle(color: Colors.grey),
              prefixIcon: const Icon(Icons.search, color: Colors.grey,),
              prefixText: ' ',
              suffixStyle: const TextStyle(color: Colors.green)),

        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.white,),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => prefix0.Notification()
              ));
            },
          ),
          IconButton(
            icon: Icon(Icons.local_grocery_store, color: Colors.white,),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => Order()
              ));
            },
          )
        ],
      ),
      body: homeBloc.isLoadingProduct
          ? Center(child: CircularProgressIndicator())
          :
      homeBloc.searchString.length > 0 ?

      SingleChildScrollView(
        child: Wrap(
            children:listBuildProductSearch(context)
        ),
      )
          :

      ListView.builder(
              itemCount: mapList.length,
              itemBuilder: (context, index) {
                return Column(
                  children: <Widget>[
                    index == 0
                        ? ImageScroll()
                        : Container(
                            height: 5,
                          ),
                    buildCategories(
                        context: context,
                        name: mapList[mapList.keys.toList()[index].toString()]
                                ["name"]
                            .toString(),
                        products:
                            mapList[mapList.keys.toList()[index].toString()]
                                ["list"]),
                  ],
                );
              },
            ),
      drawer: Drawer(
          child: NavigatorDrawer(
        mapList: mapList,
      )),
    );
  }

 List<Widget> listBuildProductSearch(BuildContext context) {
    var list = new List<Widget>();
    HomeBloc homeBloc = Provider.of<HomeBloc>(context);
    homeBloc.productsSearch.forEach((product){
      list.add(buildProduct(context: context, product: product));

    });
    return list;
 }

  Widget buildCategories(
      {BuildContext context, String name, List<Product> products}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(7),
          color: Colors.red[400],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                name.toUpperCase(),
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
              Row(
                children: <Widget>[
                  MaterialButton(
                    elevation: 0.1,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailCategory(slug: products[0].category, title: name,)));
                    },
                    padding: EdgeInsets.all(0),
                    child: Text(
                      "Xem thêm",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                  Icon(
                    Icons.forward,
                    color: Colors.white,
                  )
                ],
              )
            ],
          ),
        ),
        Container(
            height: 210,
            width: double.infinity,
            color: Colors.white,
            child: ListView.builder(
              itemCount: products.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) =>
                  buildProduct(context: context, product: products[index]),
            ))
      ],
    );
  }

  Widget buildProduct({BuildContext context, Product product}) {
    FlutterMoneyFormatter fmf =
        FlutterMoneyFormatter(amount: product.price + .0);

    LinhKienNavigatorBloc linhKienNavigatorBloc =
        Provider.of<LinhKienNavigatorBloc>(context);
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: MaterialButton(
        padding: EdgeInsets.all(0),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailProduct(
                        product: product,
                      )));
        },
        child: Container(
          width: 110,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(7)),
              border: Border.all(color: Colors.grey[300])),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                CachedNetworkImage(
                  height: 130,
                  width: 130,
                  imageUrl: product.linkImages,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
//                Image(
//                  height: 130,
//                  width: 130,
//                  fit: BoxFit.cover,
//                  image: NetworkImage(product.linkImages),
//                ),
                Column(
                  children: <Widget>[
                    Text(product.name,
                        maxLines: 2,
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w600,
                            fontSize: 15)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(""),
                        Text(
                          product.price == -1
                              ? "Liên hệ"
                              : fmf.output.withoutFractionDigits.toString() +
                                  "đ",
                          style: TextStyle(
                              color: Colors.teal,
                              fontWeight: FontWeight.w800,
                              fontSize: 15),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

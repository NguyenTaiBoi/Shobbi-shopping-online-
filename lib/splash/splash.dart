import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:linh_kien17/navigation/linh_kien_navigator.dart';
import 'package:linh_kien17/object/category.dart';
import 'package:linh_kien17/object/product.dart';
import 'package:linh_kien17/sqlite/product.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkInterner().then((status){
      if(status)   loadData();
    });
  }

  Future<bool> checkInterner() async{
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  Future<Timer> loadData() async {
    return new Timer(Duration(seconds: 1), noLogged);
  }

  noLogged() {
    Category category = new Category();
    category.getListProduct();
    Product product = new Product();
    product.getListProduct(true).then((data) {

      if(data["status"] == true) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) {
              product.getListProduct(false);
            return  LinhKienNavigation(productsData: data["data"]);
            }

            ));
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(color: Colors.redAccent),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                   Image.asset(
                      'assets/images/logo_tran_gia.jpg',
                      width: 130.0,
                      height: 130.0,
                      fit: BoxFit.cover,

                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Shopping",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "hàng đầu tại Việt Nam",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              CircularProgressIndicator(
                backgroundColor: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}

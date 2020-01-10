import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:linh_kien17/object/product.dart';
import 'package:linh_kien17/sqlite/product.dart';
import 'package:tiengviet/tiengviet.dart';
class HomeBloc extends ChangeNotifier {
  bool isLoadingProduct;
  List<Product> products;
  List<Product> productsSearch;
  String searchString;
  List<Product> listFull;
  HomeBloc() {
    isLoadingProduct = true;
    products = [];
    listFull = [];
    searchString = "";
    productsSearch = [];
    getProducts();
    notifyListeners();
  }

  void searchProduct() {
   

    productsSearch.clear();
    if(searchString.length > 0) {

      listFull.forEach((product) {
          if (tiengviet(product.name).toLowerCase().contains(tiengviet(searchString).toLowerCase())) productsSearch.add(product);
        });

    }

  }

  void getProducts() {
    isLoadingProduct = true;
    notifyListeners();
    listFull.clear();
    SqliteProduct sqliteProduct = new SqliteProduct();
    sqliteProduct.getProducts().then((data) {
      listFull = data.reversed.toList();
      isLoadingProduct = false;
      notifyListeners();

      int i =0;
      listFull.forEach((item) {
        if(i<=50) {
          this.products.add(item);
        }
        i++;
      });

    });



    Timer(Duration(seconds: 1), (){
    });
    isLoadingProduct = false;
    notifyListeners();
  }

}
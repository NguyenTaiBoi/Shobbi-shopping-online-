import 'package:flutter/foundation.dart';
import 'package:linh_kien17/object/product.dart';
import 'package:linh_kien17/sqlite/product.dart';

class DetailCategoryBloc extends ChangeNotifier {
  List<Product> products;
  bool isLoadingProduct;
  String slug;
  String title;
  DetailCategoryBloc(String slug, String title) {
    this.slug =slug;
    this.title = title;
    isLoadingProduct = true;
    products = [];
    getProducts();
  }

  void getProducts() {
    isLoadingProduct = true;
    notifyListeners();
    this.products.clear();
    SqliteProduct sqliteProduct = new SqliteProduct();
    sqliteProduct.getProducts().then((data) {
      data = data.reversed.toList();
      data.forEach((itemProduct) {
        if(itemProduct.category == this.slug) {
          this.products.add(itemProduct);
        }
      });
      isLoadingProduct = false;
      notifyListeners();
    });
    isLoadingProduct = false;
    notifyListeners();
  }
}
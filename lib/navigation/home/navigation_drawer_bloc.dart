import 'package:flutter/cupertino.dart';
import 'package:linh_kien17/object/category.dart';
import 'package:linh_kien17/sqlite/category.dart';

class NavigationDrawerBLoc extends ChangeNotifier {
  List<Category> categorys;
  bool loadingCategorys;

  NavigationDrawerBLoc() {
    loadingCategorys = true;
    categorys = [];
    getCategory();
  }

  void getCategory() {
    loadingCategorys = true;
    notifyListeners();
      SqliteCategory sqliteCategory = new SqliteCategory();
      sqliteCategory.getCategorys().then((data) {

        categorys = data;
        loadingCategorys = false;
        notifyListeners();
      });
  }
}
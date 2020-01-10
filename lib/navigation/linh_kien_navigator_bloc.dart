import 'package:flutter/cupertino.dart';
import 'package:linh_kien17/object/product.dart';
import 'package:provider/provider.dart';
class LinhKienNavigatorBloc extends ChangeNotifier {
   List<Product> productsData;
  int indexTab;


  LinhKienNavigatorBloc({this.productsData}){
    indexTab = 0;
    notifyListeners();
  }

  void setIndexTab(int index) {
    indexTab = index;
    notifyListeners();
  }

}
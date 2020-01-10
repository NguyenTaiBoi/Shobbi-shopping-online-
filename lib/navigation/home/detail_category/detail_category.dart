import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:linh_kien17/navigation/home/detail_product/detail_product.dart';
import 'package:linh_kien17/object/product.dart';
import 'package:provider/provider.dart';

import 'detail_category_bloc.dart';

class DetailCategory extends StatelessWidget {
  final String slug;
  final String title;

  const DetailCategory({Key key, this.slug, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          builder: (context) => DetailCategoryBloc(slug,title),
        )
      ],
      child: DetailCategoryBody(),
    );
  }

}


class DetailCategoryBody extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    DetailCategoryBloc detailCategoryBloc = Provider.of<DetailCategoryBloc>(context);
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(detailCategoryBloc.title),
      ),
      body: buildCategories(context: context),
    );
  }


  Widget buildCategories(
      {BuildContext context}) {
    DetailCategoryBloc detailCategoryBloc = Provider.of<DetailCategoryBloc>(context);
    List<Widget> listBuild = List<Widget>();
    listBuild.clear();
    detailCategoryBloc.products.forEach((product){
     print( product.category);
      listBuild.add(buildProduct(context: context, product: product));

    });

    return detailCategoryBloc.isLoadingProduct ? Center(child: CircularProgressIndicator(),): SingleChildScrollView(
      child: Wrap(
        children:listBuild
      ),
    );
  }

  Widget buildProduct({BuildContext context, Product product}) {

    FlutterMoneyFormatter fmf = FlutterMoneyFormatter(
        amount: product.price + .0
    );

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
                Image(
                  height: 130,
                  width: 130,
                  fit: BoxFit.cover,
                  image: NetworkImage(product.linkImages),
                ),
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
                              : fmf.output.withoutFractionDigits.toString() + "đ",
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
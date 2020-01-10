import 'package:linh_kien17/sqlite/category.dart';
import 'package:woocommerce_api/woocommerce_api.dart';

class Category {
  int id;
  String name;
  String slug;
  int parent;
  bool status;

  SqliteCategory sqliteCategory = new SqliteCategory();
  Category({this.id, this.name, this.slug, this.parent}) {
    status = false;
  }

  Map<String, dynamic> toMapSqlite() {
    return {
      "id": id,
      "name": name,
      "slug": slug,
      "parent": parent,
    };
  }

  factory Category.fromJsonSqlite(Map<String, dynamic> json) => new Category(
    id: json["id"],
    name: json["name"],
    parent: json["parent"],
    slug: json["slug"],
  );

  static WooCommerceAPI wcAPI() {
    return new WooCommerceAPI(
        "https://nhandoi.net",
        "ck_090c6a6b389f715ed3186b2ee12ca36dfee6a680",
        "cs_cf5fb095a618c982998abc234fb121e740899560");
  }

  Future<dynamic> getListCategoryFromWooCommerceAPI(int page) async {
    var p = await wcAPI().getAsync("products/categories?page=" +page.toString() + "&per_page=100");

    return p;
  }

  factory Category.fromJson(Map<String, dynamic> item) => Category(
      id: item["id"],
      name: item["name"],
      parent: item["parent"],
      slug: item["slug"],
  );

  Future<Map<String, dynamic>> getListProduct() async {

    sqliteCategory.deleteAll();
    var dataReturn = new List<Category>();
    Map<String, dynamic> mapReturn = new Map<String, dynamic>();
    mapReturn["status"] = false;
    mapReturn["mess"] = "?";
    mapReturn["data"] = new List<Category>();

    bool hasData = true;
    int i=1;
    while(hasData){

      await getListCategoryFromWooCommerceAPI(i).then((data) {



        mapReturn["status"] = true;
        mapReturn["mess"] = "OK";
        data.forEach((item) {

          Category category =Category.fromJson(item);
          dataReturn.add(category);
          sqliteCategory.newCategory(category);

        });
        mapReturn["data"].addAll(dataReturn);


        if(data.length < 100) {
          hasData  =false;
        }
      }).catchError((err) {
        mapReturn["status"] = false;
        mapReturn["data"] = [];
        mapReturn["mess"] = err.toString();
        hasData  =false;
      });




i++;

    }


    return mapReturn;
  }


}
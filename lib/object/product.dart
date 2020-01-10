import 'dart:io';

import 'package:linh_kien17/const/global.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:linh_kien17/object/category.dart';
import 'package:linh_kien17/sqlite/product.dart';
import '../const/global.dart';
import 'package:woocommerce_api/woocommerce_api.dart';

import 'package:path/path.dart';


class Product {
  int id;
  int productId;
  String name;
  String linkImages;
  String description;
  int price;
  String category;
  String categoryName;
  SqliteProduct sqliteProduct = new SqliteProduct();

  Product(
      {this.id,
      this.productId,
      this.name,
      this.linkImages,
      this.description,
      this.categoryName,
      this.price,
      this.category});

  Map<String, dynamic> toMapSqlite() {
    return {
      "product_id": productId,
      "name": name,
      "linkImages": linkImages,
      "description": description,
      "price": price,
      "category": category,
      "categoryName": categoryName
    };
  }

  factory Product.fromJsonSqlite(Map<String, dynamic> json) => new Product(
        id: json["id"],
        productId: json["product_id"],
        name: json["name"],
        description: json["description"],
        linkImages: json["linkImages"],
        price: json["price"],
        category: json["category"],
        categoryName: json["categoryName"],
      );

  factory Product.fromJson(Map<String, dynamic> item) => Product(
      id: item["id"],
      name: item["name"],
      linkImages: item["images"][0]["src"],
      price: item["price"],
      description: item["description"],
      category: item["category"]);

  Future<Map<String, dynamic>> getListProduct(bool load) async {
    if(load) sqliteProduct.deleteAll();
    var dataReturn = new List<Product>();
    Map<String, dynamic> mapReturn = new Map<String, dynamic>();
    mapReturn["status"] = false;
    mapReturn["mess"] = "?";
    mapReturn["data"] = new List<Product>();

    bool hasData = true;
    int i;
    load ? i=1:i=2;
    while(hasData){

      await getListProductFromWooCommerceAPI(i).then((data) {
        mapReturn["status"] = true;
        mapReturn["mess"] = "OK";

        data.forEach((item) {
          var listImages = new List<String>();
          item["images"].forEach((imageItem) {
            listImages.add(imageItem["src"]);
          });

          var listCategory = new List<Category>();
          item["categories"].forEach((categoryItem) {
            if (categoryItem["name"] == null) categoryItem["name"] = "Khác";
            if (categoryItem["slug"] == null) categoryItem["slug"] = "other";
            listCategory.add(new Category(
                id: categoryItem["id"],
                name: categoryItem["name"],
                slug: categoryItem["slug"]));
          });
          if (listCategory.isEmpty) {
            listCategory.add(new Category(id: 0, name: "Khác", slug: "other"));
          }
          Product product = new Product(
              id: item["id"],
              productId: item["id"],
              name: item["name"],
              linkImages: listImages[0],
              description: item["description"],
              price: item["price"] == "" ? -1 : int.parse(item["price"]),
              category: listCategory[0].slug,
              categoryName: listCategory[0].name);

          sqliteProduct.newProduct(product);

          dataReturn.add(product);

        });

        mapReturn["data"].addAll(dataReturn);

        if(data.length < 100) {
          hasData  =false;
          print(i);

        }
      }).catchError((err) {
        mapReturn["status"] = false;
        mapReturn["data"] = [];
        mapReturn["mess"] = err.toString();
        hasData  =false;
      });

      i++;

      if(load && i==2) {
        return mapReturn;
      }
    }


    return mapReturn;
  }

  static WooCommerceAPI wcAPI() {
    return new WooCommerceAPI(
        "https://nhandoi.net",
        "ck_090c6a6b389f715ed3186b2ee12ca36dfee6a680",
        "cs_cf5fb095a618c982998abc234fb121e740899560");
  }

  Future<dynamic> getListProductFromWooCommerceAPI(int page) async {
    var p = await wcAPI().getAsync("products?page=" + page.toString() + "&per_page=100");

    return p;
  }

  @override
  String toString() {
    // return productId.toString() + name + linkImages.toString() + price.toString() + category + "";
    return categoryName.toString();
  }

  Future<dynamic> createOrderFromWooCommerceAPI(
      {String name,
      String phone,
      String address,
      List<Map<String, dynamic>> mapProducts}) async {
    var p = await wcAPI().postAsync("orders", {
      "status": "processing",
      "billing": {
        "first_name": name,
//          "last_name": "tran",
//          "company": "trangiakc",
        "address_1": address,
        "address_2": "",
//          "city": "Hồ chí minh",
//          "state": "",
//          "postcode": "700000KC",
//          "country": "VN",
//          "email": "Kukha9307@hh.cc",
        "phone": phone
      },
      "payment_method": "cod",
      "payment_method_title": "Trả tiền mặt khi nhận hàng",
      "line_items": mapProducts

//        [
//          {
//            "name": "Cảm Ứng Alcatel OT 6030",
//            "product_id": 511,
//            "variation_id": 0,
//            "quantity": 1,
//          },
//          {
//            "name": "Cảm ứng Acer B1",
//            "product_id": 505,
//            "variation_id": 0,
//            "quantity": 1,
//          },
//        ]
    });

    return p;
  }

  Future<dynamic> createProductFromWooCommerceAPI(
      {String name, String description, File image, int money, String masp, String hangsx, String xuatxu, String baohanh,List<Map<String,dynamic>> listMapCategory, List<String> listColor}) async {
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('admin:1236655226'));
    print('pending');
    final length = await image.length();
    final request = new http.MultipartRequest(
        'POST', Uri.parse('https://nhandoi.net/wp-json/wp/v2/media'))
      ..files.add(new http.MultipartFile('file', image.openRead(), length, filename: basename(image.path)))
      ..headers['authorization'] = basicAuth;

    http.Response response =
        await http.Response.fromStream(await request.send());

  //  var img = json.decode(response.body);

        var p = await wcAPI().postAsync("products", {
      "name": name,
     // "type": "simple",
      "regular_price": money.toString(),
     // "stock_status": "instock",
//      "description": description,
//          "images": [
//            {
//              "src": img["guid"]["rendered"]
//            }
//          ],



    });


    return p;
  }
}

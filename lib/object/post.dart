import 'dart:convert';

import 'package:linh_kien17/sqlite/category.dart';
import 'package:woocommerce_api/woocommerce_api.dart';
import 'package:http/http.dart' as http;

class Post {
  int id;
  List<dynamic> categories;
  String title;
  String content;


  Post({this.id, this.categories, this.title, this.content});


  static WooCommerceAPI wcAPI() {
    return new WooCommerceAPI(
        "https://nhandoi.net",
        "ck_6be6bce8688ed80f2d9682b67257553bea412f47",
        "cs_32458ad1c1a4571f5e3971e84c25891e75562179");
  }

  Future<dynamic> getListPosts() async {
    List<Post> listRT = [];
//    var p = await wcAPI().getAsync("posts");
var response = await http.get('http://nhandoi.net/wp-json/wp/v2/posts/');
if(response.statusCode == 200) {
  var bodyJson = json.decode(response.body);

  bodyJson.forEach((item){
    listRT.add(new Post.fromJson(item));
  });
}

    return listRT;
  }

  factory Post.fromJson(Map<String, dynamic> item) => Post(
    id: item["id"],
    title: item["title"]["rendered"],
    content: item["content"]["rendered"],
    categories: item["categories"],
  );


  void uploadNotification(String title, String content, Function onSuccess) async{
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('admin:1236655226'));
    var response = await http.post('http://nhandoi.net/wp-json/wp/v2/posts/', body: {
      "title": title,
      "content":content,
      "status": "publish",
      "categories":"278"
    },

    headers: {"authorization" : basicAuth});
    if(response.body!=null) {
      onSuccess();
    }
  }


}
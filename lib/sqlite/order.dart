import 'dart:io';

import 'package:http/http.dart';
import 'package:linh_kien17/navigation/order/order.dart';
import 'package:linh_kien17/object/order.dart';
import 'package:linh_kien17/object/product.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();
}

class SqliteOrder {

  static Database _database;

  Future<Database> get database async {
    if (_database != null)
      return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "order.db");
    return await openDatabase(path, version: 1, onOpen: (db) {
    }, onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE IF NOT EXISTS Order_Items (id INTEGER PRIMARY KEY, product_id INTEGER, quantity INTEGER)");
    });
  }

  newOrder(Product product, int quantity) async {

    final db = await database;
    var res1 =await  db.query("Order_Items", where: "product_id = ?", whereArgs: [product.productId]);
    if (res1.isNotEmpty) {

      var res = await db.update("Order_Items", {
        "quantity":quantity
      },
          where: "product_id = ?", whereArgs: [product.productId]);
      return res;

    }else {
      var res = await db.insert("Order_Items", {
        "product_id":product.productId,
        "quantity":quantity
      });
      return res;
    }


  }

  updateOrder(Product product, int quantity) async {
    final db = await database;
    var res = await db.update("Order_Items", {
      "product_id":product.productId,
      "quantity":quantity
    },
        where: "product_id = ?", whereArgs: [product.id]);
    return res;
  }

  Future<bool> getOrderByProductId(int id) async {
    final db = await database;
    var res =await  db.query("Order_Items", where: "product_id = ?", whereArgs: [id]);
    return res.isNotEmpty ? true : false ;
  }

  deleteAll() async {
    final db = await database;
    db.rawDelete("Delete from Order_Items");
  }

  deleteOrder(int idProduct) async {
    final db = await database;
    db.delete("Order_Items", where: "product_id = ?", whereArgs: [idProduct]);
  }

  Future<List<OrderProduct>> getOrders() async {
    final db = await database;
    var res = await db.query("Order_Items");

    List<OrderProduct> list =
    res.isNotEmpty ? res.map((c) => OrderProduct.fromJson(c)).toList() : [];
    return list;
  }


}
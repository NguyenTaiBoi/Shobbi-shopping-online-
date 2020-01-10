import 'dart:io';

import 'package:http/http.dart';
import 'package:linh_kien17/object/product.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();
}

class SqliteProduct {

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
    String path = join(documentsDirectory.path, "product.db");
    return await openDatabase(path, version: 1, onOpen: (db) {
    }, onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE IF NOT EXISTS Products (id INTEGER PRIMARY KEY, product_id INTEGER, name NVARCHAR, linkImages NVARCHAR, description NVARCHAR, price INTEGER, category NVARCHAR, categoryName NVARCHAR)");
    });
  }

  newProduct(Product product) async {
    final db = await database;
    var res = await db.insert("Products", product.toMapSqlite());
    return res;
  }

  Future<bool> getProductsByProductId(int id) async {
    final db = await database;
    var res =await  db.query("Products", where: "product_id = ?", whereArgs: [id]);
    return res.isNotEmpty ? true : false ;
  }

  deleteAll() async {
    final db = await database;
    await db.rawDelete("DELETE FROM Products");
  }

  deleteProduct(int id) async {
    final db = await database;
    db.delete("Products", where: "product_id = ?", whereArgs: [id]);
  }

  Future<List<Product>> getProducts() async {
    final db = await database;
    var res = await db.query("Products");
    List<Product> list =
    res.isNotEmpty ? res.map((c) => Product.fromJsonSqlite(c)).toList() : [];
    return list;
  }

  Future<List<Product>> getProductByProductId({int productId}) async {
    final db = await database;
    var res = await db.query("Products",where: "product_id = ?", whereArgs: [productId]);
    List<Product> list =
    res.isNotEmpty ? res.map((c) => Product.fromJsonSqlite(c)).toList() : [];
    return list;
  }


}
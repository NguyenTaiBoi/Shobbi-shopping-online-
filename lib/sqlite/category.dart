import 'dart:io';

import 'package:http/http.dart';
import 'package:linh_kien17/object/category.dart';
import 'package:linh_kien17/object/product.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();
}

class SqliteCategory {

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
    String path = join(documentsDirectory.path, "category.db");
    return await openDatabase(path, version: 1, onOpen: (db) {
    }, onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE IF NOT EXISTS Categorys (id INTEGER PRIMARY KEY, name NVARCHAR, slug NVARCHAR, parent INTEGER)");
    });
  }

  newCategory(Category category) async {
    final db = await database;
    var res = await db.insert("Categorys", category.toMapSqlite());
    return res;
  }

  Future<bool> getCategoryByCategoryId(int id) async {
    final db = await database;
    var res =await  db.query("Categorys", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? true : false ;
  }

  deleteAll() async {
    final db = await database;
    await db.rawDelete("DELETE FROM Categorys");
  }

  deleteCategory(int id) async {
    final db = await database;
    db.delete("Categorys", where: "id = ?", whereArgs: [id]);
  }

  Future<List<Category>> getCategorys() async {
    final db = await database;
    var res = await db.query("Categorys");
    List<Category> list =
    res.isNotEmpty ? res.map((c) => Category.fromJsonSqlite(c)).toList() : [];
    return list;
  }

  Future<List<Category>> getProductByProductId({int id}) async {
    final db = await database;
    var res = await db.query("Categorys",where: "id = ?", whereArgs: [id]);
    List<Category> list =
    res.isNotEmpty ? res.map((c) => Category.fromJsonSqlite(c)).toList() : [];
    return list;
  }


}
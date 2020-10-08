import 'package:NewsPaper/model/Model.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

abstract class FavoriteHelper {

//  FavoriteHelper() {
//    init();
//  }

  static Database _db;
  static int get _version => 1;

  static Future<void> init() async {
    if (_db != null) { return; }
    try {
      String _path = await getDatabasesPath() + 'favorite.db';
      _db = await openDatabase(_path, version: _version, onCreate: onCreate);
    } catch(ex) {
      print(ex);
    }
  }

  static void onCreate(Database db, int version) async => await db.execute('CREATE TABLE favorites(id INTEGER PRIMARY KEY AUTOINCREMENT,paper_id INTEGER, title TEXT, image TEXT,url TEXT)');

  static Future<List<Map<String, dynamic>>> query(String table) async => _db.query(table);

  static Future<int> insert(String table, Model model) async => await _db.insert(table, model.toMap());

  static Future getPaperPresent(String table, int id) async => await _db.query(table, where: 'paper_id = ?', whereArgs: [id]);

  static Future<int> update(String table, Model model) async => await _db.update(table, model.toMap(), where: 'id = ?', whereArgs: [model.id]);

  static Future<int> delete(String table, int id) async => await _db.delete(table, where: 'id = ?', whereArgs: [id]);

}
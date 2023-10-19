import '../model/ShoppingList.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  Database? _database;

  DBHelper() {
    _openDB();
  }

  Future<void> _openDB() async {
    // await deleteDatabase(
    //     join(await getDatabasesPath(), 'shopinglist_database.db'));
    _database = await openDatabase(
      join(await getDatabasesPath(), 'shopinglist_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE shopping_list (id INTEGER PRIMARY KEY, name TEXT, sum INTEGER)',
        );
      },
      version: 1,
    );
  }

  Future<List<ShoppingList>> getmyShopingList() async {
    if (_database != null) {
      final List<Map<String, dynamic>> maps =
          await _database!.query('shopping_list');
      print("Isi DB" + maps.toString());
      return List.generate(maps.length, (i) {
        return ShoppingList(maps[i]['id'], maps[i]['name'], maps[i]['sum']);
      });
    }
    return [];
  }

  Future<void> insertShoppingList(ShoppingList tmp) async {
    await _database?.insert(
      'shopping_list',
      tmp.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteShoppingList(int id) async {
    await _database?.delete(
      'shopping_list',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> closeDB() async {
    await _database?.close();
  }

  Future<void> clearAll() async {
    await _database?.delete('shopping_list');
  }
}

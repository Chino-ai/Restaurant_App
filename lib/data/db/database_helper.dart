import 'package:restaurant_app/data/model/get_restaurants.dart';
import 'package:sqflite/sqflite.dart';

import '../model/search_restaurants.dart';

class DatabaseHelper{
  static DatabaseHelper? _instance;
  static Database? _database;

  DatabaseHelper._internal(){
    _instance = this;
  }

  factory DatabaseHelper() => _instance ?? DatabaseHelper._internal();

  static const String _tblresto = 'resto';


  Future<Database> _initializeDb() async{
    var path = await getDatabasesPath();
    var db = openDatabase(
      '$path/restoapp.db',
      onCreate: (db, version) async{
        await db.execute('''CREATE TABLE $_tblresto (
             id TEXT PRIMARY KEY,
             name TEXT,
             description TEXT,
             pictureId TEXT,
             city TEXT,
             rating REAL
           )     
        ''');
      },
      version: 2
    );
    return db;

  }

  Future<Database?> get database async{
    if(_database == null){
      _database = await _initializeDb();
    }

    return _database;
  }
  Future<void> insertResto(SRestaurant restaurant) async {
    final db = await database;
    await db!.insert(_tblresto, restaurant.toJson());
  }

  Future<List<SRestaurant>> getResto() async {
    final db = await database;
    List<Map<String, dynamic>> results = await db!.query(_tblresto);

    return results.map((res) => SRestaurant.fromJson(res)).toList();
  }

  Future<Map> getFavouriteById(String id) async {
    final db = await database;

    List<Map<String, dynamic>> results = await db!.query(
      _tblresto,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return {};
    }
  }

  Future<void> removeFavourite(String id) async {
    final db = await database;

    await db!.delete(
      _tblresto,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
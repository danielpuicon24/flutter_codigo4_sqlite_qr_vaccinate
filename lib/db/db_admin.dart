import 'dart:io';

import 'package:flutter_codigo4_sqflite_qr/models/carnet_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBAdmin{
  Database? _myDatabase;
  static final DBAdmin db = DBAdmin._();

  DBAdmin._();

  Future<Database?> getDatabase() async {
    if (_myDatabase != null) return _myDatabase;
    _myDatabase = await initDB();
    return _myDatabase;
  }

  Future<Database> initDB() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentDirectory.path, "CarnetDB.db");
    return openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
          await db.execute(
              "CREATE TABLE CARNET(id INTEGER PRIMARY KEY AUTOINCREMENT, fullName TEXT, dni TEXT, url TEXT)");
        });
  }

  Future<List<CarnetModel>> getCarnetList() async {
    final db = await getDatabase();
    List<Map<String, dynamic>> res = await db!.query("CARNET");
    // List<CarnetModel> lista = [];
    // for(var item in res){
    //   lista.add(
    //     CarnetModel.fromJson(item);
    //   );
    // }
    List<CarnetModel> carnets = res.isNotEmpty
        ? res.map<CarnetModel>((e) => CarnetModel.fromJson(e)).toList()
        : [];
    return carnets;
  }

  Future<int> insertCarnet(CarnetModel carnet) async {
    final db = await getDatabase();
    int res = await db!.insert(
      "CARNET",
      carnet.toJson(),
    );
    return res;
  }

}
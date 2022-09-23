import 'package:soal_app/core/database/databd_config.dart';
import 'package:soal_app/src/models/Requerimientos/request_model.dart';
import 'package:sqflite/sqlite_api.dart';

class RequestDatabase {
  final dbprovider = DatabaseHelper.instance;

  Future<void> insertRequest(RequestModel requestModel) async {
    try {
      final Database db = await dbprovider.getDatabase();

      await db.insert(
        'Requests',
        requestModel.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print("$e Error en la tabla Requests");
    }
  }

  Future<List<RequestModel>> getRequets() async {
    try {
      final Database db = await dbprovider.getDatabase();
      List<RequestModel> list = [];
      List<Map> maps = await db.rawQuery("SELECT * FROM Requests");

      if (maps.length > 0) list = RequestModel.fromJsonList(maps);
      return list;
    } catch (e) {
      print(" $e Error en la base de datos Requests");
      return [];
    }
  }

  Future<List<RequestModel>> getRequetsByStatus(String status) async {
    try {
      final Database db = await dbprovider.getDatabase();
      List<RequestModel> list = [];
      List<Map> maps = await db.rawQuery("SELECT * FROM Requests WHERE requestStatus='$status'");

      if (maps.length > 0) list = RequestModel.fromJsonList(maps);
      return list;
    } catch (e) {
      print(" $e Error en la base de datos Requests");
      return [];
    }
  }

  deleteByStatus(String status) async {
    final db = await dbprovider.database;

    final res = await db.rawDelete("DELETE FROM Requests WHERE requestStatus='$status'");

    return res;
  }
}

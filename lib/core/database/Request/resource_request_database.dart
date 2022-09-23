import 'package:soal_app/core/database/databd_config.dart';
import 'package:soal_app/src/models/Requerimientos/resourse_request_model.dart';
import 'package:sqflite/sqlite_api.dart';

class ResourceRequestDatabase {
  final dbprovider = DatabaseHelper.instance;

  Future<void> insertResourceRequest(ResourseRequestModel resourceModel) async {
    try {
      final Database db = await dbprovider.getDatabase();

      await db.insert(
        'ResourseRequest',
        resourceModel.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print("$e Error en la tabla ResourseRequest");
    }
  }

  Future<List<ResourseRequestModel>> getResourceRequetsByIdRequest(String requestID) async {
    try {
      final Database db = await dbprovider.getDatabase();
      List<ResourseRequestModel> list = [];
      List<Map> maps = await db.rawQuery("SELECT * FROM ResourseRequest WHERE requestID='$requestID'");

      if (maps.length > 0) list = ResourseRequestModel.fromJsonList(maps);
      return list;
    } catch (e) {
      print(" $e Error en la base de datos ResourseRequest");
      return [];
    }
  }

  deleteByStatus(String status) async {
    final db = await dbprovider.database;

    final res = await db.rawDelete("DELETE FROM ResourseRequest WHERE resourceStatus='1'");

    return res;
  }
}

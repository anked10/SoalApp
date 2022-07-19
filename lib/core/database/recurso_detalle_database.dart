import 'package:soal_app/core/database/databd_config.dart';
import 'package:soal_app/src/models/recurso_detalle_oc_model.dart';
import 'package:sqflite/sqlite_api.dart';

class RecursoDetalleOCDB {
  final dbprovider = DatabaseHelper.instance;

  Future<void> insertarDetalleOC(RecursoDetalleOCModel detalle) async {
    try {
      final Database db = await dbprovider.getDatabase();

      await db.insert(
        'RecursoDetalleOC',
        detalle.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print("$e Error en la tabla RecursoDetalleOC");
    }
  }

  Future<List<RecursoDetalleOCModel>> getdetalleOCByIdOC(String idOC) async {
    try {
      final Database db = await dbprovider.getDatabase();
      List<RecursoDetalleOCModel> list = [];
      List<Map> maps = await db.rawQuery("SELECT * FROM RecursoDetalleOC WHERE idOC='$idOC'");

      if (maps.length > 0) list = RecursoDetalleOCModel.fromJsonList(maps);
      return list;
    } catch (e) {
      print(" $e Error en la base de datos RecursoDetalleOC");
      return [];
    }
  }

  deleteAll() async {
    final db = await dbprovider.database;

    final res = await db.rawDelete("DELETE FROM RecursoDetalleOC");

    return res;
  }
}

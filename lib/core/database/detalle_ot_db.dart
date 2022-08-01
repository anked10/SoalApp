import 'package:soal_app/core/database/databd_config.dart';
import 'package:soal_app/src/models/detalle_ot_model.dart';
import 'package:sqflite/sqlite_api.dart';

class DetalleOTDB {
  final dbprovider = DatabaseHelper.instance;

  Future<void> insertarDetalleOT(DetalleOTModel detalle) async {
    try {
      final Database db = await dbprovider.getDatabase();

      await db.insert(
        'DetalleOT',
        detalle.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print("$e Error en la tabla DetalleOT");
    }
  }

  Future<List<DetalleOTModel>> getdetalleOCByIdOT(String idOT) async {
    try {
      final Database db = await dbprovider.getDatabase();
      List<DetalleOTModel> list = [];
      List<Map> maps = await db.rawQuery("SELECT * FROM DetalleOT WHERE idOT='$idOT'");

      if (maps.length > 0) list = DetalleOTModel.fromJsonList(maps);
      return list;
    } catch (e) {
      print(" $e Error en la base de datos DetalleOT");
      return [];
    }
  }

  deleteAll() async {
    final db = await dbprovider.database;

    final res = await db.rawDelete("DELETE FROM DetalleOT");

    return res;
  }
}

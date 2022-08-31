import 'package:soal_app/core/database/databd_config.dart';
import 'package:soal_app/src/models/pagos_model.dart';
import 'package:sqflite/sqlite_api.dart';

class PagosDB {
  final dbprovider = DatabaseHelper.instance;

  Future<void> insertarPago(PagosModel pago) async {
    try {
      final Database db = await dbprovider.getDatabase();

      await db.insert(
        'Pagos',
        pago.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print("$e Error en la tabla Pagos");
    }
  }

  Future<List<PagosModel>> getPagosyIdOC(String idOC) async {
    try {
      final Database db = await dbprovider.getDatabase();
      List<PagosModel> list = [];
      List<Map> maps = await db.rawQuery("SELECT * FROM Pagos WHERE idOC='$idOC'");

      if (maps.length > 0) list = PagosModel.fromJsonList(maps);
      return list;
    } catch (e) {
      print(" $e Error en la base de datos Pagos");
      return [];
    }
  }

  deleteOCByIdOC(String idOC) async {
    final db = await dbprovider.database;

    final res = await db.rawDelete("DELETE FROM Pagos WHERE idOC='$idOC'");

    return res;
  }
}

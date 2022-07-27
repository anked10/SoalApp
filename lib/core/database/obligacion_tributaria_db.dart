import 'package:soal_app/core/database/databd_config.dart';
import 'package:soal_app/src/models/obligacion_tributaria_model.dart';
import 'package:sqflite/sqlite_api.dart';

class ObligacionTributariaDB {
  final dbprovider = DatabaseHelper.instance;

  Future<void> insertarOT(ObligacionTributariaModel ot) async {
    try {
      final Database db = await dbprovider.getDatabase();

      await db.insert(
        'ObligacionTributaria',
        ot.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print("$e Error en la tabla ObligacionTributaria");
    }
  }

  Future<List<ObligacionTributariaModel>> getOTPendientes() async {
    try {
      final Database db = await dbprovider.getDatabase();
      List<ObligacionTributariaModel> list = [];
      List<Map> maps = await db.rawQuery("SELECT * FROM ObligacionTributaria WHERE estadoObligacion='0'");

      if (maps.length > 0) list = ObligacionTributariaModel.fromJsonList(maps);
      return list;
    } catch (e) {
      print(" $e Error en la base de datos OrdenCompraNew");
      return [];
    }
  }

  Future<List<ObligacionTributariaModel>> buscarOTPendientes(String query) async {
    try {
      final Database db = await dbprovider.getDatabase();
      List<ObligacionTributariaModel> list = [];
      List<Map> maps = await db.rawQuery(
          "SELECT * FROM ObligacionTributaria WHERE estadoObligacion='0' AND (nombreProyectoOC LIKE '%$query%' OR nombreProveedor LIKE '%$query%' OR rucProveedor LIKE '%$query%' OR nombreEmpresa LIKE '%$query%' OR nombreSede LIKE '%$query%' OR nameCreateOC LIKE '%$query%' OR dateTimeCreateOC LIKE '%$query%' OR totalOC LIKE '%$query%') ");

      if (maps.length > 0) list = ObligacionTributariaModel.fromJsonList(maps);
      return list;
    } catch (e) {
      print(" $e Error en la base de datos ObligacionTributaria");
      return [];
    }
  }

  Future<List<ObligacionTributariaModel>> getOTByID(String idObligacion) async {
    try {
      final Database db = await dbprovider.getDatabase();
      List<ObligacionTributariaModel> list = [];
      List<Map> maps = await db.rawQuery("SELECT * FROM ObligacionTributaria WHERE idObligacion='$idObligacion'");

      if (maps.length > 0) list = ObligacionTributariaModel.fromJsonList(maps);
      return list;
    } catch (e) {
      print(" $e Error en la base de datos ObligacionTributaria");
      return [];
    }
  }

  deleteAll() async {
    final db = await dbprovider.database;

    final res = await db.rawDelete("DELETE FROM ObligacionTributaria");

    return res;
  }

  deleteAllByEstado(String estado) async {
    final db = await dbprovider.database;

    final res = await db.rawDelete("DELETE FROM ObligacionTributaria WHERE estadoObligacion='$estado'");

    return res;
  }
}

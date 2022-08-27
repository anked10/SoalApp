import 'package:soal_app/core/database/databd_config.dart';
import 'package:soal_app/src/models/orden_compra_model.dart';
import 'package:sqflite/sqlite_api.dart';

class OrdenCompraDB {
  final dbprovider = DatabaseHelper.instance;

  Future<void> insertarOrdenCompra(OrdenCompraNewModel ordenCompraModel) async {
    try {
      final Database db = await dbprovider.getDatabase();

      await db.insert(
        'OrdenCompraNew',
        ordenCompraModel.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print("$e Error en la tabla OrdenCompraNew");
    }
  }

  Future<List<OrdenCompraNewModel>> getOCPendientes() async {
    try {
      final Database db = await dbprovider.getDatabase();
      List<OrdenCompraNewModel> list = [];
      List<Map> maps = await db.rawQuery("SELECT * FROM OrdenCompraNew WHERE estadoOC='0'");

      if (maps.length > 0) list = OrdenCompraNewModel.fromJsonList(maps);
      return list;
    } catch (e) {
      print(" $e Error en la base de datos OrdenCompraNew");
      return [];
    }
  }

  Future<List<OrdenCompraNewModel>> getOCGeneradas() async {
    try {
      final Database db = await dbprovider.getDatabase();
      List<OrdenCompraNewModel> list = [];
      List<Map> maps = await db.rawQuery("SELECT * FROM OrdenCompraNew WHERE estadoOC='1'");

      if (maps.length > 0) list = OrdenCompraNewModel.fromJsonList(maps);
      return list;
    } catch (e) {
      print(" $e Error en la base de datos OrdenCompraNew");
      return [];
    }
  }

  Future<List<OrdenCompraNewModel>> buscarOCPendientes(String query) async {
    try {
      final Database db = await dbprovider.getDatabase();
      List<OrdenCompraNewModel> list = [];
      List<Map> maps = await db.rawQuery(
          "SELECT * FROM OrdenCompraNew WHERE estadoOC='0' AND (nombreProyectoOC LIKE '%$query%' OR nombreProveedor LIKE '%$query%' OR rucProveedor LIKE '%$query%' OR nombreEmpresa LIKE '%$query%' OR nombreSede LIKE '%$query%' OR nameCreateOC LIKE '%$query%' OR surnameCreateOC LIKE '%$query%' OR dateTimeCreateOC LIKE '%$query%' OR totalOC LIKE '%$query%') ");

      if (maps.length > 0) list = OrdenCompraNewModel.fromJsonList(maps);
      return list;
    } catch (e) {
      print(" $e Error en la base de datos OrdenCompraNew");
      return [];
    }
  }

  Future<List<OrdenCompraNewModel>> getOCByID(String idOC) async {
    try {
      final Database db = await dbprovider.getDatabase();
      List<OrdenCompraNewModel> list = [];
      List<Map> maps = await db.rawQuery("SELECT * FROM OrdenCompraNew WHERE idOC='$idOC'");

      if (maps.length > 0) list = OrdenCompraNewModel.fromJsonList(maps);
      return list;
    } catch (e) {
      print(" $e Error en la base de datos OrdenCompraNew");
      return [];
    }
  }

  deleteAll() async {
    final db = await dbprovider.database;

    final res = await db.rawDelete("DELETE FROM OrdenCompraNew");

    return res;
  }

  deleteAllByEstado(String estado) async {
    final db = await dbprovider.database;

    final res = await db.rawDelete("DELETE FROM OrdenCompraNew WHERE estadoOC='$estado'");

    return res;
  }
}

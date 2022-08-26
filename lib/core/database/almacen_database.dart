import 'package:soal_app/core/database/databd_config.dart';
import 'package:soal_app/src/models/almacenModel.dart';
import 'package:sqflite/sqlite_api.dart';

class AlmacenDatabase {
  final dbprovider = DatabaseHelper.instance;

  Future<void> insertarAlmacenes(AlmacenModel almacenModel) async {
    try {
      final Database db = await dbprovider.getDatabase();

      await db.insert(
        'Almacen',
        almacenModel.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      /*  await db.rawInsert("INSERT OR REPLACE INTO Category (idCategory,categoryName,categoryEstado,categoryImage) "
          "VALUES('${category.banco1}', '${category.banco1}', '${category.banco1}', '${category.banco1}')"); */
    } catch (e) {
      print("$e Error en la tabla Almacen");
    }
  }

  Future<List<AlmacenModel>> getAlmacenPorSede(String idSede) async {
    try {
      final Database db = await dbprovider.getDatabase();
      List<AlmacenModel> list = [];
      List<Map> maps = await db.rawQuery("SELECT * FROM Almacen where idSede='$idSede' AND recursoEstado='1'");

      if (maps.length > 0) list = AlmacenModel.fromJsonList(maps);
      return list;
    } catch (e) {
      print(" $e Error en la base de datos Almacen");
      return [];
    }
  }

  Future<List<AlmacenModel>> getStockAlmacen(String value) async {
    String query = "SELECT * FROM Almacen WHERE recursoEstado='1'";
    if (value.isNotEmpty) query += " AND recursoNombre LIKE '%$value%'";
    try {
      final Database db = await dbprovider.getDatabase();
      List<AlmacenModel> list = [];
      List<Map> maps = await db.rawQuery(query);

      if (maps.length > 0) list = AlmacenModel.fromJsonList(maps);
      return list;
    } catch (e) {
      print(" $e Error en la base de datos Almacen");
      return [];
    }
  }

  Future<List<AlmacenModel>> getAlmacenQuery(String value) async {
    try {
      final Database db = await dbprovider.getDatabase();
      List<AlmacenModel> list = [];
      List<Map> maps = await db.rawQuery("SELECT * FROM Almacen where recursoNombre like '%$value%' AND recursoEstado='1'");

      if (maps.length > 0) list = AlmacenModel.fromJsonList(maps);
      return list;
    } catch (e) {
      print(" $e Error en la base de datos");
      return [];
    }
  }

  Future<List<AlmacenModel>> getAlmacenByIdAndQuery(String idSede, String value) async {
    String query = "SELECT * FROM Almacen WHERE idSede='$idSede' AND recursoEstado='1'";
    if (value.isNotEmpty) query += " AND recursoNombre LIKE '%$value%'";
    try {
      final Database db = await dbprovider.getDatabase();
      List<AlmacenModel> list = [];
      List<Map> maps = await db.rawQuery(query);

      if (maps.length > 0) list = AlmacenModel.fromJsonList(maps);
      return list;
    } catch (e) {
      print(" $e Error en la base de datos");
      return [];
    }
  }

  deleteAll() async {
    final db = await dbprovider.database;

    final res = await db.rawDelete("DELETE FROM Almacen");

    return res;
  }
}

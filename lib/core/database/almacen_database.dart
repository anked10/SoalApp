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
      List<Map> maps = await db.rawQuery("SELECT * FROM Almacen where idSede='$idSede'");

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
      List<Map> maps = await db.rawQuery("SELECT * FROM Almacen where recursoNombre like '%$value%' or recursoCodigo like '%$value%'");

      if (maps.length > 0) list = AlmacenModel.fromJsonList(maps);
      return list;
    } catch (e) {
      print(" $e Error en la base de datos");
      return [];
    }
  }
}

import 'package:soal_app/core/database/databd_config.dart';
import 'package:soal_app/src/models/sedesModel.dart';
import 'package:sqflite/sqlite_api.dart';

class SedesDatabase {
  final dbprovider = DatabaseHelper.instance;

  Future<void> insertarSedes(SedesModel sedesModel) async {
    try {
      final Database db = await dbprovider.getDatabase();

      await db.insert(
        'Sedes',
        sedesModel.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      /*  await db.rawInsert("INSERT OR REPLACE INTO Category (idCategory,categoryName,categoryEstado,categoryImage) "
          "VALUES('${category.banco1}', '${category.banco1}', '${category.banco1}', '${category.banco1}')"); */
    } catch (e) {
      print("$e Error en la tabla Sedes");
    }
  }

  Future<List<SedesModel>> getSedes() async {
    try {
      final Database db = await dbprovider.getDatabase();
      List<SedesModel> list = [];
      List<Map> maps = await db.rawQuery("SELECT * FROM Sedes");

      if (maps.length > 0) list = SedesModel.fromJsonList(maps);
      return list;
    } catch (e) {
      print(" $e Error en la base de datos Sedes");
      return [];
    }
  }
  Future<List<SedesModel>> getSedesForName(String nombre ) async {
    try {
      final Database db = await dbprovider.getDatabase();
      List<SedesModel> list = [];
      List<Map> maps = await db.rawQuery("SELECT * FROM Sedes where sedeNombre ='$nombre'");

      if (maps.length > 0) list = SedesModel.fromJsonList(maps);
      return list;
    } catch (e) {
      print(" $e Error en la base de datos Sedes");
      return [];
    }
  }
}

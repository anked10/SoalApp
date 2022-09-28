import 'package:soal_app/core/database/databd_config.dart';
import 'package:soal_app/src/models/Rqhse/incidencia_model.dart';
import 'package:sqflite/sqlite_api.dart';

class IncidenciasDatabase {
  final dbprovider = DatabaseHelper.instance;

  Future<void> insertIncidencia(IncidenciaModel incidencia) async {
    try {
      final Database db = await dbprovider.getDatabase();

      await db.insert(
        'Incidencias',
        incidencia.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print("$e Error en la tabla Incidencias");
    }
  }

  Future<List<IncidenciaModel>> getIncidencias() async {
    try {
      final Database db = await dbprovider.getDatabase();
      List<IncidenciaModel> list = [];
      List<Map> maps = await db.rawQuery("SELECT * FROM Incidencias");

      if (maps.length > 0) list = IncidenciaModel.fromJsonList(maps);
      return list;
    } catch (e) {
      print(" $e Error en la base de datos Incidencias");
      return [];
    }
  }

  Future<List<IncidenciaModel>> getRequetsById(String idIncidencia) async {
    try {
      final Database db = await dbprovider.getDatabase();
      List<IncidenciaModel> list = [];
      List<Map> maps = await db.rawQuery("SELECT * FROM Incidencias WHERE idIncidencia='$idIncidencia'");

      if (maps.length > 0) list = IncidenciaModel.fromJsonList(maps);
      return list;
    } catch (e) {
      print(" $e Error en la base de datos Incidencias");
      return [];
    }
  }

  deleteAll() async {
    final db = await dbprovider.database;

    final res = await db.rawDelete("DELETE FROM Incidencias");

    return res;
  }
}

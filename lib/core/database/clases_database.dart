import 'package:soal_app/src/models/clases_model.dart';
import 'package:sqflite/sqlite_api.dart';

import 'databd_config.dart';

class ClasesDatabase {
  final dbprovider = DatabaseHelper.instance;

  Future<void> insertarClases(ClasesModel clasesModel) async {
    try {
      final Database db = await dbprovider.getDatabase();

      await db.insert(
        'Clase',
        clasesModel.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
     
     } catch (e) {
      print("$e Error en la tabla Clase");
    }
  }

  Future<List<ClasesModel>> getClases() async {
    try {
      final Database db = await dbprovider.getDatabase();
      List<ClasesModel> list = [];
      List<Map> maps = await db.rawQuery("SELECT * FROM Clase");

      if (maps.length > 0) list = ClasesModel.fromJsonList(maps);
      return list;
    } catch (e) {
      print(" $e Error en la  tabla Clase");
      return [];
    }
  }

  Future<List<ClasesModel>> getClaseaForType(String type) async {
    try {
      final Database db = await dbprovider.getDatabase();
      List<ClasesModel> list = [];
      List<Map> maps = await db.rawQuery("SELECT * FROM Clase where idLogisticaTipo ='$type'");

      if (maps.length > 0) list = ClasesModel.fromJsonList(maps);
      return list;
    } catch (e) {
      print(" $e Error en la  tabla Clase");
      return [];
    }
  }



  Future<List<ClasesModel>> getClasesForId(String id) async {
    try {
      final Database db = await dbprovider.getDatabase();
      List<ClasesModel> list = [];
      List<Map> maps = await db.rawQuery("SELECT * FROM Clase where idLogisticaClase= '$id'");

      if (maps.length > 0) list = ClasesModel.fromJsonList(maps);
      return list;
    } catch (e) {
      print(" $e Error en la  tabla Clases");
      return [];
    }
  }



  Future<List<ClasesModel>> getClasesForName(String name) async {
    try {
      final Database db = await dbprovider.getDatabase();
      List<ClasesModel> list = [];
      List<Map> maps = await db.rawQuery("SELECT * FROM Clase where logisticaClaseNombre= '$name'");

      if (maps.length > 0) list = ClasesModel.fromJsonList(maps);
      return list;
    } catch (e) {
      print(" $e Error en la  tabla Clases");
      return [];
    }
  }
}

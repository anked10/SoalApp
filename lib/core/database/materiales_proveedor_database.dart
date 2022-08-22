import 'package:soal_app/core/database/databd_config.dart';
import 'package:soal_app/src/models/materiales_proveedor_model.dart';
import 'package:sqflite/sqlite_api.dart';

class MaterialesProveedorDatabase {
  final dbprovider = DatabaseHelper.instance;

  Future<void> insertMaterial(MaterialesProveedorModel material) async {
    try {
      final Database db = await dbprovider.getDatabase();

      await db.insert(
        'MaterialesProveedor',
        material.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print("$e Error en la tabla MaterialesProveedor");
    }
  }

  Future<List<MaterialesProveedorModel>> getMaterialsProveedorById(String idProveedor) async {
    try {
      final Database db = await dbprovider.getDatabase();
      List<MaterialesProveedorModel> list = [];
      List<Map> maps = await db.rawQuery("SELECT * FROM MaterialesProveedor WHERE idProveedor='$idProveedor' ORDER BY recursoCodigo");

      if (maps.length > 0) list = MaterialesProveedorModel.fromJsonList(maps);
      return list;
    } catch (e) {
      print(" $e Error en la base de datos MaterialesProveedor");
      return [];
    }
  }

  deleteMaterials() async {
    final db = await dbprovider.database;

    final res = await db.rawDelete("DELETE FROM MaterialesProveedor");

    return res;
  }

  deleteMaterialsProveedorById(String idProveedor) async {
    final db = await dbprovider.database;

    final res = await db.rawDelete("DELETE FROM MaterialesProveedor WHERE idProveedor='$idProveedor'");

    return res;
  }
}

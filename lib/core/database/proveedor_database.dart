import 'package:soal_app/src/models/proveedores_model.dart';
import 'package:sqflite/sqlite_api.dart';

import 'databd_config.dart';

class ProveedoresDatabase {
  final dbprovider = DatabaseHelper.instance;

  Future<void> insertarProveedor(ProveedorModel category) async {
    try {
      final Database db = await dbprovider.getDatabase();

      await db.insert(
        'Proveedores',
        category.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
     /*  await db.rawInsert("INSERT OR REPLACE INTO Category (idCategory,categoryName,categoryEstado,categoryImage) "
          "VALUES('${category.banco1}', '${category.banco1}', '${category.banco1}', '${category.banco1}')"); */
    } catch (e) {
      print("$e Error en la tabla ProveedorModel");
    }
  }

  Future<List<ProveedorModel>> getProveedores() async {
    try {
      final Database db = await dbprovider.getDatabase();
      List<ProveedorModel> list = [];
      List<Map> maps = await db.rawQuery("SELECT * FROM Proveedores");

      if (maps.length > 0) list = ProveedorModel.fromJsonList(maps);
      return list;
    } catch (e) {
      print(" $e Error en la base de datos");
      return [];
    }
  }



  Future<List<ProveedorModel>> getProveedoresQuery(String value) async {
    try {
      final Database db = await dbprovider.getDatabase();
      List<ProveedorModel> list = [];
      List<Map> maps = await db.rawQuery("SELECT * FROM Proveedores where nombre like '%$value%'");

      if (maps.length > 0) list = ProveedorModel.fromJsonList(maps);
      return list;
    } catch (e) {
      print(" $e Error en la base de datos");
      return [];
    }
  }
}




import 'package:soal_app/core/database/databd_config.dart';
import 'package:soal_app/src/models/detalle_op_model.dart'; 
import 'package:sqflite/sqlite_api.dart';

class DetalleOpDatabase{



  final dbprovider = DatabaseHelper.instance;

  Future<void> insertarDetalleOp(DetalleOpModel detalleOpModel) async {
    try {
      final Database db = await dbprovider.getDatabase();

      await db.insert(
        'DetalleOr',
        detalleOpModel.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      /*  await db.rawInsert("INSERT OR REPLACE INTO Category (idCategory,categoryName,categoryEstado,categoryImage) "
          "VALUES('${category.banco1}', '${category.banco1}', '${category.banco1}', '${category.banco1}')"); */
    } catch (e) {
      print("$e Error en la tabla DetalleOpModel");
    }
  }

  Future<List<DetalleOpModel>> getDetalleOp(String idOp) async {
    try {
      final Database db = await dbprovider.getDatabase();
      List<DetalleOpModel> list = [];
      List<Map> maps = await db.rawQuery("SELECT * FROM DetalleOr where idOp = '$idOp'");

      if (maps.length > 0) list = DetalleOpModel.fromJsonList(maps);
      return list;
    } catch (e) {
      print(" $e Error en la base de datos DetalleOpModel");
      return [];
    }
  }


  
}
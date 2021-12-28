


import 'package:soal_app/core/database/databd_config.dart';
import 'package:soal_app/src/models/detalle_si_model.dart';
import 'package:sqflite/sqlite_api.dart';

class DetalleSiDatabase{



  final dbprovider = DatabaseHelper.instance;

  Future<void> insertarDetalleSi(DetalleSiModel detalleSiModel) async {
    try {
      final Database db = await dbprovider.getDatabase();

      await db.insert(
        'DetalleSoli',
        detalleSiModel.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      /*  await db.rawInsert("INSERT OR REPLACE INTO Category (idCategory,categoryName,categoryEstado,categoryImage) "
          "VALUES('${category.banco1}', '${category.banco1}', '${category.banco1}', '${category.banco1}')"); */
    } catch (e) {
      print("$e Error en la tabla detalleSiModel");
    }
  }

  Future<List<DetalleSiModel>> getDetalleSi(String idSi) async {
    try {
      final Database db = await dbprovider.getDatabase();
      List<DetalleSiModel> list = [];
      List<Map> maps = await db.rawQuery("SELECT * FROM DetalleSoli where idSi = '$idSi'");

      if (maps.length > 0) list = DetalleSiModel.fromJsonList(maps);
      return list;
    } catch (e) {
      print(" $e Error en la base de datos DetalleSoli");
      return [];
    }
  }


  
}
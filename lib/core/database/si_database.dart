import 'package:soal_app/core/database/databd_config.dart';
import 'package:soal_app/src/models/si_model.dart';
import 'package:sqflite/sqlite_api.dart';

class SiDatabase {
  final dbprovider = DatabaseHelper.instance;

  Future<void> insertarSi(SiModel siModel) async {
    try {
      final Database db = await dbprovider.getDatabase();

      await db.insert(
        'SolicitudCompra',
        siModel.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      /*  await db.rawInsert("INSERT OR REPLACE INTO Category (idCategory,categoryName,categoryEstado,categoryImage) "
          "VALUES('${category.banco1}', '${category.banco1}', '${category.banco1}', '${category.banco1}')"); */
    } catch (e) {
      print("$e Error en la tabla SolicitudCompra");
    }
  }

  Future<List<SiModel>> getSi() async {
    try {
      final Database db = await dbprovider.getDatabase();
      List<SiModel> list = [];
      List<Map> maps = await db.rawQuery("SELECT * FROM SolicitudCompra");

      if (maps.length > 0) list = SiModel.fromJsonList(maps);
      return list;
    } catch (e) {
      print(" $e Error en la base de datos SolicitudCompra");
      return [];
    }
  }
}

import 'package:soal_app/core/database/databd_config.dart';
import 'package:soal_app/src/models/orden_compra_mode.dart';
import 'package:sqflite/sqlite_api.dart';

class OrdenCompraDatabase {
  final dbprovider = DatabaseHelper.instance;

  Future<void> insertarOrdenCompra(OrdenCompraModel ordenCompraModel) async {
    try {
      final Database db = await dbprovider.getDatabase();

      await db.insert(
        'OrdenCompra',
        ordenCompraModel.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      /*  await db.rawInsert("INSERT OR REPLACE INTO Category (idCategory,categoryName,categoryEstado,categoryImage) "
          "VALUES('${category.banco1}', '${category.banco1}', '${category.banco1}', '${category.banco1}')"); */
    } catch (e) {
      print("$e Error en la tabla ordenCompraModel");
    }
  }

  Future<List<OrdenCompraModel>> getOP() async {
    try {
      final Database db = await dbprovider.getDatabase();
      List<OrdenCompraModel> list = [];
      List<Map> maps = await db.rawQuery("SELECT * FROM OrdenCompra");

      if (maps.length > 0) list = OrdenCompraModel.fromJsonList(maps);
      return list;
    } catch (e) {
      print(" $e Error en la base de datos OrdenCompra");
      return [];
    }
  }
}

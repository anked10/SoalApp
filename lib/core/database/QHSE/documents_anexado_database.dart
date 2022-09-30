import 'package:soal_app/core/database/databd_config.dart';
import 'package:soal_app/src/models/Rqhse/documentos_anexados_model.dart';
import 'package:sqflite/sqlite_api.dart';

class DocumentsAnexadoDatabase {
  final dbprovider = DatabaseHelper.instance;

  Future<void> insertDoc(DocumentsAnexadosModel doc) async {
    try {
      final Database db = await dbprovider.getDatabase();

      await db.insert(
        'DocumentsAnexo',
        doc.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print("$e Error en la tabla DocumentsAnexo");
    }
  }

  Future<List<DocumentsAnexadosModel>> getDocRequetsById(String idIncidencia) async {
    try {
      final Database db = await dbprovider.getDatabase();
      List<DocumentsAnexadosModel> list = [];
      List<Map> maps = await db.rawQuery("SELECT * FROM DocumentsAnexo WHERE idIncidencia='$idIncidencia'");

      if (maps.length > 0) list = DocumentsAnexadosModel.fromJsonList(maps);
      return list;
    } catch (e) {
      print(" $e Error en la base de datos DocumentsAnexo");
      return [];
    }
  }

  deleteAll() async {
    final db = await dbprovider.database;

    final res = await db.rawDelete("DELETE FROM DocumentsAnexo");

    return res;
  }
}

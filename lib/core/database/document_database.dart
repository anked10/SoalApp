import 'package:soal_app/core/database/databd_config.dart';
import 'package:soal_app/src/models/documento_model.dart';
import 'package:sqflite/sqlite_api.dart';

class DocumentosDatabase {
  final dbprovider = DatabaseHelper.instance;

  Future<void> insertarDocumentos(DocumentoModel documentoModel) async {
    try {
      final Database db = await dbprovider.getDatabase();

      await db.insert(
        'Documentos',
        documentoModel.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print("$e Error en la tabla Documentos");
    }
  }

  /*



Para documentos proveedores: Consultas en la tabla documentos_varios, donde documento_clase = 1 y id_tipo es el id del proveedor
En adjuntos de solicitud de compras es igual, sólo que documento_clase = 3 y el id_tipo es el id de la solicitud de compra

*/
  Future<List<DocumentoModel>> getDocumentosPorTipoYClase(String tipo, String clase) async {
    try {
      final Database db = await dbprovider.getDatabase();
      List<DocumentoModel> list = [];
      List<Map> maps = await db.rawQuery("SELECT * FROM Documentos where documentoClase = '$clase' AND idTipo = '$tipo' ");

      if (maps.length > 0) list = DocumentoModel.fromJsonList(maps);
      return list;
    } catch (e) {
      print(" $e Error en la  tabla Documentos");
      return [];
    }
  }

  deleteDocumentos() async {
    final db = await dbprovider.database;

    final res = await db.rawDelete("DELETE FROM Documentos");

    return res;
  }
}

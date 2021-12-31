import 'package:soal_app/core/database/databd_config.dart';
import 'package:soal_app/src/models/documento_oc_model.dart';
import 'package:sqflite/sqlite_api.dart';

class DocumentosOcDatabase {
  final dbprovider = DatabaseHelper.instance;

  Future<void> insertarDocumentosOc(DocumentoOCModel documentoOCModel) async {
    try {
      final Database db = await dbprovider.getDatabase();

      await db.insert(
        'DocumentosOrdenDeCompra',
        documentoOCModel.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print("$e Error en la tabla documentoOCModel");
    }
  }

  /*



Para documentos proveedores: Consultas en la tabla documentos_varios, donde documento_clase = 1 y id_tipo es el id del proveedor
En adjuntos de solicitud de compras es igual, sólo que documento_clase = 3 y el id_tipo es el id de la solicitud de compra

*/
  Future<List<DocumentoOCModel>> getDocumentosDocumentoPorOC(String idOp) async {
    try {
      final Database db = await dbprovider.getDatabase();
      List<DocumentoOCModel> list = [];
      List<Map> maps = await db.rawQuery("SELECT * FROM DocumentosOrdenDeCompra where idOp = '$idOp'  ");

      if (maps.length > 0) list = DocumentoOCModel.fromJsonList(maps);
      return list;
    } catch (e) {
      print(" $e Error en la  tabla documentoOCModel");
      return [];
    }
  }
}

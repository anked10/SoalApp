import 'package:soal_app/core/database/document_database.dart';
import 'package:soal_app/src/api/documentos_api.dart';
import 'package:soal_app/src/models/documento_model.dart';
import 'package:rxdart/rxdart.dart';

class DocumentosBloc {
  final documentosDatabase = DocumentosDatabase();
  final documentosApi = DocumentosApi();

  final _documentController = BehaviorSubject<List<DocumentoModel>>();

  Stream<List<DocumentoModel>> get documentStream => _documentController.stream;

  dispose() {
    _documentController.close();
  }

  void obtenerDocumentos(String clase, String tipo) async {
    _documentController.sink.add(await documentosDatabase.getDocumentosPorTipoYClase(tipo, clase));
    await documentosApi.getDocumentos();
    _documentController.sink.add(await documentosDatabase.getDocumentosPorTipoYClase(tipo, clase));
  }
}





import 'package:soal_app/core/database/documentoOrdenesdeCompraDatabase.dart';
import 'package:soal_app/src/api/documento_oc_api.dart';
import 'package:soal_app/src/models/documento_oc_model.dart';
import 'package:rxdart/rxdart.dart';

class DocumentoOCBloc{


  final documentosOcDatabase = DocumentosOcDatabase();
  final documentosOCApi = DocumentosOCApi();

  final _documentosOCController = BehaviorSubject<List<DocumentoOCModel>>();

  Stream<List<DocumentoOCModel>> get documentodOCStream => _documentosOCController.stream;

  dispose() {
    _documentosOCController.close();
  }

  void obtenerDocumentos(String idOp) async {
    _documentosOCController.sink.add(await documentosOcDatabase.getDocumentosDocumentoPorOC(idOp));
    await documentosOCApi.getDocumentosOC();
    _documentosOCController.sink.add(await  documentosOcDatabase.getDocumentosDocumentoPorOC(idOp));
  }
}

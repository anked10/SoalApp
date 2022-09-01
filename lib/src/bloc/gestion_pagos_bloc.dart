import 'package:soal_app/src/api/gestion_pagos_api.dart';
import 'package:rxdart/rxdart.dart';
import 'package:soal_app/src/models/pagos_model.dart';

class GestionPagosBloc {
  final _api = GestionPagosApi();

  final _documentosPagosOCController = BehaviorSubject<List<PagosModel>>();
  Stream<List<PagosModel>> get docsPagosOCStream => _documentosPagosOCController.stream;

  final _cargandoController = BehaviorSubject<bool>();
  Stream<bool> get cargandoStream => _cargandoController.stream;

  dispose() {
    _documentosPagosOCController.close();
    _cargandoController.close();
  }

  void getDocumentosOC(String idOC, String tipoDoc) async {
    _documentosPagosOCController.sink.add(await _api.pagosDB.getPagosyIdOC(idOC, tipoDoc));
    _cargandoController.sink.add(true);
    (tipoDoc == '1') ? await _api.getPagosOC(idOC) : await _api.getRendicionesPagosOC(idOC);
    _cargandoController.sink.add(false);
    _documentosPagosOCController.sink.add(await _api.pagosDB.getPagosyIdOC(idOC, tipoDoc));
  }
}

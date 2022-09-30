import 'package:rxdart/rxdart.dart';
import 'package:soal_app/src/api/QHSE/qhse_api.dart';
import 'package:soal_app/src/models/Rqhse/documentos_anexados_model.dart';
import 'package:soal_app/src/models/Rqhse/incidencia_model.dart';

class QHSEBloc {
  final _api = QHSEApi();

  final _incidenciasPendientesController = BehaviorSubject<List<IncidenciaModel>>();
  Stream<List<IncidenciaModel>> get incidenciasStream => _incidenciasPendientesController.stream;

  final _incidenciasDocmentsController = BehaviorSubject<List<DocumentsAnexadosModel>>();
  Stream<List<DocumentsAnexadosModel>> get docsIncidenciasStream => _incidenciasDocmentsController.stream;

  final _cargandoController = BehaviorSubject<bool>();
  Stream<bool> get cargandoMStream => _cargandoController.stream;

  dispose() {
    _incidenciasPendientesController.close();
    _cargandoController.close();
    _incidenciasDocmentsController.close();
  }

  void getIncidenciasPendientes() async {
    _incidenciasPendientesController.sink.add(await _api.incidenciaDB.getIncidencias());
    _cargandoController.sink.add(true);
    await _api.getIncidenciasPendientes();
    _cargandoController.sink.add(false);
    _incidenciasPendientesController.sink.add(await _api.incidenciaDB.getIncidencias());
  }

  void getDocumentsByIdIncidencia(String idIncidencia) async {
    _incidenciasDocmentsController.sink.add(await _api.docAnexoDB.getDocRequetsById(idIncidencia));
  }
}

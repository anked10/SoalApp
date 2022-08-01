import 'package:soal_app/src/api/obligacion_tributaria_api.dart';
import 'package:soal_app/src/models/detalle_ot_model.dart';
import 'package:soal_app/src/models/obligacion_tributaria_model.dart';
import 'package:rxdart/rxdart.dart';

class OTBloc {
  final _api = ObligacionTributariaApi();

  final _otPendientesController = BehaviorSubject<List<ObligacionTributariaModel>>();
  Stream<List<ObligacionTributariaModel>> get otPendientesStream => _otPendientesController.stream;

  final _searchOTPendientesController = BehaviorSubject<List<ObligacionTributariaModel>>();
  Stream<List<ObligacionTributariaModel>> get searchOTPendientesStream => _searchOTPendientesController.stream;

  final _detalleOTController = BehaviorSubject<List<DetalleOTModel>>();
  Stream<List<DetalleOTModel>> get detalleOTStream => _detalleOTController.stream;

  //Controlador para mostrar que se está cargando la consulta
  final _cargandoController = BehaviorSubject<bool>();
  Stream<bool> get cargandoStream => _cargandoController.stream;

  dispose() {
    _otPendientesController.close();
    _cargandoController.close();
    _detalleOTController.close();
    _searchOTPendientesController.close();
  }

  void getOTPendientes() async {
    _otPendientesController.sink.add(await _api.otDB.getOTPendientes());
    _cargandoController.sink.add(true);
    await _api.getOTPendientes();
    _cargandoController.sink.add(false);
    _otPendientesController.sink.add(await _api.otDB.getOTPendientes());
  }

  void getDetalleOT(String idObligacion) async {
    _detalleOTController.sink.add(await _api.detalleOTDB.getdetalleOCByIdOT(idObligacion));
  }

  void searchOTPendientes(String query) async {
    if (query.isEmpty) {
      _searchOTPendientesController.sink.add(await _api.otDB.getOTPendientes());
    } else {
      _searchOTPendientesController.sink.add(await _api.otDB.buscarOTPendientes(query));
    }
  }
}

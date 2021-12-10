import 'package:rxdart/rxdart.dart';
import 'package:soal_app/src/api/proveedores_api.dart';
import 'package:soal_app/src/models/proveedores_model.dart';

class ProveedoresBloc {
  final proveedoresApi = ProveedoresApi();
  final _proveedoresController = BehaviorSubject<List<ProveedorModel>>();

  Stream<List<ProveedorModel>> get proveedoresStream => _proveedoresController.stream;

  dispose() {
    _proveedoresController.close();
  }

  void obtenerProveedores() async {
    //_galeriaController.sink.add(await negociosDatabase.obtenerGaleriaNegocios(id));
    await proveedoresApi.obtenerProveedores();
    // _galeriaController.sink.add(await negociosDatabase.obtenerGaleriaNegocios(id));
  }
}

import 'package:rxdart/rxdart.dart';
import 'package:soal_app/core/database/proveedor_database.dart';
import 'package:soal_app/src/api/proveedores_api.dart';
import 'package:soal_app/src/models/proveedores_model.dart';

class ProveedoresBloc {
  final proveedoresApi = ProveedoresApi();
  final proveedoresDatabase = ProveedoresDatabase();
  final _proveedoresController = BehaviorSubject<List<ProveedorModel>>();

  Stream<List<ProveedorModel>> get proveedoresStream => _proveedoresController.stream;

  dispose() {
    _proveedoresController.close();
  }

  void obtenerProveedores() async {
    _proveedoresController.sink.add(await proveedoresDatabase.getProveedores());
    await proveedoresApi.obtenerProveedores();
    _proveedoresController.sink.add(await proveedoresDatabase.getProveedores());
  }
}

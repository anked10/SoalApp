import 'package:rxdart/rxdart.dart';
import 'package:soal_app/core/database/proveedor_database.dart';
import 'package:soal_app/src/models/proveedores_model.dart';

class BusquedaProveedorBloc {
  final proveedoresDatabase = ProveedoresDatabase();
  final _busquedaProveedoresController = BehaviorSubject<List<ProveedorModel>>();

  Stream<List<ProveedorModel>> get busquedaProveedoresStream => _busquedaProveedoresController.stream;

  dispose() {
    _busquedaProveedoresController.close();
  }

  void obtenerProveedorPorQueryDelivery(String query) async {
    _busquedaProveedoresController.sink.add(await proveedoresDatabase.getProveedoresQuery(query));
  }
}

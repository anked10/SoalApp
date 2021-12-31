import 'package:soal_app/core/database/orden_compra_database.dart';
import 'package:soal_app/src/api/orden_compra_api.dart';
import 'package:rxdart/rxdart.dart';
import 'package:soal_app/src/models/orden_compra_mode.dart';

class OrdenCompraBloc {
  final ordenCompraApi = OrdenCompraApi();
  final ordenCompraDatabase = OrdenCompraDatabase();

  final _opController = BehaviorSubject<List<OrdenCompraModel>>();

  Stream<List<OrdenCompraModel>> get opStream => _opController.stream;

  dispose() {
    _opController.close();
  }

  void obtenerOp() async {
    _opController.sink.add(await ordenCompraDatabase.getOP());
    await ordenCompraApi.getOrdenCompra();
    _opController.sink.add(await ordenCompraDatabase.getOP());
  }
}

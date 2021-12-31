import 'package:soal_app/core/database/detalle_op_database.dart';
import 'package:soal_app/src/models/detalle_op_model.dart';
import 'package:rxdart/rxdart.dart';

class DetalleOpBloc {
  final detalleOpDatabase = DetalleOpDatabase();

  final _detalleOpController = BehaviorSubject<List<DetalleOpModel>>();

  Stream<List<DetalleOpModel>> get detalleOpStream => _detalleOpController.stream;

  dispose() {
    _detalleOpController.close();
  }

  void obtenerDetalleSi(String idOp) async {
    _detalleOpController.sink.add(
      await detalleOpDatabase.getDetalleOp(idOp),
    );
  }
}

import 'package:soal_app/core/database/detalle_si_database.dart';
import 'package:soal_app/src/models/detalle_si_model.dart';
import 'package:rxdart/rxdart.dart';

class DetalleSiBloc {
  final detalleSiDatabase = DetalleSiDatabase();

  final _detalleSiController = BehaviorSubject<List<DetalleSiModel>>();

  Stream<List<DetalleSiModel>> get detalleSiStream => _detalleSiController.stream;

  dispose() {
    _detalleSiController.close();
  }

  void obtenerDetalleSi(String idSi) async {
    _detalleSiController.sink.add(
      await detalleSiDatabase.getDetalleSi(idSi),
    );
  }
}

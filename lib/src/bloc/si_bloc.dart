import 'package:soal_app/core/database/si_database.dart';
import 'package:soal_app/src/api/si_api.dart';
import 'package:soal_app/src/models/si_model.dart';
import 'package:rxdart/rxdart.dart';

class SiBloc {
  final siApi = SiApi();
  final siDatabase = SiDatabase();

  final _siController = BehaviorSubject<List<SiModel>>();

  Stream<List<SiModel>> get siStream => _siController.stream;

  dispose() {
    _siController.close();
  }

  void obtenerSi() async {
    _siController.sink.add(await siDatabase.getSi());
    await siApi.getSI();
    _siController.sink.add(await siDatabase.getSi());
  }
}

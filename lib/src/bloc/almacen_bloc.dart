import 'package:soal_app/core/database/almacen_database.dart';
import 'package:soal_app/core/database/sedes_database.dart';
import 'package:soal_app/src/api/almacen_api.dart';
import 'package:soal_app/src/models/almacenModel.dart';
import 'package:rxdart/rxdart.dart';
import 'package:soal_app/src/models/sedesModel.dart';

class AlmacenBloc {
  final almacenAPi = AlmacenApi();
  final almacenDatabase = AlmacenDatabase();
  final sedesDatabase = SedesDatabase();

  final _almacenController = BehaviorSubject<List<AlmacenModel>>();
  final _sedesController = BehaviorSubject<List<SedesModel>>();
  final _busquedaAlmacenController = BehaviorSubject<List<AlmacenModel>>();

  Stream<List<AlmacenModel>> get almacenStream => _almacenController.stream;
  Stream<List<SedesModel>> get sedesStream => _sedesController.stream;
  Stream<List<AlmacenModel>> get busquedaAlmacenStream => _busquedaAlmacenController.stream;

  dispose() {
    _almacenController.close();
    _sedesController.close();
    _busquedaAlmacenController.close();
  }

  void getAlmacenPorSede(String idSede) async {
    _almacenController.sink.add(await almacenDatabase.getAlmacenPorSede(idSede));
    await almacenAPi.getAlmacenes();
    _almacenController.sink.add(await almacenDatabase.getAlmacenPorSede(idSede));
  }

  void getSedes() async {
    final listsedes = await sedesDatabase.getSedes();

    if (listsedes.length < 0) {
      await almacenAPi.getAlmacenes();
    }
    _sedesController.sink.add(await sedesDatabase.getSedes());
  }

  void obtenerAlmacenPorQueryDelivery(String query) async {
   
    _busquedaAlmacenController.sink.add(await almacenDatabase.getAlmacenQuery(query));
  }
}

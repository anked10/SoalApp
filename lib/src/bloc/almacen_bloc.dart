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
  final _stockRecursoAlmacenController = BehaviorSubject<List<AlmacenModel>>();
  final _sedesController = BehaviorSubject<List<SedesModel>>();
  final _busquedaAlmacenController = BehaviorSubject<List<AlmacenModel>>();

  Stream<List<AlmacenModel>> get almacenStream => _almacenController.stream;
  Stream<List<AlmacenModel>> get stockRecursoAlmacenStream => _stockRecursoAlmacenController.stream;
  Stream<List<SedesModel>> get sedesStream => _sedesController.stream;
  Stream<List<AlmacenModel>> get busquedaAlmacenStream => _busquedaAlmacenController.stream;

  final _cargandoController = BehaviorSubject<bool>();
  Stream<bool> get cargandoStream => _cargandoController.stream;

  dispose() {
    _almacenController.close();
    _sedesController.close();
    _busquedaAlmacenController.close();
    _stockRecursoAlmacenController.close();
    _cargandoController.close();
  }

  void getAlmacenPorSede(String idSede) async {
    _almacenController.sink.add(await almacenDatabase.getAlmacenPorSede(idSede));
    await almacenAPi.getAlmacenes();
    _almacenController.sink.add(await almacenDatabase.getAlmacenPorSede(idSede));
  }

  void getStockAlmacen(String idSede) async {
    _stockRecursoAlmacenController.sink.add(await getStockAlmacenSede(idSede));
    _cargandoController.sink.add(true);
    await almacenAPi.getStockRecursoAlmacenes();
    _cargandoController.sink.add(false);
    _stockRecursoAlmacenController.sink.add(await getStockAlmacenSede(idSede));
    // if (idSede.isNotEmpty) {
    //   _stockRecursoAlmacenController.sink.add(await almacenDatabase.getAlmacenPorSede(idSede));
    // } else {
    //   _stockRecursoAlmacenController.sink.add(await almacenDatabase.getStockAlmacen());
    // }
  }

  void getSedes() async {
    final listsedes = await sedesDatabase.getSedes();

    if (listsedes.length == 0) {
      await almacenAPi.getAlmacenes();
    }
    _sedesController.sink.add(await sedesDatabase.getSedes());
  }

  void obtenerAlmacenPorQueryDelivery(String query) async {
    _busquedaAlmacenController.sink.add(await almacenDatabase.getAlmacenQuery(query));
  }

  Future<List<AlmacenModel>> getStockAlmacenSede(String idSede) async {
    final listrecursosDB = (idSede.isEmpty) ? await almacenDatabase.getStockAlmacen() : await almacenDatabase.getAlmacenPorSede(idSede);

    if (listrecursosDB.isEmpty) return [];

    final List<AlmacenModel> listResult = [];

    for (var i = 0; i < listrecursosDB.length; i++) {
      final almacen = AlmacenModel();

      final resSede = await sedesDatabase.getSedesById(listrecursosDB[i].idSede!);

      almacen.idAlmacen = listrecursosDB[i].idAlmacen;
      almacen.idSede = listrecursosDB[i].idSede;
      almacen.idRecurso = listrecursosDB[i].idRecurso;
      almacen.almacenUnidad = listrecursosDB[i].almacenUnidad;
      almacen.almacenStock = listrecursosDB[i].almacenStock;
      almacen.almacenDescripcion = listrecursosDB[i].almacenDescripcion;
      almacen.idLogisticaClase = listrecursosDB[i].idLogisticaClase;
      almacen.idEmpresa = listrecursosDB[i].idEmpresa;
      almacen.recursoTipo = listrecursosDB[i].recursoTipo;
      almacen.recursoNombre = listrecursosDB[i].recursoNombre;
      almacen.recursoCodigo = listrecursosDB[i].recursoCodigo;
      almacen.recursoComentario = listrecursosDB[i].recursoComentario;
      almacen.recursoFoto = listrecursosDB[i].recursoFoto;
      almacen.recursoEstado = listrecursosDB[i].recursoEstado;
      almacen.idLogisticaTipo = listrecursosDB[i].idLogisticaTipo;
      almacen.logisticaClaseNombre = listrecursosDB[i].logisticaClaseNombre;
      almacen.logisticaTipoNombre = listrecursosDB[i].logisticaTipoNombre;
      almacen.sedeNombre = resSede[0].sedeNombre;

      listResult.add(almacen);
    }

    return listResult;
  }
}

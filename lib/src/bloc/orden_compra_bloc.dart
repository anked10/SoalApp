import 'package:soal_app/core/database/orden_compra_database.dart';
import 'package:soal_app/src/api/orden_compra_api.dart';
import 'package:rxdart/rxdart.dart';
import 'package:soal_app/src/models/orden_compra_mode.dart';
import 'package:soal_app/src/models/orden_compra_model.dart';

class OrdenCompraBloc {
  final ordenCompraApi = OrdenCompraApi();
  final ordenCompraDatabase = OrdenCompraDatabase();

  final _opController = BehaviorSubject<List<OrdenCompraModel>>();
  Stream<List<OrdenCompraModel>> get opStream => _opController.stream;

  final _ocPendientesController = BehaviorSubject<List<OrdenCompraNewModel>>();
  Stream<List<OrdenCompraNewModel>> get ocPendientesStream => _ocPendientesController.stream;

  final _detalleOCController = BehaviorSubject<List<OrdenCompraNewModel>>();
  Stream<List<OrdenCompraNewModel>> get detalleOCStream => _detalleOCController.stream;

  //Controlador para motrar que se está cargando la consulta
  final _cargandoController = BehaviorSubject<bool>();
  Stream<bool> get cargandoStream => _cargandoController.stream;

  dispose() {
    _opController.close();
    _ocPendientesController.close();
    _cargandoController.close();
    _detalleOCController.close();
  }

  void obtenerOp() async {
    _opController.sink.add(await ordenCompraDatabase.getOP());
    await ordenCompraApi.getOrdenCompra();
    _opController.sink.add(await ordenCompraDatabase.getOP());
  }

  void ocPendientes() async {
    _ocPendientesController.sink.add(await ordenCompraApi.ocDB.getOCPendientes());
    _cargandoController.sink.add(true);
    await ordenCompraApi.getOrdenCompraPendientes();
    _cargandoController.sink.add(false);
    _ocPendientesController.sink.add(await ordenCompraApi.ocDB.getOCPendientes());
  }

  void detalleOC(String idOC) async {
    _detalleOCController.sink.add(await _getDetalle(idOC));
  }

  Future<List<OrdenCompraNewModel>> _getDetalle(String idOC) async {
    final List<OrdenCompraNewModel> result = [];
    final res = await ordenCompraApi.ocDB.getOCByID(idOC);

    if (res.isNotEmpty) {
      final orden = OrdenCompraNewModel();

      orden.idOC = res[0].idOC;
      orden.ccOC = res[0].ccOC;
      orden.proformaOC = res[0].proformaOC;
      orden.condicionPagoOC = res[0].condicionPagoOC;
      orden.subTotalOC = res[0].subTotalOC;
      orden.percentDescuentoOC = res[0].percentDescuentoOC;
      orden.descuentoOC = res[0].descuentoOC;
      orden.igvOC = res[0].igvOC;
      orden.creditoOC = res[0].creditoOC;
      orden.totalOC = res[0].totalOC;
      orden.dateTimeCreateOC = res[0].dateTimeCreateOC;
      orden.dateTimeAprobacionOC = res[0].dateTimeAprobacionOC;
      orden.estadoOC = res[0].estadoOC;
      orden.activoOC = res[0].activoOC;
      orden.nombreProyectoOC = res[0].nombreProyectoOC;
      orden.codigoProyectoOC = res[0].codigoProyectoOC;
      orden.idMoneda = res[0].idMoneda;
      orden.nameCreateOC = res[0].nameCreateOC;
      orden.surnameCreateOC = res[0].surnameCreateOC;
      orden.surnameCreate2OC = res[0].surnameCreate2OC;
      orden.nombreEmpresa = res[0].nombreEmpresa;
      orden.rucEmpresa = res[0].rucEmpresa;
      orden.direccionEmpresa = res[0].direccionEmpresa;
      orden.nombreSede = res[0].nombreSede;
      orden.nombreProveedor = res[0].nombreProveedor;
      orden.rucProveedor = res[0].rucProveedor;
      orden.direccionProveedor = res[0].direccionProveedor;
      orden.telefonoProveedor = res[0].telefonoProveedor;
      orden.contactoProveedor = res[0].contactoProveedor;
      orden.emailProveedor = res[0].emailProveedor;

      orden.recursos = await ordenCompraApi.detalleOCDB.getdetalleOCByIdOC(idOC);

      result.add(orden);
    }
    return result;
  }
}

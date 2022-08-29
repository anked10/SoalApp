import 'dart:convert';

import 'package:soal_app/core/database/detalle_op_database.dart';
import 'package:soal_app/core/database/orden_compra_database.dart';
import 'package:soal_app/core/database/orden_compra_db.dart';
import 'package:soal_app/core/database/recurso_detalle_database.dart';
import 'package:soal_app/core/sharedpreferences/storage_manager.dart';
import 'package:soal_app/core/util/constants.dart';
import 'package:soal_app/src/models/api_result_model.dart';
import 'package:http/http.dart' as http;
import 'package:soal_app/src/models/orden_compra_model.dart';
import 'package:soal_app/src/models/recurso_detalle_oc_model.dart';

class OrdenCompraApi {
  final ordenCompraDatabase = OrdenCompraDatabase();
  final detalleOpDatabase = DetalleOpDatabase();
  final ocDB = OrdenCompraDB();
  final detalleOCDB = RecursoDetalleOCDB();
  Future<ApiResultModel> getOrdenCompra() async {
    ApiResultModel result = ApiResultModel();
    try {
      final url = '$API_BASE_URL/api/Ordencompra/listar_op_app';
      String? token = await StorageManager.readData('token');
      final response = await http.post(Uri.parse(url), body: {
        'app': 'true',
        'tn': token,
      });

      final decodedData = json.decode(response.body);
      final int code = decodedData['result']['code'];
      // if (code == 1) {
      //   for (var i = 0; i < decodedData['result']['data'].length; i++) {
      //     OrdenCompraModel ordenCompraModel = OrdenCompraModel();

      //     ordenCompraModel.idOp = decodedData['result']['data'][i]['id_op'];
      //     ordenCompraModel.opNumero = decodedData['result']['data'][i]['op_numero'];
      //     ordenCompraModel.opVencimiento = decodedData['result']['data'][i]['op_vencimiento'];
      //     ordenCompraModel.opMoneda = decodedData['result']['data'][i]['op_moneda'];
      //     ordenCompraModel.opTotal = decodedData['result']['data'][i]['op_total'];
      //     ordenCompraModel.opCondiciones = decodedData['result']['data'][i]['op_condiciones'];
      //     ordenCompraModel.opDateTime = decodedData['result']['data'][i]['op_datetime'];
      //     ordenCompraModel.opDateTiemAprobacion = decodedData['result']['data'][i]['op_datetime_aprobacion'];
      //     ordenCompraModel.opEstado = decodedData['result']['data'][i]['op_estado'];
      //     ordenCompraModel.opActivo = decodedData['result']['data'][i]['op_activo'];
      //     ordenCompraModel.proveedorNombre = decodedData['result']['data'][i]['proveedor_nombre'];
      //     ordenCompraModel.personName = decodedData['result']['data'][i]['person_name'];
      //     ordenCompraModel.personSurname = decodedData['result']['data'][i]['person_surname'];
      //     ordenCompraModel.personSurname2 = decodedData['result']['data'][i]['person_surname2'];
      //     ordenCompraModel.sedeNombre = decodedData['result']['data'][i]['sede'];

      //     await ordenCompraDatabase.insertarOrdenCompra(ordenCompraModel);

      //     var detalle = decodedData['result']['data'][i]['detalle'];

      //     if (detalle.length > 0) {
      //       for (var x = 0; x < detalle.length; x++) {
      //         DetalleOpModel detalleOpModel = DetalleOpModel();
      //         detalleOpModel.idDetalleOp = detalle[x]['id_detalleop'];
      //         detalleOpModel.idOp = detalle[x]['id_op'];
      //         detalleOpModel.detalleOpPrecioUnit = detalle[x]['detalleop_prec_unit'];
      //         detalleOpModel.detalleOpPrecioTotal = detalle[x]['detalleop_prec_tot'];
      //         detalleOpModel.opVencimiento = detalle[x]['op_vencimiento'];
      //         detalleOpModel.opNumero = detalle[x]['op_numero'];
      //         detalleOpModel.cantidad = detalle[x]['detallesi_cantidad'];
      //         detalleOpModel.atendido = detalle[x]['detallesi_atendido'];
      //         detalleOpModel.um = detalle[x]["detallesi_um"];
      //         detalleOpModel.descripcion = detalle[x]["detallesi_descripcion"];
      //         detalleOpModel.recursoTipo = detalle[x]['recurso_tipo'];
      //         detalleOpModel.recursoNombre = detalle[x]['recurso_nombre'];
      //         detalleOpModel.recursoCodigo = detalle[x]['recurso_codigo'];
      //         detalleOpModel.recursoComentario = detalle[x]['recurso_comentario'];
      //         detalleOpModel.recursoFoto = detalle[x]['recurso_foto'];
      //         detalleOpModel.recursoEstado = detalle[x]['recurso_estado'];
      //         detalleOpModel.proveedorNombre = decodedData['result']['data'][i]['proveedor_nombre'];
      //         detalleOpModel.proveedorRuc = decodedData['result']['data'][i]['proveedor_ruc'];
      //         detalleOpModel.proveedorDireccion = decodedData['result']['data'][i]['proveedor_direccion'];
      //         detalleOpModel.proveedorTelefono = decodedData['result']['data'][i]['proveedor_telefono'];
      //         detalleOpModel.proveedorContacto = decodedData['result']['data'][i]['proveedor_contacto'];
      //         detalleOpModel.proveedorEmail = decodedData['result']['data'][i]['proveedor_email'];
      //         await detalleOpDatabase.insertarDetalleOp(detalleOpModel);
      //       }
      //     }
      //   }
      // }

      if (response.statusCode == 200) {
        await ocDB.deleteAllByEstado('1');
        final decodedData = json.decode(response.body);
        for (var i = 0; i < decodedData["result"]["data"].length; i++) {
          var item = decodedData["result"]["data"][i];
          final orden = OrdenCompraNewModel();
          orden.idOC = item["id_op"];
          orden.numberOC = item["op_numero"];
          orden.ccOC = item["generar_orden_compra_cc"];
          orden.proformaOC = item["generar_orden_compra_proforma"];
          orden.condicionPagoOC = item["generar_orden_compra_condicion_pago"];
          orden.subTotalOC = item["total_parcial"];
          orden.percentDescuentoOC = item["generar_orden_compra_descuento"];
          orden.descuentoOC = item["descuento"].toString();
          orden.igvOC = item["generar_orden_compra_igv"];
          orden.creditoOC = item["generar_orden_compra_credito"];
          orden.totalOC = item["op_total"];
          orden.dateTimeCreateOC = item["op_datetime"];
          orden.dateTimeAprobacionOC = item["op_datetime_aprobacion"];
          orden.estadoOC = item["op_estado"];
          orden.activoOC = item["op_activo"];
          orden.cotizacion = item["op_file"];
          orden.nombreProyectoOC = item["proyecto_nombre"];
          orden.codigoProyectoOC = item["proyecto_codigo"];
          orden.idMoneda = item["moneda"];
          orden.nameCreateOC = item["person_name"];
          orden.surnameCreateOC = item["person_surname"];
          orden.surnameCreate2OC = item["person_surname2"];
          orden.nombreEmpresa = item["empresa_nombre"];
          orden.rucEmpresa = item["empresa_ruc"];
          orden.direccionEmpresa = item["empresa_direccion"];
          orden.nombreSede = item["sede_nombre"];
          orden.nombreProveedor = item["proveedor_nombre"];
          orden.rucProveedor = item["proveedor_ruc"];
          orden.direccionProveedor = item["proveedor_direccion"];
          orden.telefonoProveedor = item["proveedor_telefono"];
          orden.contactoProveedor = item["proveedor_contacto"];
          orden.emailProveedor = item["proveedor_email"];
          orden.montoEstado = item["monto_estado"];
          orden.montoRendicion = item["monto_rendicion"];
          await ocDB.insertarOrdenCompra(orden);

          for (var x = 0; x < item["detalle"].length; x++) {
            var de = item["detalle"][x];

            final detalle = RecursoDetalleOCModel();
            detalle.idDetalleOC = de["id_detalleop"];
            detalle.idOC = de["id_op"];
            detalle.idrecurso = de["id_recurso"];
            detalle.cantidadDetalleOC = de["detalleop_cantidad"];
            detalle.precioUnitDetalleOC = de["detalleop_prec_unit"];
            detalle.precioUnitTDetalleOC = de["detalleop_prec_unit_t"];
            detalle.precioTotalDetalleOC = de["detalleop_prec_tot"];
            detalle.umRecurso = de["logistica_materiales_um"];
            detalle.tipoRecurso = de["recurso_tipo"];
            detalle.nombreRecurso = de["recurso_nombre"];
            detalle.codigoRecurso = de["recurso_codigo"];
            detalle.comentarioRecurso = de["recurso_comentario"];
            detalle.fotoRecurso = de["recurso_foto"];
            detalle.estadoRecurso = de["recurso_estado"];

            await detalleOCDB.insertarDetalleOC(detalle);
          }
        }
      }

      result.code = code;
      result.message = decodedData['result']['message'];
      return result;
    } catch (e) {
      result.code = 2;
      result.message = 'Ocurrió un error';
      return result;
    }
  }

  Future<int> getOrdenCompraPendientes() async {
    try {
      final url = '$API_BASE_URL/api/Ordencompra/ws_listar_pendientes_op';
      String? token = await StorageManager.readData('token');
      final response = await http.post(Uri.parse(url), body: {
        'app': 'true',
        'tn': token,
      });
      if (response.statusCode == 200) {
        await ocDB.deleteAllByEstado('0');
        final decodedData = json.decode(response.body);
        for (var i = 0; i < decodedData["result"]["datos"].length; i++) {
          var item = decodedData["result"]["datos"][i];
          final orden = OrdenCompraNewModel();
          orden.idOC = item["id_op"];
          orden.ccOC = item["generar_orden_compra_cc"];
          orden.proformaOC = item["generar_orden_compra_proforma"];
          orden.condicionPagoOC = item["generar_orden_compra_condicion_pago"];
          orden.subTotalOC = item["total_parcial"];
          orden.percentDescuentoOC = item["generar_orden_compra_descuento"];
          orden.descuentoOC = item["descuento"].toString();
          orden.igvOC = item["generar_orden_compra_igv"];
          orden.creditoOC = item["generar_orden_compra_credito"];
          orden.totalOC = item["op_total"];
          orden.dateTimeCreateOC = item["op_datetime"];
          orden.dateTimeAprobacionOC = item["op_datetime_aprobacion"];
          orden.estadoOC = item["op_estado"];
          orden.activoOC = item["op_activo"];
          orden.nombreProyectoOC = item["proyecto_nombre"];
          orden.codigoProyectoOC = item["proyecto_codigo"];
          orden.idMoneda = item["id_moneda"];
          orden.nameCreateOC = item["person_name"];
          orden.surnameCreateOC = item["person_surname"];
          orden.surnameCreate2OC = item["person_surname2"];
          orden.nombreEmpresa = item["empresa_nombre"];
          orden.rucEmpresa = item["empresa_ruc"];
          orden.direccionEmpresa = item["empresa_direccion"];
          orden.nombreSede = item["sede_nombre"];
          orden.nombreProveedor = item["proveedor_nombre"];
          orden.rucProveedor = item["proveedor_ruc"];
          orden.direccionProveedor = item["proveedor_direccion"];
          orden.telefonoProveedor = item["proveedor_telefono"];
          orden.contactoProveedor = item["proveedor_contacto"];
          orden.emailProveedor = item["proveedor_email"];
          await ocDB.insertarOrdenCompra(orden);

          for (var x = 0; x < item["detalle"].length; x++) {
            var de = item["detalle"][x];

            final detalle = RecursoDetalleOCModel();
            detalle.idDetalleOC = de["id_detalleop"];
            detalle.idOC = de["id_op"];
            detalle.idrecurso = de["id_recurso"];
            detalle.cantidadDetalleOC = de["detalleop_cantidad"];
            detalle.precioUnitDetalleOC = de["detalleop_prec_unit"];
            detalle.precioUnitTDetalleOC = de["detalleop_prec_unit_t"];
            detalle.precioTotalDetalleOC = de["detalleop_prec_tot"];
            detalle.umRecurso = de["logistica_materiales_um"];
            detalle.tipoRecurso = de["recurso_tipo"];
            detalle.nombreRecurso = de["recurso_nombre"];
            detalle.codigoRecurso = de["recurso_codigo"];
            detalle.comentarioRecurso = de["recurso_comentario"];
            detalle.fotoRecurso = de["recurso_foto"];
            detalle.estadoRecurso = de["recurso_estado"];

            await detalleOCDB.insertarDetalleOC(detalle);
          }
        }
        return 1;
      } else {
        return 2;
      }
    } catch (e) {
      return 2;
    }
  }

  Future<int> aprobarOrdenCompra(String idOC) async {
    try {
      final url = '$API_BASE_URL/api/Ordencompra/aprobacion_op';
      String? token = await StorageManager.readData('token');
      final response = await http.post(Uri.parse(url), body: {
        'app': 'true',
        'tn': token,
        'id_op': idOC,
      });
      if (response.statusCode == 200) {
        final decodedData = json.decode(response.body);
        print(decodedData);
        return decodedData["result"];
      } else {
        return 2;
      }
    } catch (e) {
      return 2;
    }
  }

  Future<int> eliminarOrdenCompra(String idOC, String eliminar) async {
    try {
      final url = '$API_BASE_URL/api/Ordencompra/aprobacion_op';
      String? token = await StorageManager.readData('token');
      final response = await http.post(Uri.parse(url), body: {
        'app': 'true',
        'tn': token,
        'id_op': idOC,
        'eliminar': eliminar,
      });
      if (response.statusCode == 200) {
        final decodedData = json.decode(response.body);
        print(decodedData);
        return decodedData["result"];
      } else {
        return 2;
      }
    } catch (e) {
      return 2;
    }
  }
}

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:soal_app/core/database/pagos_db.dart';
import 'package:soal_app/core/sharedpreferences/storage_manager.dart';
import 'package:soal_app/core/util/constants.dart';
import 'package:soal_app/src/models/api_result_model.dart';
import 'package:soal_app/src/models/pagos_model.dart';

class GestionPagosApi {
  final pagosDB = PagosDB();

  Future<ApiResultModel> getPagosOC(String idOC) async {
    ApiResultModel result = ApiResultModel();
    try {
      final url = '$API_BASE_URL/api/GestionPagos/ws_listar_pagos_op';
      String? token = await StorageManager.readData('token');
      final response = await http.post(Uri.parse(url), body: {
        'app': 'true',
        'tn': token,
        'id': idOC,
      });

      final decodedData = json.decode(response.body);
      final int code = decodedData['result']['code'];
      if (code == 1) {
        for (var i = 0; i < decodedData['result']['datos'].length; i++) {
          var datito = decodedData['result']['datos'][i];

          PagosModel pago = PagosModel();
          pago.idPago = datito['id_pago'];
          pago.idOC = datito['id_op'];
          pago.idObligacion = datito['id_obligacion'];
          pago.idUser = datito['id_user'];
          pago.bancoPago = datito['pago_banco'];
          pago.monedaPago = datito['pago_moneda'];
          pago.montoPago = datito['pago_monto'];
          pago.fechaPago = datito['pago_fecha'];
          pago.voucherPago = datito['pago_voucher'];
          pago.tipoPago = datito['pago_tipo'];
          pago.referenciaPago = datito['pago_referencia'];
          pago.comprobanteTipo = datito['tipo_comprobante'];
          pago.rucPago = datito['pago_ruc'];
          pago.nroComprobantePago = datito['pago_nro_comprobante'];
          pago.rencidicionAprobacionPago = datito['pago_rendicion_aprobacion'];
          pago.codRegPago = datito['pago_reg_cod'];
          pago.fechaAdjuntadaPago = datito['pago_fecha_adjuntada'];
          pago.nameAtended = datito['nombre'];

          await pagosDB.insertarPago(pago);
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

  Future<ApiResultModel> getRendicionesPagosOC(String idOC) async {
    ApiResultModel result = ApiResultModel();
    try {
      final url = '$API_BASE_URL/api/Ordencompra/ws_listar_documentos_rendicion';
      String? token = await StorageManager.readData('token');
      final response = await http.post(Uri.parse(url), body: {
        'app': 'true',
        'tn': token,
        'id': idOC,
      });

      final decodedData = json.decode(response.body);
      final int code = decodedData['result']['code'];
      if (code == 1) {
        for (var i = 0; i < decodedData['result']['datos'].length; i++) {
          var datito = decodedData['result']['datos'][i];

          PagosModel pago = PagosModel();
          pago.idPago = datito['id_pago'];
          pago.idOC = datito['id_op'];
          pago.idObligacion = datito['id_obligacion'];
          pago.idUser = datito['id_user'];
          pago.bancoPago = datito['pago_banco'];
          pago.monedaPago = datito['pago_moneda'];
          pago.montoPago = datito['pago_monto'];
          pago.fechaPago = datito['pago_fecha'];
          pago.voucherPago = datito['pago_voucher'];
          pago.tipoPago = datito['pago_tipo'];
          pago.referenciaPago = datito['pago_referencia'];
          pago.comprobanteTipo = datito['tipo_comprobante'];
          pago.rucPago = datito['pago_ruc'];
          pago.nroComprobantePago = datito['pago_nro_comprobante'];
          pago.rencidicionAprobacionPago = datito['pago_rendicion_aprobacion'];
          pago.codRegPago = datito['pago_reg_cod'];
          pago.fechaAdjuntadaPago = datito['pago_fecha_adjuntada'];
          //pago.nameAtended = datito['nombre'];

          await pagosDB.insertarPago(pago);
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

  Future<ApiResultModel> uploadPagoOC({
    required File archivo,
    required String idOC,
    required String bancoPago,
    required String monedaPago,
    required String montoPago,
    required String fechaPago,
    required String referenciaPago,
  }) async {
    ApiResultModel result = ApiResultModel();
    try {
      final url = Uri.parse('$API_BASE_URL/api/Obligacionlaboral/guardar_pago_op');

      String? token = await StorageManager.readData('token');

      final request = http.MultipartRequest('POST', url);

      request.fields["app"] = "true";
      request.fields["tn"] = token!;
      request.fields["id_obligacion"] = idOC;
      request.fields["pago_banco"] = bancoPago;
      request.fields["pago_moneda"] = monedaPago;
      request.fields["pago_monto"] = montoPago;
      request.fields["pago_fecha"] = fechaPago;
      request.fields["referencia"] = referenciaPago;

      request.files.add(await http.MultipartFile.fromPath('archivo', archivo.path));

      final response = await request.send();

      final int code = response.statusCode;

      if (code == 200) {
        result.message = 'Archivo cargado correctamente';
      } else {
        result.message = 'Ocurrió un error, inténtelo nuevamente';
      }
      result.code = code;

      return result;
    } catch (e) {
      print(e);
      result.code = 2;
      result.message = 'Ocurrió un error';
      return result;
    }
  }
}

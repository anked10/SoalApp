import 'dart:convert';

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
}

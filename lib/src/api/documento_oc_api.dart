//Solicitudcompra/listar_doc_varios_app

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:soal_app/core/database/documentoOrdenesdeCompraDatabase.dart';
import 'package:soal_app/core/sharedpreferences/storage_manager.dart';
import 'package:soal_app/core/util/constants.dart';
import 'package:soal_app/src/models/api_result_model.dart';
import 'package:soal_app/src/models/documento_oc_model.dart';

class DocumentosOCApi {
  final documentosOcDatabase = DocumentosOcDatabase();

  Future<ApiResultModel> getDocumentosOC() async {
    ApiResultModel result = ApiResultModel();
    try {
      final url = '$API_BASE_URL/api/Ordencompra/listar_doc_op_app';
      String? token = await StorageManager.readData('token');
      final response = await http.post(Uri.parse(url), body: {
        'app': 'true',
        'tn': token,
      });

      final decodedData = json.decode(response.body);
      final int code = decodedData['result']['code'];
      if (code == 1) {
        for (var i = 0; i < decodedData['result']['data'].length; i++) {
          var detashe = decodedData['result']['data'][i]['documentos'];

          if (detashe.length > 0) {
            for (var x = 0; x < detashe.length; x++) {
              DocumentoOCModel documentoModel = DocumentoOCModel();
              documentoModel.idPago = detashe[x]['id_pago'];
              documentoModel.idObligacion = detashe[x]['id_obligacion'];
              documentoModel.idUser = detashe[x]['id_user'];
              documentoModel.pagoBanco = detashe[x]['pago_banco'];
              documentoModel.pagoMoneda = detashe[x]['pago_moneda'];
              documentoModel.pagoMonto = detashe[x]['pago_monto'];
              documentoModel.pagoFecha = detashe[x]['pago_fecha'];
              documentoModel.pagoVoucher = detashe[x]['pago_voucher'];
              documentoModel.pagoTipo = detashe[x]['pago_tipo'];
              documentoModel.pagoReferencia = detashe[x]['pago_referencia'];
              documentoModel.tipoComprobante = detashe[x]['tipo_comprobante'];
              documentoModel.pagoRuc = detashe[x]['pago_ruc'];
              documentoModel.pagoNroComprobante = detashe[x]['pago_nro_comprobante'];
              documentoModel.idPersonPago = detashe[x]['id_person_pago'];
              documentoModel.idPersonPagador = detashe[x]['id_person_pagador'];
              documentoModel.pagoRendicion = detashe[x]['pago_rendicion'];
              documentoModel.idOp = detashe[x]['id_op'];
              documentoModel.pagoRegCod = detashe[x]['pago_reg_cod'];
              documentoModel.pagoFechaAdjuntada = detashe[x]['pago_fecha_adjuntada'];

              await documentosOcDatabase.insertarDocumentosOc(documentoModel);
            }
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
}

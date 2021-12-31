//Solicitudcompra/listar_doc_varios_app


import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:soal_app/core/database/document_database.dart';
import 'package:soal_app/core/sharedpreferences/storage_manager.dart';
import 'package:soal_app/core/util/constants.dart';
import 'package:soal_app/src/models/api_result_model.dart';
import 'package:soal_app/src/models/documento_model.dart';

class DocumentosApi {
  final documentosDatabase = DocumentosDatabase();

  Future<ApiResultModel> getDocumentos() async {
    ApiResultModel result = ApiResultModel();
    try {
      final url = '$API_BASE_URL/api/Solicitudcompra/listar_doc_varios_app';
      String? token = await StorageManager.readData('token');
      final response = await http.post(Uri.parse(url), body: {
        'app': 'true',
        'tn': token,
      });

      final decodedData = json.decode(response.body);
      final int code = decodedData['result']['code'];
      if (code == 1) {
        for (var i = 0; i < decodedData['result']['data'].length; i++) {
          DocumentoModel documentoModel = DocumentoModel();
          documentoModel.idDocumento = decodedData['result']['data'][i]['id_documento'];
          documentoModel.idPerson = decodedData['result']['data'][i]['id_person'];
          documentoModel.idTipo= decodedData['result']['data'][i]['id_tipo'];
          documentoModel.documentoClase= decodedData['result']['data'][i]['documento_clase'];
          documentoModel.documentoTipo= decodedData['result']['data'][i]['documento_tipo'];
          documentoModel.documentoArchivo= decodedData['result']['data'][i]['documento_archivo'];
          documentoModel.documentoReferencia= decodedData['result']['data'][i]['documento_referencia'];
          documentoModel.documentoFecha= decodedData['result']['data'][i]['documento_fecha'];
          documentoModel.documentoFechaSubida= decodedData['result']['data'][i]['documento_fecha_subida'];

          await documentosDatabase.insertarDocumentos(documentoModel);
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

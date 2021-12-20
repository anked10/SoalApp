import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:soal_app/core/database/clases_database.dart';
import 'package:soal_app/core/sharedpreferences/storage_manager.dart';
import 'package:soal_app/core/util/constants.dart';
import 'package:soal_app/src/models/api_result_model.dart';
import 'package:soal_app/src/models/clases_model.dart';

class ClasesApi {
  final clasesDatabase = ClasesDatabase();

  Future<ApiResultModel> getClases() async {
    ApiResultModel result = ApiResultModel();
    try {
      final url = '$API_BASE_URL/api/Proveedor/listar_clases';
      String? token = await StorageManager.readData('token');
      final response = await http.post(Uri.parse(url), body: {
        'app': 'true',
        'tn': token,
      });

      final decodedData = json.decode(response.body);
      final int code = decodedData['result']['code'];
      if (code == 1) {
        for (var i = 0; i < decodedData['result']['data'].length; i++) {
          ClasesModel clases = ClasesModel();
          clases.idLogisticaClase = decodedData['result']['data'][i]['id_logistica_clase'];
          clases.idLogisticaTipo = decodedData['result']['data'][i]['id_logistica_tipo'];
          clases.logisticaClaseNombre = decodedData['result']['data'][i]['logistica_clase_nombre'];

          await clasesDatabase.insertarClases(clases);
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

import 'dart:convert';

import 'package:soal_app/core/database/si_database.dart';
import 'package:soal_app/core/sharedpreferences/storage_manager.dart';
import 'package:soal_app/core/util/constants.dart';
import 'package:soal_app/src/models/api_result_model.dart';
import 'package:http/http.dart' as http;
import 'package:soal_app/src/models/si_model.dart';

class SiApi {
  final siDatabase = SiDatabase();
  Future<ApiResultModel> getSI() async {
    ApiResultModel result = ApiResultModel();
    try {
      final url = '$API_BASE_URL/api/Solicitudcompra/listar_si_app';
      String? token = await StorageManager.readData('token');
      final response = await http.post(Uri.parse(url), body: {
        'app': 'true',
        'tn': token,
      });

      final decodedData = json.decode(response.body);
      final int code = decodedData['result']['code'];
      if (code == 1) {
        for (var i = 0; i < decodedData['result']['data'].length; i++) {
          SiModel si = SiModel();
          si.idSi = decodedData['result']['data'][i]['id_si'];
          si.idAprobacion = decodedData['result']['data'][i]['id_aprobacion'];
          si.idDepartamento = decodedData['result']['data'][i]['id_departamento'];
          si.idEmpresa = decodedData['result']['data'][i]['id_empresa'];
          si.idProyecto = decodedData['result']['data'][i]['id_proyecto'];
          si.idSede = decodedData['result']['data'][i]['id_sede'];
          si.idSolicitante = decodedData['result']['data'][i]['id_solicitante'];
          si.personName = decodedData['result']['data'][i]['person_name'];
          si.personSurname = decodedData['result']['data'][i]['person_surname'];
          si.personSurname2 = decodedData['result']['data'][i]['person_surname2'];
          si.sedeNombre = decodedData['result']['data'][i]['sede_nombre'];
          si.siActivo = decodedData['result']['data'][i]['si_activo'];
          si.siDatetimeAprobacion = decodedData['result']['data'][i]['si_datetime_aprobacion'];
          si.siEstado = decodedData['result']['data'][i]['si_estado'];
          si.siNumero = decodedData['result']['data'][i]['si_numero'];
          si.siObservaciones = decodedData['result']['data'][i]['si_observaciones'];
          si.proyectoNombre = decodedData['result']['data'][i]['proyecto_nombre'];
          si.siDatetime = decodedData['result']['data'][i]['si_datetime'];

          await siDatabase.insertarSi(si);
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

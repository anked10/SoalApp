

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:soal_app/core/sharedpreferences/storage_manager.dart';
import 'package:soal_app/core/util/constants.dart';
import 'package:soal_app/src/models/api_result_model.dart';

class LoginApi {
  Future<ApiResultModel> login(String user, String pass) async {
    ApiResultModel result = ApiResultModel();
    try {
      final url = '$API_BASE_URL/api/Login/validar_sesion';

      final response = await http.post(Uri.parse(url), body: {
        'usuario_nickname': user,
        'usuario_contrasenha': pass,
        'app': 'true',
      });

      final decodedData = json.decode(response.body);
      final int code = decodedData['result']['code'];
      if (code == 1) {
        StorageManager.saveData('idUser', decodedData['data']['id_bufipay']);
        StorageManager.saveData('idPerson', decodedData['data']['p_u']);
        StorageManager.saveData('userNickname', decodedData['data']['_n']);
        StorageManager.saveData('userEmail', decodedData['data']['u_e']);
        StorageManager.saveData('userImage', decodedData['data']['u_i']);
        StorageManager.saveData('personName', decodedData['data']['p_n']);
        StorageManager.saveData('personSurname', decodedData['data']['p_p']);
        StorageManager.saveData('idRoleUser', decodedData['data']['ru']);
        StorageManager.saveData('roleName', decodedData['data']['rn']);
        StorageManager.saveData('token', decodedData['data']['tn']);
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

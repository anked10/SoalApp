import 'dart:convert';

import 'package:bufi_remake/core/util/constants.dart';
import 'package:bufi_remake/src/preferences/preferences.dart';
import 'package:http/http.dart' as http;
import 'package:soal_app/src/models/api_result_model.dart';
import 'package:soal_app/src/util/constants.dart';

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
        Preferences.saveData('idUser', decodedData['data']['id_bufipay']);
        Preferences.saveData('idPerson', decodedData['data']['p_u']);
        Preferences.saveData('userNickname', decodedData['data']['_n']);
        Preferences.saveData('userEmail', decodedData['data']['u_e']);
        Preferences.saveData('userImage', decodedData['data']['u_i']);
        Preferences.saveData('personName', decodedData['data']['p_n']);
        Preferences.saveData('personSurname', decodedData['data']['p_p']);
        Preferences.saveData('idRoleUser', decodedData['data']['ru']);
        Preferences.saveData('roleName', decodedData['data']['rn']);
        Preferences.saveData('token', decodedData['data']['tn']);
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

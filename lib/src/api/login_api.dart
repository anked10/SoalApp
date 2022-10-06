import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:soal_app/core/database/Menu/modulo_database.dart';
import 'package:soal_app/core/database/Menu/submodulo_database.dart';
import 'package:soal_app/core/sharedpreferences/storage_manager.dart';
import 'package:soal_app/core/util/constants.dart';
import 'package:soal_app/src/models/Menu/modulos_model.dart';
import 'package:soal_app/src/models/Menu/submodulo_model.dart';
import 'package:soal_app/src/models/api_result_model.dart';

class LoginApi {
  final moduloDB = ModuloDatabase();
  final submoduloDB = SubModuloDatabase();
  Future<ApiResultModel> login(String user, String pass) async {
    ApiResultModel result = ApiResultModel();
    try {
      final url = '$API_BASE_URL/api/Login/login_app';

      final response = await http.post(Uri.parse(url), body: {
        'user': user,
        'pass': pass,
        'app': 'true',
      });

      final decodedData = json.decode(response.body);
      print(pass);
      final int code = decodedData['result']['code'];
      if (code == 1) {
        StorageManager.saveData('idUser', decodedData['data']['c_u']);
        StorageManager.saveData('idPerson', decodedData['data']['c_p']);
        StorageManager.saveData('userNickname', decodedData['data']['_n']);
        StorageManager.saveData('userEmail', decodedData['data']['u_e']);
        StorageManager.saveData('userImage', decodedData['data']['u_i']);
        StorageManager.saveData('personName', decodedData['data']['p_n']);
        StorageManager.saveData('personSurname', decodedData['data']['p_s']);
        StorageManager.saveData('personSurname2', decodedData['data']['p_p']);
        StorageManager.saveData('idRoleUser', decodedData['data']['ru']);
        StorageManager.saveData('roleName', decodedData['data']['rn']);
        StorageManager.saveData('dniPerson', decodedData['data']['dni']);
        StorageManager.saveData('cargoID', decodedData['data']['id_c']);
        StorageManager.saveData('cargoName', decodedData['data']['c_n']);
        StorageManager.saveData('peridoID', decodedData['data']['id_p']);
        StorageManager.saveData('businessID', decodedData['data']['em']);
        StorageManager.saveData('businessName', decodedData['data']['em_n']);
        StorageManager.saveData('token', decodedData['data']['tn']);

        //Guardar Modulos
        for (var i = 0; i < decodedData['modulos'].length; i++) {
          var datos = decodedData['modulos'][i];

          if (datos['agrupacion_app'] == '1') {
            final modulo = ModulosModel();

            modulo.idModulo = datos['id_agrupacion'];
            modulo.nombreModulo = datos['agrupacion_nombre'];
            modulo.ordenModulo = datos['agrupacion_orden'];
            modulo.estadoModulo = datos['agrupacion_estado'];
            modulo.visibleAppModulo = datos['agrupacion_app'];

            await moduloDB.insertarModulo(modulo);
          }
        }

        //Guardar SubModulos
        for (var i = 0; i < decodedData['submodulos'].length; i++) {
          var datos = decodedData['submodulos'][i];

          if (datos['menu_app'] == '1') {
            final subModulo = SubModuloModel();

            subModulo.idSubModulo = datos['id_menu'];
            subModulo.idModulo = datos['id_agrupacion'];
            subModulo.nameSubModulo = datos['menu_name'];
            subModulo.estadoSubModulo = datos['menu_status'];
            subModulo.visibleAppSubModulo = datos['menu_app'];

            await submoduloDB.insertarSubModulo(subModulo);
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

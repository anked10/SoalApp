import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:soal_app/core/database/almacen_database.dart';
import 'package:soal_app/core/database/sedes_database.dart';
import 'package:soal_app/core/sharedpreferences/storage_manager.dart';
import 'package:soal_app/core/util/constants.dart';
import 'package:soal_app/src/models/almacenModel.dart';
import 'package:soal_app/src/models/api_result_model.dart';
import 'package:soal_app/src/models/sedesModel.dart';

class AlmacenApi {
  final sedesDatabase = SedesDatabase();
  final almacenDatabase = AlmacenDatabase();

  Future<ApiResultModel> getAlmacenes() async {
    ApiResultModel result = ApiResultModel();
    try {
      final url = '$API_BASE_URL/api/Almacen/listar_recursos_almacen_app';
      String? token = await StorageManager.readData('token');
      final response = await http.post(Uri.parse(url), body: {
        'app': 'true',
        'tn': token,
      });

      final decodedData = json.decode(response.body);
      final int code = decodedData['result']['code'];
      if (code == 1) {
        for (var i = 0; i < decodedData['result']['data'].length; i++) {
          SedesModel sedesModel = SedesModel();
          sedesModel.idSede = decodedData['result']['data'][i]['id_sede'];
          sedesModel.sedeNombre = decodedData['result']['data'][i]['sede_nombre'];
          await sedesDatabase.insertarSedes(sedesModel);

          var recursos = decodedData['result']['data'][i]['recursos'];

          if (recursos.length > 0) {
            for (var x = 0; x < recursos.length; x++) {
              AlmacenModel almacenModel = AlmacenModel();

              almacenModel.idAlmacen = recursos[x]['id_almacen'];
              almacenModel.idSede = recursos[x]['id_sede'];
              almacenModel.idRecurso = recursos[x]['id_recurso'];
              almacenModel.almacenUnidad = recursos[x]['almacen_unidad'];
              almacenModel.almacenStock = recursos[x]['almacen_stock'];
              almacenModel.almacenDescripcion = recursos[x]['almacen_descripcion'];
              almacenModel.idLogisticaClase = recursos[x]['id_logistica_clase'];
              almacenModel.idEmpresa = recursos[x]['id_empresa'];
              almacenModel.recursoTipo = recursos[x]['recurso_tipo'];
              almacenModel.recursoNombre = recursos[x]['recurso_nombre'];
              almacenModel.recursoCodigo = recursos[x]['recurso_codigo'];
              almacenModel.recursoComentario = recursos[x]['recurso_comentario'];
              almacenModel.recursoFoto = recursos[x]['recurso_foto'];
              almacenModel.recursoEstado = recursos[x]['recurso_estado'];
              almacenModel.idLogisticaTipo = recursos[x]['id_logistica_tipo'];
              almacenModel.logisticaClaseNombre = recursos[x]['logistica_clase_nombre'];
              almacenModel.logisticaTipoNombre = recursos[x]['logistica_tipo_nombre'];
              await almacenDatabase.insertarAlmacenes(almacenModel);
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

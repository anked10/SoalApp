import 'dart:convert';

import 'package:soal_app/core/database/detalle_si_database.dart';
import 'package:soal_app/core/database/si_database.dart';
import 'package:soal_app/core/sharedpreferences/storage_manager.dart';
import 'package:soal_app/core/util/constants.dart';
import 'package:soal_app/src/models/api_result_model.dart';
import 'package:http/http.dart' as http;
import 'package:soal_app/src/models/detalle_si_model.dart';
import 'package:soal_app/src/models/si_model.dart';

class SiApi {
  final siDatabase = SiDatabase();
  final detalleSiDatabase = DetalleSiDatabase();
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

          var detalle = decodedData['result']['data'][i]['detalle'];

          if (detalle.length > 0) {
            for (var x = 0; x < detalle.length; x++) {
              DetalleSiModel detalleSiModel = DetalleSiModel();
              detalleSiModel.idDetalleSi = detalle[x]['id_detallesi'];
              detalleSiModel.idSi= detalle[x]['id_si'];
              detalleSiModel.idRecurso= detalle[x]['id_recurso'];
              detalleSiModel.descripcion= detalle[x]['detallesi_descripcion'];
              detalleSiModel.um= detalle[x]['detallesi_um'];
              detalleSiModel.cantidad= detalle[x]['detallesi_cantidad'];
              detalleSiModel.estado= detalle[x]['detallesi_estado'];
              detalleSiModel.atendido= detalle[x]['detallesi_atendido'];
              detalleSiModel.cajaAlmacen= detalle[x]["detallesi_caja_almacen"];
              detalleSiModel.idLogisticaClase= detalle[x]["id_logistica_clase"];
              detalleSiModel.idEmpresa= detalle[x]['id_empresa'];
              detalleSiModel.recursoTipo= detalle[x]['recurso_tipo'];
              detalleSiModel.recursoNombre= detalle[x]['recurso_nombre'];
              detalleSiModel.recursoCodigo= detalle[x]['recurso_codigo'];
              detalleSiModel.recursoComentario= detalle[x]['recurso_comentario'];
              detalleSiModel.recursoFoto= detalle[x]['recurso_foto'];
              detalleSiModel.recursoEstado= detalle[x]['recurso_estado'];
              detalleSiModel.idLogisticaTipo= detalle[x]['id_logistica_tipo'];
              detalleSiModel.logisticaClaseNombre= detalle[x]["logistica_clase_nombre"];
              detalleSiModel.logisticaTipoNombre= detalle[x]["logistica_tipo_nombre"];
              await detalleSiDatabase.insertarDetalleSi(detalleSiModel);
            }
          }

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

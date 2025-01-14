import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz_unsafe.dart';
import 'package:http/http.dart' as http;
import 'package:soal_app/core/database/QHSE/documents_anexado_database.dart';
import 'package:soal_app/core/database/QHSE/incidencias_database.dart';
import 'package:soal_app/core/sharedpreferences/storage_manager.dart';
import 'package:soal_app/core/util/constants.dart';
import 'package:soal_app/src/models/Rqhse/documentos_anexados_model.dart';
import 'package:soal_app/src/models/Rqhse/incidencia_model.dart';
import 'package:soal_app/src/models/api_result_model.dart';

class QHSEApi {
  final incidenciaDB = IncidenciasDatabase();
  final docAnexoDB = DocumentsAnexadoDatabase();

  Future<ApiResultModel> generateIncidencia({
    required String idEmpresa,
    required String idPerido,
    required String dateCreated,
    required String typeIncidencia,
    required String place,
    required String hourIncidencia,
    required String placeEspecific,
    required String descripcion,
    required String accionRealizada,
    required String openCloseIncidencia,
    required String safeAct,
    required String frustracion,
    required String fatiga,
    required String prisa,
    required String eppElemento,
    required String eppMaluso,
    required String eppNouso,
    required String herramientaInadec,
    required String herramientaMaluso,
    required String herramientaNouso,
    required String proceNoseComprende,
    required String proceNoseSabe,
    required String proceNoseSigue,
    required String evalCausaOtro,
    required String condicionSegura,
    required String herraInadecuada,
    required String herraDaNada,
    required String herraFaltaMante,
    required String herraInexistente,
    required String ambienteExcesoRuido,
    required String ambienteFaltaOrden,
    required String ambientePeligroso,
    required String ambienteInaIluminacion,
    required String ambienteMalaSenal,
    required String otro2,
  }) async {
    final result = ApiResultModel();
    try {
      final url = '$API_BASE_URL/api/Incidencia/guardar_incidencia';
      String? token = await StorageManager.readData('token');
      final response = await http.post(Uri.parse(url), body: {
        'app': 'true',
        'id_empresa': idEmpresa,
        'id_periodolaboral': idPerido,
        'fecha_creacion': dateCreated,
        'incidencia_tipo': typeIncidencia,
        'incidencia_locacion': place,
        'incidencia_hora': hourIncidencia,
        'incidencia_lugar_especifico': placeEspecific,
        'observacion_descripcion': descripcion,
        'incidencia_accion_realizada': accionRealizada,
        'incidencia_open_close': openCloseIncidencia,
        'acto_seguro': safeAct,
        'actitud_frustracion': frustracion,
        'actitud_fatiga': fatiga,
        'actitud_prisa': prisa,
        'epp_elemento_inadecuado': eppElemento,
        'epp_mal_uso': eppMaluso,
        'epp_no_uso': eppNouso,
        'herramienta_inadecuado': herramientaInadec,
        'herramienta_mal_uso': herramientaMaluso,
        'herramienta_no_uso': herramientaNouso,
        'proce_nose_comprende': proceNoseComprende,
        'proce_nose_sabe': proceNoseSabe,
        'proce_nose_sigue': proceNoseSigue,
        'evaluacion_causa_otro': evalCausaOtro,
        'condicion_segura': condicionSegura,
        'herra_inadecuada': herraInadecuada,
        'herra_danada': herraDaNada,
        'herra_falta_mante': herraFaltaMante,
        'herra_inexistente': herraInexistente,
        'ambiente_exceso_ruido': ambienteExcesoRuido,
        'ambiente_falta_orden': ambienteFaltaOrden,
        'ambiente_peligroso': ambientePeligroso,
        'ambiente_ina_iluminacion': ambienteInaIluminacion,
        'ambiente_mala_senalizacion': ambienteMalaSenal,
        'inseguro_otro': otro2,
        'tn': token,
      });

      if (response.statusCode == 200) {
        final decodedData = json.decode(response.body);
        result.code = decodedData["result"]["code"];
        result.message = decodedData["result"]["message"];
      } else {
        result.code = 2;
        result.message = 'Ocurrió un error, inténtelo nuevamente';
      }

      return result;
    } catch (e) {
      result.code = 2;
      result.message = 'Ocurrió un error, inténtelo nuevamente';
      return result;
    }
  }

  Future<int> getIncidenciasPendientes() async {
    try {
      final url = '$API_BASE_URL/api/Incidencia/ws_incidencia_pendientes';
      String? token = await StorageManager.readData('token');
      final response = await http.post(Uri.parse(url), body: {
        'app': 'true',
        'tn': token,
      });

      if (response.statusCode == 200) {
        await incidenciaDB.deleteAll();
        final decodedData = json.decode(response.body);

        List<dynamic> incidencias = decodedData["result"]["data"];

        incidencias.forEach((element) async {
          await incidenciaDB.insertIncidencia(IncidenciaModel.fromJson2(element));
          final docs = element["documentos_anexados"];
          docs.forEach((dc) async {
            await docAnexoDB.insertDoc(DocumentsAnexadosModel.fromJson2(dc));
          });
        });
      }

      return 1;
    } catch (e) {
      return 2;
    }
  }

  Future<ApiResultModel> aprobarIncidenciaPendienteVerificacion(File documento, String idIncidencia, String comentario, String fecha) async {
    ApiResultModel result = ApiResultModel();
    try {
      final url = Uri.parse('$API_BASE_URL/api/Incidencia/aprobar');

      String? token = await StorageManager.readData('token');

      final request = http.MultipartRequest('POST', url);

      request.fields["app"] = "true";
      request.fields["tn"] = token!;
      request.fields["id"] = idIncidencia;
      request.fields["hse_comentario"] = comentario;
      request.fields["hse_verificacion_fecha"] = fecha;

      request.files.add(await http.MultipartFile.fromPath('hse_verificacion_firma', documento.path));

      final response = await request.send();

      final int code = response.statusCode;

      if (code == 200) {
        result.message = 'Archivo cargado correctamente';
      } else {
        result.message = 'Ocurrió un error, inténtelo nuevamente';
      }
      result.code = code;

      return result;
    } catch (e) {
      print(e);
      result.code = 2;
      result.message = 'Ocurrió un error';
      return result;
    }
  }
}

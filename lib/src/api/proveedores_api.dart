import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:soal_app/core/database/proveedor_database.dart';
import 'package:soal_app/core/sharedpreferences/storage_manager.dart';
import 'package:soal_app/core/util/constants.dart';
import 'package:soal_app/src/models/api_result_model.dart';
import 'package:soal_app/src/models/proveedores_model.dart';

class ProveedoresApi {
  final proveedorDatabase = ProveedoresDatabase();

  Future<ApiResultModel> obtenerProveedores() async {
    ApiResultModel result = ApiResultModel();
    try {
      final url = '$API_BASE_URL/api/Proveedor/listar_proveedores_app';
      String? token = await StorageManager.readData('token');
      final response = await http.post(Uri.parse(url), body: {
        'app': 'true',
        'tn': token,
      });

      final decodedData = json.decode(response.body);
      final int code = decodedData['result']['code'];
      if (code == 1) {
        for (var i = 0; i < decodedData['result']['data'].length; i++) {
          ProveedorModel proveedor = ProveedorModel();
          proveedor.idProveedor = decodedData['result']['data'][i]['id_proveedor'];
          proveedor.nombre = decodedData['result']['data'][i]['proveedor_nombre'];
          proveedor.ruc = decodedData['result']['data'][i]['proveedor_ruc'];
          proveedor.direccion = decodedData['result']['data'][i]['proveedor_direccion'];
          proveedor.telefono = decodedData['result']['data'][i]['proveedor_telefono'];
          proveedor.contacto = decodedData['result']['data'][i]['proveedor_contacto'];
          proveedor.email = decodedData['result']['data'][i]['proveedor_email'];
          proveedor.clase1 = decodedData['result']['data'][i]['proveedor_clase1'];
          proveedor.clase2 = decodedData['result']['data'][i]['proveedor_clase2'];
          proveedor.clase3 = decodedData['result']['data'][i]['proveedor_clase3'];
          proveedor.clase4 = decodedData['result']['data'][i]['proveedor_clase4'];
          proveedor.clase5 = decodedData['result']['data'][i]['proveedor_clase5'];
          proveedor.clase6 = decodedData['result']['data'][i]['proveedor_clase6'];
          proveedor.claseGeneral = decodedData['result']['data'][i]['proveedor_clase_general'];
          proveedor.banco1 = decodedData['result']['data'][i]['proveedor_banco1'];
          proveedor.banco2 = decodedData['result']['data'][i]['proveedor_banco2'];
          proveedor.banco3 = decodedData['result']['data'][i]['proveedor_banco3'];
          proveedor.estado = decodedData['result']['data'][i]['proveedor_estado'];

          await proveedorDatabase.insertarProveedor(proveedor);
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

  Future<ApiResultModel> editProvider(ProveedorModel proveedor) async {
    ApiResultModel result = ApiResultModel();

    try {
      final url = '$API_BASE_URL/api/Proveedor/guardar_proveedor';
      String? token = await StorageManager.readData('token');
      final response = await http.post(Uri.parse(url), body: {
        'app': 'true',
        'tn': token,
        'id_proveedor': '${proveedor.idProveedor}',
        'proveedor_nombre': '${proveedor.nombre}',
        'proveedor_ruc': '${proveedor.ruc}',
        'proveedor_estado': '${proveedor.estado}',
        'proveedor_telefono': '${proveedor.telefono}',
        'proveedor_contacto': '${proveedor.contacto}',
        'proveedor_email': '${proveedor.email}',
        'proveedor_direccion': '${proveedor.direccion}',
        'clase1': '${proveedor.clase1}',
        'clase2': '${proveedor.clase2}',
        'clase3': '${proveedor.clase3}',
        'clase4': '${proveedor.clase4}',
        'clase5': '${proveedor.clase5}',
        'clase6': '${proveedor.clase6}',
        'banco1': '${proveedor.banco1}',
        'banco2': '${proveedor.banco2}',
        'banco3': '${proveedor.banco3}',
      });

      final decodedData = json.decode(response.body);
      final int code = decodedData['result']['code'];

      result.code = code;
      result.message = decodedData['result']['message'];
      return result;
    } catch (e) {
      result.code = 2;
      result.message = 'Ocurrió un error';
      return result;
    }
  }

  Future<ApiResultModel> addProvider(ProveedorModel proveedor) async {
    ApiResultModel result = ApiResultModel();

    try {
      final url = '$API_BASE_URL/api/Proveedor/guardar_proveedor';
      String? token = await StorageManager.readData('token');
      final response = await http.post(Uri.parse(url), body: {
        'app': 'true',
        'tn': token,
        //'id_proveedor': '${proveedor.idProveedor}',
        'proveedor_nombre': '${proveedor.nombre}',
        'proveedor_ruc': '${proveedor.ruc}',
        'proveedor_estado': '${proveedor.estado}',
        'proveedor_telefono': '${proveedor.telefono}',
        'proveedor_contacto': '${proveedor.contacto}',
        'proveedor_email': '${proveedor.email}',
        'proveedor_direccion': '${proveedor.direccion}',
        'clase1': '${proveedor.clase1}',
        'clase2': '${proveedor.clase2}',
        'clase3': '${proveedor.clase3}',
        'clase4': '${proveedor.clase4}',
        'clase5': '${proveedor.clase5}',
        'clase6': '${proveedor.clase6}',
        'banco1': '${proveedor.banco1}',
        'banco2': '${proveedor.banco2}',
        'banco3': '${proveedor.banco3}',
      });

      final decodedData = json.decode(response.body);
      final int code = decodedData['result']['code'];

      result.code = code;
      result.message = decodedData['result']['message'];
      return result;
    } catch (e) {
      result.code = 2;
      result.message = 'Ocurrió un error';
      return result;
    }
  }

  Future<ApiResultModel> uploadDocumentoProveedor(File documento, String idProveedor, String tipoDocumento, String referencia, String fecha) async {
    ApiResultModel result = ApiResultModel();
    try {
      final url = Uri.parse('$API_BASE_URL/api/Proveedor/guardar_documento');

      String? token = await StorageManager.readData('token');

      final request = http.MultipartRequest('POST', url);

      request.fields["app"] = "true";
      request.fields["tn"] = token!;
      request.fields["id_tipo"] = idProveedor;
      request.fields["documento_tipo"] = tipoDocumento;
      request.fields["documento_referencia"] = referencia;
      request.fields["documento_fecha"] = fecha;

      request.files.add(await http.MultipartFile.fromPath('documento_archivo', documento.path));

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

import 'dart:convert';

import 'package:soal_app/core/database/detalle_op_database.dart';
import 'package:soal_app/core/database/orden_compra_database.dart';
import 'package:soal_app/core/sharedpreferences/storage_manager.dart';
import 'package:soal_app/core/util/constants.dart';
import 'package:soal_app/src/models/api_result_model.dart';
import 'package:http/http.dart' as http;
import 'package:soal_app/src/models/detalle_op_model.dart';
import 'package:soal_app/src/models/orden_compra_mode.dart';

class OrdenCompraApi {
  final ordenCompraDatabase = OrdenCompraDatabase();
  final detalleOpDatabase = DetalleOpDatabase();
  Future<ApiResultModel> getOrdenCompra() async {
    ApiResultModel result = ApiResultModel();
    try {
      final url = '$API_BASE_URL/api/Ordencompra/listar_op_app';
      String? token = await StorageManager.readData('token');
      final response = await http.post(Uri.parse(url), body: {
        'app': 'true',
        'tn': token,
      });

      final decodedData = json.decode(response.body);
      final int code = decodedData['result']['code'];
      if (code == 1) {
        for (var i = 0; i < decodedData['result']['data'].length; i++) {
          OrdenCompraModel ordenCompraModel = OrdenCompraModel();

          ordenCompraModel.idOp = decodedData['result']['data'][i]['id_op'];
          ordenCompraModel.opNumero = decodedData['result']['data'][i]['op_numero'];
          ordenCompraModel.opVencimiento = decodedData['result']['data'][i]['op_vencimiento'];
          ordenCompraModel.opMoneda = decodedData['result']['data'][i]['op_moneda'];
          ordenCompraModel.opTotal = decodedData['result']['data'][i]['op_total'];
          ordenCompraModel.opCondiciones = decodedData['result']['data'][i]['op_condiciones'];
          ordenCompraModel.opDateTime = decodedData['result']['data'][i]['op_datetime'];
          ordenCompraModel.opDateTiemAprobacion = decodedData['result']['data'][i]['op_datetime_aprobacion'];
          ordenCompraModel.opEstado = decodedData['result']['data'][i]['op_estado'];
          ordenCompraModel.opActivo = decodedData['result']['data'][i]['op_activo'];
          ordenCompraModel.proveedorNombre = decodedData['result']['data'][i]['proveedor_nombre'];
          ordenCompraModel.personName = decodedData['result']['data'][i]['person_name'];
          ordenCompraModel.personSurname = decodedData['result']['data'][i]['person_surname'];
          ordenCompraModel.personSurname2 = decodedData['result']['data'][i]['person_surname2'];
          ordenCompraModel.sedeNombre = decodedData['result']['data'][i]['sede'];

          await ordenCompraDatabase.insertarOrdenCompra(ordenCompraModel);

          var detalle = decodedData['result']['data'][i]['detalle'];

          if (detalle.length > 0) {
            for (var x = 0; x < detalle.length; x++) {
              DetalleOpModel detalleOpModel = DetalleOpModel();
              detalleOpModel.idDetalleOp = detalle[x]['id_detalleop'];
              detalleOpModel.idOp = detalle[x]['id_op'];
              detalleOpModel.detalleOpPrecioUnit = detalle[x]['detalleop_prec_unit'];
              detalleOpModel.detalleOpPrecioTotal = detalle[x]['detalleop_prec_tot'];
              detalleOpModel.opVencimiento = detalle[x]['op_vencimiento'];
              detalleOpModel.opNumero = detalle[x]['op_numero'];
              detalleOpModel.cantidad = detalle[x]['detallesi_cantidad'];
              detalleOpModel.atendido = detalle[x]['detallesi_atendido'];
              detalleOpModel.um = detalle[x]["detallesi_um"];
              detalleOpModel.descripcion = detalle[x]["detallesi_descripcion"];
              detalleOpModel.recursoTipo = detalle[x]['recurso_tipo'];
              detalleOpModel.recursoNombre = detalle[x]['recurso_nombre'];
              detalleOpModel.recursoCodigo = detalle[x]['recurso_codigo'];
              detalleOpModel.recursoComentario = detalle[x]['recurso_comentario'];
              detalleOpModel.recursoFoto = detalle[x]['recurso_foto'];
              detalleOpModel.recursoEstado = detalle[x]['recurso_estado'];
              detalleOpModel.proveedorNombre = decodedData['result']['data'][i]['proveedor_nombre'];
              detalleOpModel.proveedorRuc = decodedData['result']['data'][i]['proveedor_ruc'];
              detalleOpModel.proveedorDireccion = decodedData['result']['data'][i]['proveedor_direccion'];
              detalleOpModel.proveedorTelefono = decodedData['result']['data'][i]['proveedor_telefono'];
              detalleOpModel.proveedorContacto = decodedData['result']['data'][i]['proveedor_contacto'];
              detalleOpModel.proveedorEmail = decodedData['result']['data'][i]['proveedor_email'];
              await detalleOpDatabase.insertarDetalleOp(detalleOpModel);
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

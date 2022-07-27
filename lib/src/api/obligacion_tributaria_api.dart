import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:soal_app/core/database/detalle_ot_db.dart';
import 'package:soal_app/core/database/obligacion_tributaria_db.dart';
import 'package:soal_app/core/sharedpreferences/storage_manager.dart';
import 'package:soal_app/core/util/constants.dart';
import 'package:soal_app/src/models/detalle_ot_model.dart';
import 'package:soal_app/src/models/obligacion_tributaria_model.dart';

class ObligacionTributariaApi {
  final otDB = ObligacionTributariaDB();
  final detalleOTDB = DetalleOTDB();

  Future<int> getOTPendientes() async {
    try {
      final url = '$API_BASE_URL/api/Obligaciontributaria/ws_listar_pendientes_ot';
      String? token = await StorageManager.readData('token');
      final response = await http.post(Uri.parse(url), body: {
        'app': 'true',
        'tn': token,
      });
      if (response.statusCode == 200) {
        final decodedData = json.decode(response.body);
        for (var i = 0; i < decodedData["result"]["datos"].length; i++) {
          var total = 0.00;
          var datos = decodedData["result"]["datos"][i];
          final ot = ObligacionTributariaModel();
          ot.idObligacion = datos["id_obligacion"];
          ot.claseObligacion = datos["obligacion_clase"];
          ot.codigoObligacion = datos["obligacion_codigo"];
          ot.yearObligacion = datos["obligacion_periodo_anho"];
          ot.mesObligacion = datos["obligacion_periodo_mes"];
          ot.dateCreacionObligacion = datos["obligacion_fecha_creacion"];
          ot.horaCreacionObligacion = datos["obligacion_hora_creacion"];
          ot.dateInicioObligacion = datos["obligacion_fecha_inicio"];
          ot.dateFinObligacion = datos["obligacion_fecha_fin"];
          ot.estadoObligacion = datos["obligacion_estado"];
          ot.tipoObligacion = datos["obligacion_tipo"];
          ot.conceptoObligacion = datos["obligacion_concepto"];
          ot.activoObligacion = datos["obligacion_activo"];
          ot.monedaObligacion = datos["obligacion_moneda"];
          ot.importeObligacion = datos["obligacion_importe"];
          ot.documentacionObligacion = datos["obligacion_documentacion"];
          ot.dateAprobacionObligacion = datos["obligacion_fecha_aprobacion"];
          ot.horaAprobacionObligacion = datos["obligacion_hora_aprobacion"];
          ot.nombreEmpresa = datos["empresa_nombre"];
          ot.rucEmpresa = datos["empresa_ruc"];
          ot.direccionEmpresa = datos["empresa_direccion"];
          ot.responsableEmpresa = datos["empresa_responsable"];
          ot.cargoEmpresa = datos["empresa_responsable_cargo"];
          ot.nameCreate = datos["person_name"];
          ot.surnameCreate = datos["person_surname"];
          ot.surnameCreate2 = datos["person_surname2"];

          for (var x = 0; x < datos["detalles"].length; x++) {
            var d = datos["detalles"][x];
            final detalle = DetalleOTModel();

            detalle.idDetalleOT = d["id_obligacionper"];
            detalle.idOT = d["id_obligacion"];
            detalle.idPeriodo = d["id_periodo"];
            detalle.diasEfectivos = d["obligacionper_dias_efectivos"];
            detalle.diasLaborales = d["obligacionper_dias_laborales"];
            detalle.montoMensual = d["obligacionper_monto_mensual"];
            detalle.totalMensual = d["obligacionper_total_mensual"];
            detalle.subTotal = d["obligacionper_subtotal"];
            detalle.total = d["obligacionper_total"];
            detalle.bancoOT = d["obligacionper_banco"];
            detalle.cuentaOT = d["obligacionper_cuenta"];
            detalle.estadoOT = d["obligacionper_estado"];

            await detalleOTDB.insertarDetalleOT(detalle);
            total = total + double.parse(d["obligacionper_total"]);
          }

          ot.surnameCreate2 = total.toStringAsFixed(2);

          await otDB.insertarOT(ot);
        }
        return decodedData["result"];
      } else {
        return 2;
      }
    } catch (e) {
      return 2;
    }
  }
}

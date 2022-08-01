import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soal_app/core/util/utils.dart';
import 'package:soal_app/src/bloc/provider_bloc.dart';
import 'package:soal_app/src/models/detalle_ot_model.dart';
import 'package:soal_app/src/models/obligacion_tributaria_model.dart';
import 'package:soal_app/src/models/recurso_detalle_oc_model.dart';
import 'package:soal_app/src/widgets/show_loading.dart';
import 'package:soal_app/src/widgets/widgets.dart';

class DetalleOT extends StatelessWidget {
  const DetalleOT({Key? key, required this.ot}) : super(key: key);
  final ObligacionTributariaModel ot;

  @override
  Widget build(BuildContext context) {
    final otBloc = ProviderBloc.ot(context);
    otBloc.getDetalleOT(ot.idObligacion ?? '');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Obligación Tributaria',
          style: TextStyle(
            fontSize: ScreenUtil().setSp(20),
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: StreamBuilder<List<DetalleOTModel>>(
        stream: otBloc.detalleOTStream,
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isNotEmpty) {
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(16), vertical: ScreenUtil().setHeight(10)),
                  child: Column(
                    children: [
                      cards(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              ot.nombreEmpresa ?? '',
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(14),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: ScreenUtil().setHeight(6)),
                            rows(titulo: 'Fecha de Pago:', data: obtenerFecha(ot.dateInicioObligacion ?? ''), st: 11, sd: 12),
                            SizedBox(height: ScreenUtil().setHeight(4)),
                            rows(titulo: 'Fecha de Vencimiento:', data: obtenerFecha(ot.dateFinObligacion ?? ''), st: 11, sd: 12),
                            SizedBox(
                              height: ScreenUtil().setHeight(6),
                            ),
                          ],
                        ),
                        fondo: Colors.white,
                        color: Colors.blue,
                        height: 40,
                        mtop: 15,
                      ),
                      SizedBox(height: ScreenUtil().setHeight(20)),
                      ExpansionTile(
                        initiallyExpanded: true,
                        maintainState: true,
                        title: Text(
                          'Items',
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(16),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        children: snapshot.data!.asMap().entries.map((item) {
                          int idx = item.key;
                          return detalleItem(item.value, idx + 1);
                        }).toList(),
                      ),
                      SizedBox(height: ScreenUtil().setHeight(50)),
                    ],
                  ),
                ),
              );
            } else {
              return RefreshIndicator(
                onRefresh: () async {
                  otBloc.getDetalleOT(ot.idObligacion ?? '');
                  return null;
                },
                child: Center(
                  child: Text('Sin información, inténtelo nuevamente'),
                ),
              );
            }
          } else {
            return ShowLoadding(
              active: true,
              color: Colors.transparent,
            );
          }
        },
      ),
    );
  }

  Widget detalleItem(DetalleOTModel detalle, int i) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          SizedBox(
            width: ScreenUtil().setWidth(20),
            child: Text(i.toString()),
          ),
          Expanded(
            child: cards(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          detalle.bancoOT ?? '',
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(11),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: ScreenUtil().setHeight(4)),
                        rows(
                            titulo: 'Concepto del Tributo:',
                            data: detalle.cuentaOT ?? '',
                            st: 9,
                            sd: 12,
                            active: (detalle.estadoOT == '1') ? null : '1'),
                      ],
                    ),
                  ),
                  SizedBox(width: ScreenUtil().setWidth(6)),
                  Text(
                    "S/. ${detalle.total ?? ''}",
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(14),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              fondo: (detalle.estadoOT == '1') ? Colors.white : Colors.red.withOpacity(0.4),
              color: Colors.purple,
              height: 30,
              mtop: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget totality({required String titulo, required String data, required Color color}) {
    return Row(
      children: [
        Expanded(
          child: Text(
            titulo,
            style: TextStyle(
              fontSize: ScreenUtil().setSp(11),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(width: ScreenUtil().setWidth(6)),
        Text(
          data,
          style: TextStyle(
            fontSize: ScreenUtil().setSp(14),
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ],
    );
  }
}

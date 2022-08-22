import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soal_app/core/util/utils.dart';
import 'package:soal_app/src/bloc/provider_bloc.dart';
import 'package:soal_app/src/models/orden_compra_model.dart';
import 'package:soal_app/src/models/recurso_detalle_oc_model.dart';
import 'package:soal_app/src/pages/Actions/aprobar_oc.dart';
import 'package:soal_app/src/widgets/show_loading.dart';
import 'package:soal_app/src/widgets/widgets.dart';

class DetalleOC extends StatelessWidget {
  const DetalleOC({Key? key, required this.idOC}) : super(key: key);
  final String idOC;

  @override
  Widget build(BuildContext context) {
    final ocBloc = ProviderBloc.op(context);
    ocBloc.detalleOC(idOC);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Orden de Compra',
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
      body: StreamBuilder<List<OrdenCompraNewModel>>(
        stream: ocBloc.detalleOCStream,
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isNotEmpty) {
              var orden = snapshot.data![0];
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(16), vertical: ScreenUtil().setHeight(10)),
                  child: Column(
                    children: [
                      cards(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  'Fecha: ',
                                  style: TextStyle(
                                    fontSize: ScreenUtil().setSp(10),
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  obtenerFecha(orden.dateTimeCreateOC ?? ''),
                                  style: TextStyle(
                                    fontSize: ScreenUtil().setSp(10),
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              orden.nombreProyectoOC ?? '',
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(14),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: ScreenUtil().setHeight(6)),
                            rows(titulo: 'CC:', data: orden.ccOC ?? '', st: 11, sd: 12, crossAxisAlignment: CrossAxisAlignment.start),
                            SizedBox(height: ScreenUtil().setHeight(4)),
                            rows(titulo: 'Cliente:', data: orden.nombreEmpresa ?? '', st: 11, sd: 12, crossAxisAlignment: CrossAxisAlignment.start),
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
                      cards(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Facturar a',
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(10),
                                fontWeight: FontWeight.w500,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(height: ScreenUtil().setHeight(4)),
                            Text(
                              orden.nombreEmpresa ?? '',
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(14),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: ScreenUtil().setHeight(6)),
                            rows(titulo: 'RUC:', data: orden.rucEmpresa ?? '', st: 11, sd: 12, crossAxisAlignment: CrossAxisAlignment.start),
                            SizedBox(height: ScreenUtil().setHeight(4)),
                            rows(
                                titulo: 'Dirección:',
                                data: orden.direccionEmpresa ?? '',
                                st: 11,
                                sd: 12,
                                crossAxisAlignment: CrossAxisAlignment.start),
                            SizedBox(
                              height: ScreenUtil().setHeight(6),
                            ),
                          ],
                        ),
                        fondo: Colors.white,
                        color: Colors.green,
                        height: 60,
                        mtop: 15,
                      ),
                      SizedBox(height: ScreenUtil().setHeight(20)),
                      cards(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Proveedor',
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(10),
                                fontWeight: FontWeight.w500,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(height: ScreenUtil().setHeight(4)),
                            Text(
                              orden.nombreProveedor ?? '',
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(14),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: ScreenUtil().setHeight(6)),
                            rows(titulo: 'RUC:', data: orden.rucProveedor ?? '', st: 11, sd: 12, crossAxisAlignment: CrossAxisAlignment.start),
                            SizedBox(height: ScreenUtil().setHeight(4)),
                            rows(titulo: 'Proforma:', data: orden.proformaOC ?? '', st: 11, sd: 12, crossAxisAlignment: CrossAxisAlignment.start),
                            SizedBox(height: ScreenUtil().setHeight(4)),
                            rows(
                                titulo: 'Dirección:',
                                data: orden.direccionProveedor ?? '',
                                st: 11,
                                sd: 12,
                                crossAxisAlignment: CrossAxisAlignment.start),
                            SizedBox(height: ScreenUtil().setHeight(4)),
                            rows(
                                titulo: 'Teléfono:',
                                data: orden.telefonoProveedor ?? '',
                                st: 11,
                                sd: 12,
                                crossAxisAlignment: CrossAxisAlignment.start),
                            SizedBox(height: ScreenUtil().setHeight(4)),
                            rows(
                                titulo: 'Cond. Pago:',
                                data: orden.condicionPagoOC ?? '',
                                st: 11,
                                sd: 12,
                                crossAxisAlignment: CrossAxisAlignment.start),
                            SizedBox(height: ScreenUtil().setHeight(4)),
                            rows(titulo: 'Descuento:', data: orden.descuentoOC ?? '', st: 11, sd: 12, crossAxisAlignment: CrossAxisAlignment.start),
                            Divider(),
                            rows(
                                titulo: 'Contacto:',
                                data: orden.contactoProveedor ?? '',
                                st: 11,
                                sd: 12,
                                crossAxisAlignment: CrossAxisAlignment.start),
                            SizedBox(height: ScreenUtil().setHeight(4)),
                            rows(titulo: 'Correo:', data: orden.emailProveedor ?? '', st: 11, sd: 12, crossAxisAlignment: CrossAxisAlignment.start),
                            SizedBox(
                              height: ScreenUtil().setHeight(6),
                            ),
                          ],
                        ),
                        fondo: Colors.white,
                        color: Colors.orange,
                        height: 120,
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
                        children: orden.recursos!.map((item) => recursoItem(item)).toList(),
                      ),
                      SizedBox(height: ScreenUtil().setHeight(10)),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: cards(
                          child: Column(
                            children: [
                              totality(
                                  titulo: 'Sub Total',
                                  data: "${(orden.idMoneda == '1') ? 'S/.' : 'US\$'} ${orden.subTotalOC ?? ''}",
                                  color: Colors.black),
                              totality(
                                  titulo: 'Descuento ${orden.percentDescuentoOC ?? ''} %',
                                  data: "${(orden.idMoneda == '1') ? 'S/.' : 'US\$'} ${orden.descuentoOC ?? ''}",
                                  color: Colors.black),
                              totality(titulo: 'IGV 18%', data: "S/. ${orden.igvOC ?? ''}", color: Colors.black),
                              Divider(),
                              totality(
                                  titulo: 'Total', data: "${(orden.idMoneda == '1') ? 'S/.' : 'US\$'} ${orden.totalOC ?? ''}", color: Colors.green),
                            ],
                          ),
                          fondo: Colors.white,
                          color: Colors.blue,
                          height: 40,
                          mtop: 15,
                        ),
                      ),
                      SizedBox(height: ScreenUtil().setHeight(20)),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            //Aprobar OC
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                opaque: false,
                                pageBuilder: (context, animation, secondaryAnimation) {
                                  return AprobarOC(
                                    id: idOC,
                                    onChanged: (v) {
                                      Navigator.pop(context);
                                      final ocBloc = ProviderBloc.op(context);

                                      ocBloc.ocPendientes();
                                    },
                                  );
                                },
                                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                  var begin = const Offset(0.0, 1.0);
                                  var end = Offset.zero;
                                  var curve = Curves.ease;

                                  var tween = Tween(begin: begin, end: end).chain(
                                    CurveTween(curve: curve),
                                  );

                                  return SlideTransition(
                                    position: animation.drive(tween),
                                    child: child,
                                  );
                                },
                              ),
                            );
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                            ),
                            padding: MaterialStateProperty.all<EdgeInsets>(
                              EdgeInsets.symmetric(
                                horizontal: ScreenUtil().setWidth(15),
                                vertical: ScreenUtil().setHeight(4),
                              ),
                            ),
                          ),
                          icon: Icon(
                            Icons.check_circle_outline,
                            size: ScreenUtil().setHeight(25),
                          ),
                          label: Text(
                            'Aprobar',
                            style: TextStyle(fontSize: ScreenUtil().setSp(20), fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      SizedBox(height: ScreenUtil().setHeight(50)),
                    ],
                  ),
                ),
              );
            } else {
              return RefreshIndicator(
                onRefresh: () async {
                  ocBloc.detalleOC(idOC);
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

  Widget recursoItem(RecursoDetalleOCModel recurso) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: cards(
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Text(
                    recurso.nombreRecurso ?? '',
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(11),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: ScreenUtil().setHeight(4)),
                  rows(titulo: 'U.M.:', data: recurso.umRecurso ?? '', st: 9, sd: 10, crossAxisAlignment: CrossAxisAlignment.start),
                  rows(titulo: 'Cantidad:', data: recurso.cantidadDetalleOC ?? '', st: 9, sd: 10, crossAxisAlignment: CrossAxisAlignment.start),
                  rows(
                      titulo: 'Precio Unit.:',
                      data:
                          "${(recurso.precioUnitTDetalleOC == '1' || recurso.precioUnitTDetalleOC == '2') ? 'S/.' : 'US\$'} ${recurso.precioUnitDetalleOC ?? ''}",
                      st: 9,
                      sd: 10,
                      crossAxisAlignment: CrossAxisAlignment.start),
                ],
              ),
            ),
            SizedBox(width: ScreenUtil().setWidth(6)),
            Text(
              "${(recurso.precioUnitTDetalleOC == '1' || recurso.precioUnitTDetalleOC == '2') ? 'S/.' : 'US\$'} ${recurso.precioTotalDetalleOC ?? ''}",
              style: TextStyle(
                fontSize: ScreenUtil().setSp(14),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        fondo: Colors.white,
        color: Colors.purple,
        height: 40,
        mtop: 15,
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

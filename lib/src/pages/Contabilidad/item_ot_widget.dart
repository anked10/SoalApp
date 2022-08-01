import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soal_app/core/util/utils.dart';
import 'package:soal_app/src/bloc/provider_bloc.dart';
import 'package:soal_app/src/models/obligacion_tributaria_model.dart';
import 'package:soal_app/src/pages/Actions/aprobar_ot.dart';
import 'package:soal_app/src/pages/Actions/eliminar_ot.dart';
import 'package:soal_app/src/pages/Contabilidad/detalle_ot.dart';

class ItemOTWidget extends StatelessWidget {
  const ItemOTWidget({Key? key, required this.otP, required this.i}) : super(key: key);
  final ObligacionTributariaModel otP;
  final int i;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        onSelected: (value) {
          switch (value) {
            case 1:
              //Aprobar OT
              Navigator.push(
                context,
                PageRouteBuilder(
                  opaque: false,
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return AprobarOT(
                      id: otP.idObligacion.toString(),
                      onChanged: (v) {
                        Navigator.pop(context);
                        final otBloc = ProviderBloc.ot(context);

                        otBloc.getOTPendientes();
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
              break;
            case 2:
              //Ver OT
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return DetalleOT(
                      ot: otP,
                    );
                  },
                ),
              );
              break;
            case 3:
              //Eliminar OT
              Navigator.push(
                context,
                PageRouteBuilder(
                  opaque: false,
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return EliminarOT(
                      id: otP.idObligacion.toString(),
                      valueEliminarOT: '1',
                      onChanged: (v) {
                        Navigator.pop(context);
                        final otBloc = ProviderBloc.ot(context);

                        otBloc.getOTPendientes();
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
              break;
            default:
              break;
          }
        },
        itemBuilder: (context) => [
              PopupMenuItem(
                child: Row(
                  children: [
                    Icon(
                      Icons.check_circle_outline,
                      color: Color(0XFF050268),
                    ),
                    SizedBox(
                      width: ScreenUtil().setWidth(8),
                    ),
                    Text(
                      'Aprobar',
                      style: TextStyle(
                        color: Color(0XFF050268),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                value: 1,
              ),
              PopupMenuItem(
                child: Row(
                  children: [
                    Icon(
                      Icons.remove_red_eye,
                      color: Colors.blueGrey,
                    ),
                    SizedBox(
                      width: ScreenUtil().setWidth(8),
                    ),
                    Text(
                      'Visualizar',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
                value: 2,
              ),
              PopupMenuItem(
                child: Row(
                  children: [
                    Icon(
                      Icons.cancel_outlined,
                      color: Colors.redAccent,
                    ),
                    SizedBox(
                      width: ScreenUtil().setWidth(8),
                    ),
                    Text(
                      'Eliminar',
                      style: TextStyle(color: Colors.redAccent),
                    ),
                  ],
                ),
                value: 3,
              ),
            ],
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(16), vertical: ScreenUtil().setHeight(6)),
          child: Row(
            children: [
              SizedBox(
                width: ScreenUtil().setWidth(20),
                child: Text(i.toString()),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.transparent.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                otP.nombreEmpresa ?? '',
                                style: TextStyle(
                                  fontSize: ScreenUtil().setSp(14),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(6),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: ScreenUtil().setWidth(120),
                                    child: Column(
                                      children: [
                                        Text(
                                          'Fecha de Pago',
                                          style: TextStyle(
                                            fontSize: ScreenUtil().setSp(11),
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Text(
                                          obtenerFecha(otP.dateInicioObligacion ?? ''),
                                          style: TextStyle(
                                            fontSize: ScreenUtil().setSp(11),
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: ScreenUtil().setHeight(20),
                                    width: ScreenUtil().setWidth(0.5),
                                    color: Colors.grey.withOpacity(0.4),
                                  ),
                                  Container(
                                    width: ScreenUtil().setWidth(120),
                                    child: Column(
                                      children: [
                                        Text(
                                          'Fecha Vencimiento',
                                          style: TextStyle(
                                            fontSize: ScreenUtil().setSp(11),
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Text(
                                          obtenerFecha(otP.dateFinObligacion ?? ''),
                                          style: TextStyle(
                                            fontSize: ScreenUtil().setSp(11),
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Divider(),
                              Row(
                                children: [
                                  Text(
                                    'Solicitante:',
                                    style: TextStyle(
                                      fontSize: ScreenUtil().setSp(10),
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  SizedBox(
                                    width: ScreenUtil().setWidth(4),
                                  ),
                                  Text(
                                    "${otP.nameCreate?.split(' ').first} ${otP.surnameCreate ?? ''}",
                                    style: TextStyle(
                                      fontSize: ScreenUtil().setSp(10),
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    otP.monedaObligacion ?? '',
                                    style: TextStyle(
                                      fontSize: ScreenUtil().setSp(13),
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  SizedBox(
                                    width: ScreenUtil().setWidth(6),
                                  ),
                                  Text(
                                    otP.montoTotal ?? '',
                                    style: TextStyle(
                                      fontSize: ScreenUtil().setSp(15),
                                      fontWeight: FontWeight.w600,
                                      color: Colors.green,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: ScreenUtil().setWidth(6),
                        height: ScreenUtil().setHeight(60),
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            bottomLeft: Radius.circular(5),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

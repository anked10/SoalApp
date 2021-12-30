import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soal_app/core/util/utils.dart';
import 'package:soal_app/src/bloc/provider_bloc.dart';
import 'package:soal_app/src/models/si_model.dart';
import 'package:soal_app/src/pages/Proveedores/busqueda_proveedores.dart';
import 'package:soal_app/src/pages/SolCompras/detalle_si_page.dart';
import 'package:soal_app/src/pages/SolCompras/documentos_solicitud.dart';

class SolComprasPage extends StatefulWidget {
  const SolComprasPage({Key? key}) : super(key: key);

  @override
  _SolComprasPageState createState() => _SolComprasPageState();
}

class _SolComprasPageState extends State<SolComprasPage> {
  List<String> itemsCabeceraTabla = [
    'NÚMERO',
    '   SEDE   ',
    'CONCEPTO DE LA\nSOLICITUD',
    'PROYECTO',
    'SOLICITADO POR',
    'ESTADO',
  ];

  @override
  Widget build(BuildContext context) {
    final siBloc = ProviderBloc.si(context);
    siBloc.obtenerSi();

    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: StreamBuilder(
        stream: siBloc.siStream,
        builder: (BuildContext context, AsyncSnapshot<List<SiModel>> snapshote) {
          if (snapshote.hasData) {
            if (snapshote.data!.length > 0) {
              var listOficial = snapshote.data;
              return SafeArea(
                bottom: false,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(10),
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Solicitud de compras',
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(27),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                         
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation, secondaryAnimation) {
                                    return BusquedaProveedor();
                                  },
                                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                    var begin = Offset(0.0, 1.0);
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
                            iconSize: ScreenUtil().setSp(35),
                            icon: Icon(
                              Icons.search,
                              color: Color(0xff454799),
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemCount: 1,
                        itemBuilder: (context, iiii) {
                          return Container(
                            color: Color(0xFFF5F4F4),
                            padding: EdgeInsets.symmetric(
                              vertical: ScreenUtil().setHeight(10),
                              horizontal: ScreenUtil().setWidth(5),
                            ),
                            height: ScreenUtil().setHeight(80) * (listOficial!.length + 1) ,
                            child: Row(
                              children: [
                                Container(
                                  width: size.width * .25,
                                  child: ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: listOficial.length + 1,
                                    itemBuilder: (context, index) {
                                      var ayno = maxLines(
                                        'FECHA DE\nSOLICITUD',
                                        ScreenUtil().setWidth(150),
                                        TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: ScreenUtil().setSp(14),
                                        ),
                                      );
                                      if (index == 0) {
                                        return Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              height: ayno * ScreenUtil().setHeight(20),
                                              child: Center(
                                                child: Text(
                                                  'FECHA DE SOLICITUD',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: ScreenUtil().setSp(18),
                                                    color: Color(0xffFBB03F),
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                            Divider(
                                              thickness: 1,
                                              color: Color(0xffFBB03F),
                                            )
                                          ],
                                        );
                                      }
                                      index = index - 1;

                                      int lineas = 2;
                                      var lineasCaptadas = maxLines(
                                        '${listOficial[index].siDatetime}',
                                        ScreenUtil().setWidth(150),
                                        TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: ScreenUtil().setSp(14),
                                        ),
                                      );
                                      if (lineasCaptadas > 2) {
                                        lineas = lineasCaptadas;
                                      }
                                      return Column(
                                        children: [
                                          focusGeneral(
                                              Container(
                                                height: lineas * ScreenUtil().setHeight(25),
                                                child: Container(
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          '${listOficial[index].siDatetime}',
                                                          textAlign: TextAlign.center,
                                                          style: TextStyle(
                                                            fontWeight: FontWeight.w400,
                                                            fontSize: ScreenUtil().setSp(14),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              listOficial,
                                              index),
                                          Divider()
                                        ],
                                      );
                                    },
                                  ),
                                ),
                                Container(
                                  width: size.width * .72,
                                  //color: Colors.grey[200],
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    padding: EdgeInsets.zero,
                                    physics: BouncingScrollPhysics(),
                                    itemCount: itemsCabeceraTabla.length,
                                    itemBuilder: (context, index) {
                                      //return Container(child: Text('0'));
                                      return Container(
                                        width: (maxAncho(
                                          itemsCabeceraTabla[index],
                                          ScreenUtil().setWidth(180),
                                          TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: ScreenUtil().setSp(18),
                                            color: Color(0xffFBB03F),
                                          ),
                                        )),
                                        child: ListView.builder(
                                          itemCount: listOficial.length + 1,
                                          shrinkWrap: true,
                                          padding: EdgeInsets.zero,
                                          physics: NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, index2) {
                                            var ayno = maxLines(
                                              'INFORMACIÒN\nBANCARIA',
                                              ScreenUtil().setWidth(180),
                                              TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: ScreenUtil().setSp(14),
                                              ),
                                            );
                                            if (index2 == 0) {
                                              return Column(
                                                children: [
                                                  Container(
                                                    height: ayno * ScreenUtil().setHeight(20),
                                                    child: Center(
                                                      child: Text(
                                                        '${itemsCabeceraTabla[index]}',
                                                        style: TextStyle(
                                                          fontWeight: FontWeight.w600,
                                                          fontSize: ScreenUtil().setSp(18),
                                                          color: Color(0xffFBB03F),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Divider(
                                                    thickness: 1,
                                                    color: Color(0xffFBB03F),
                                                  )
                                                ],
                                              );
                                            }
                                            index2 = index2 -1;
                                            int lineas = 2;
                                            var lineasCaptadas = maxLines(
                                              '${listOficial[index].sedeNombre}',
                                              ScreenUtil().setWidth(180),
                                              TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: ScreenUtil().setSp(14),
                                              ),
                                            );

                                            if (lineasCaptadas > 2) {
                                              lineas = lineasCaptadas;
                                            }
                                            return Column(
                                              children: [
                                                focusGeneral(
                                                    Container(
                                                      padding: EdgeInsets.symmetric(
                                                        horizontal: ScreenUtil().setWidth(5),
                                                      ),
                                                      height: lineas * ScreenUtil().setHeight(25),
                                                      child: Container(
                                                        child: Center(
                                                          child: (itemsCabeceraTabla[index] == 'NÚMERO')
                                                              ? Text(
                                                                  '${listOficial[index2].siNumero}',
                                                                  textAlign: TextAlign.center,
                                                                  style: TextStyle(
                                                                    fontSize: ScreenUtil().setSp(15),
                                                                  ),
                                                                )
                                                              : (itemsCabeceraTabla[index] == '   SEDE   ')
                                                                  ? Text(
                                                                      '${listOficial[index2].sedeNombre}',
                                                                      textAlign: TextAlign.center,
                                                                      style: TextStyle(
                                                                        fontSize: ScreenUtil().setSp(15),
                                                                      ),
                                                                    )
                                                                  : (itemsCabeceraTabla[index] == 'CONCEPTO DE LA\nSOLICITUD')
                                                                      ? Text(
                                                                          '${listOficial[index2].siObservaciones}',
                                                                          textAlign: TextAlign.center,
                                                                          style: TextStyle(
                                                                            fontSize: ScreenUtil().setSp(15),
                                                                          ),
                                                                        )
                                                                      : (itemsCabeceraTabla[index] == 'PROYECTO')
                                                                          ? Text(
                                                                              '${listOficial[index2].proyectoNombre}',
                                                                              textAlign: TextAlign.center,
                                                                              style: TextStyle(
                                                                                fontSize: ScreenUtil().setSp(15),
                                                                              ),
                                                                            )
                                                                          : (itemsCabeceraTabla[index] == 'SOLICITADO POR')
                                                                              ? Text(
                                                                                  '${listOficial[index2].personName} ${listOficial[index2].personSurname}',
                                                                                  textAlign: TextAlign.center,
                                                                                  style: TextStyle(
                                                                                    fontSize: ScreenUtil().setSp(15),
                                                                                  ),
                                                                                )
                                                                              : (itemsCabeceraTabla[index] == 'ESTADO')
                                                                                  ? Text(
                                                                                      '${listOficial[index2].siEstado}',
                                                                                      textAlign: TextAlign.center,
                                                                                      style: TextStyle(
                                                                                        fontWeight: FontWeight.bold,
                                                                                        fontSize: ScreenUtil().setSp(15),
                                                                                      ),
                                                                                    )
                                                                                  : Text(''),
                                                        ),
                                                      ),
                                                    ),
                                                    listOficial,
                                                    index2),
                                                Divider()
                                              ],
                                            );
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              );
            } else {
              return Center(
                child: Text('No hay Solicitudes de compra'),
              );
            }
          } else {
            return Center(
              child: CupertinoActivityIndicator(),
            );
          }
        },
      ),
    );
  }

  FocusedMenuHolder focusGeneral(
    Widget childs,
    List<SiModel> si,
    int index,
  ) {
    return FocusedMenuHolder(
        blurBackgroundColor: Colors.black.withOpacity(0.2),
        blurSize: 0,
        animateMenuItems: true,
        onPressed: () {},
        openWithTap: true,
        menuWidth: ScreenUtil().setWidth(210),
        menuItems: [
         
          FocusedMenuItem(
            title: Expanded(
              child: Text(
                "ver Detalles",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w400,
                  fontSize: ScreenUtil().setSp(18),
                  letterSpacing: ScreenUtil().setSp(0.016),
                  color: Colors.black,
                ),
              ),
            ),
            trailingIcon: Icon(
              Icons.edit_outlined,
              color: Colors.grey,
              size: ScreenUtil().setHeight(20),
            ),
            onPressed: () async {
                Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return DetalleSiPage(
                      simodel: si[index],
                    );
                  },
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    var begin = Offset(0.0, 1.0);
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
          ),

           FocusedMenuItem(
            title: Expanded(
              child: Text(
                "Documentos",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w400,
                  fontSize: ScreenUtil().setSp(18),
                  letterSpacing: ScreenUtil().setSp(0.016),
                  color: Colors.black,
                ),
              ),
            ),
            trailingIcon: Icon(
              Icons.edit_outlined,
              color: Colors.grey,
              size: ScreenUtil().setHeight(20),
            ),
            onPressed: () async {
                Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return DocumentosSolicitud(
                      simodel: si[index],
                    );
                  },
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    var begin = Offset(0.0, 1.0);
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
          ),
          
        ],
        child: childs);
  }
}

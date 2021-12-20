import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soal_app/core/util/utils.dart';
import 'package:soal_app/src/bloc/provider_bloc.dart';
import 'package:soal_app/src/models/proveedores_model.dart';
import 'package:soal_app/src/pages/Proveedores/busqueda_proveedores.dart';
import 'package:soal_app/src/pages/Proveedores/detail_proveedor.dart';

class ProveedoresPage extends StatefulWidget {
  const ProveedoresPage({Key? key}) : super(key: key);

  @override
  _ProveedoresPageState createState() => _ProveedoresPageState();
}

class _ProveedoresPageState extends State<ProveedoresPage> {
  List<String> itemsCabeceraTabla = [
    'RUC    ',
    'DIRECCIÓN',
    'TELEFONO',
    'CONTACTO',
    '     CLASE      ',
    'CLASE\nGENERAL',
    'INFORMACIÒN\nBANCARIA',
  ];

  @override
  Widget build(BuildContext context) {
    final proveedoresBloc = ProviderBloc.provee(context);
    proveedoresBloc.obtenerProveedores();

    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: StreamBuilder(
        stream: proveedoresBloc.proveedoresStream,
        builder: (BuildContext context, AsyncSnapshot<List<ProveedorModel>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.length > 0) {
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
                            'Proveedores',
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(30),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                          IconButton(
                            onPressed: () {},
                            iconSize: ScreenUtil().setSp(35),
                            icon: Icon(
                              Icons.add,
                              color: Color(0xff454799),
                            ),
                          ),
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
                              /* showSearch(
                                context: context,
                                delegate: DataSearch(hintText: 'Buscar'),
                              ); */
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
                            height: ScreenUtil().setHeight(45) * (snapshot.data!.length + 1) + ScreenUtil().setHeight(45),
                            child: Row(
                              children: [
                                Container(
                                  width: size.width * .25,
                                  child: ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: snapshot.data!.length + 1,
                                    itemBuilder: (context, index) {
                                      var ayno = maxLines(
                                        'INFORMACIÒN\nBANCARIA',
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
                                                  'RAZÓN SOCIAL',
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

                                      int lineas = 4;
                                      var lineasCaptadas = maxLines(
                                        '${snapshot.data![index].contacto} \n${snapshot.data![index].email}',
                                        ScreenUtil().setWidth(150),
                                        TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: ScreenUtil().setSp(14),
                                        ),
                                      );
                                      if (lineasCaptadas > 4) {
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
                                                          '${snapshot.data![index].nombre}',
                                                          maxLines: 2,
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
                                              snapshot.data!,
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
                                          itemCount: snapshot.data!.length + 1,
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
                                                  Divider(thickness: 1, color: Color(0xffFBB03F))
                                                ],
                                              );
                                            }
                                            index2 = index2 - 1;
                                            int lineas = 4;
                                            var lineasCaptadas = maxLines(
                                              '${snapshot.data![index].contacto} \n${snapshot.data![index].email}',
                                              ScreenUtil().setWidth(180),
                                              TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: ScreenUtil().setSp(14),
                                              ),
                                            );

                                            if (lineasCaptadas > 4) {
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
                                                          child: (itemsCabeceraTabla[index] == 'RUC    ')
                                                              ? Text(
                                                                  '${snapshot.data![index2].ruc}',
                                                                  style: TextStyle(fontSize: ScreenUtil().setSp(15)),
                                                                )
                                                              : (itemsCabeceraTabla[index] == 'DIRECCIÓN')
                                                                  ? Text(
                                                                      '${snapshot.data![index2].direccion}',
                                                                      style: TextStyle(fontSize: ScreenUtil().setSp(15)),
                                                                    )
                                                                  : (itemsCabeceraTabla[index] == 'TELEFONO')
                                                                      ? Text(
                                                                          '${snapshot.data![index2].telefono}',
                                                                          style: TextStyle(fontSize: ScreenUtil().setSp(15)),
                                                                        )
                                                                      : (itemsCabeceraTabla[index] == 'CONTACTO')
                                                                          ? Text(
                                                                              '${snapshot.data![index2].contacto} /\n${snapshot.data![index2].email}',
                                                                              style: TextStyle(fontSize: ScreenUtil().setSp(15)),
                                                                            )
                                                                          : (itemsCabeceraTabla[index] == 'EMAIL')
                                                                              ? Text(
                                                                                  '${snapshot.data![index2].email}',
                                                                                  style: TextStyle(fontSize: ScreenUtil().setSp(15)),
                                                                                )
                                                                              : (itemsCabeceraTabla[index] == '     CLASE      ')
                                                                                  ? Text(
                                                                                      '${snapshot.data![index2].clase1}\n${snapshot.data![index2].clase2}\n${snapshot.data![index2].clase3}\n${snapshot.data![index2].clase4}',
                                                                                      style: TextStyle(
                                                                                          fontWeight: FontWeight.bold,
                                                                                          fontSize: ScreenUtil().setSp(15)),
                                                                                    )
                                                                                  : (itemsCabeceraTabla[index] == 'CLASE\nGENERAL')
                                                                                      ? Text(
                                                                                          ('${snapshot.data![index2].claseGeneral}' == '0')
                                                                                              ? 'Bienes'
                                                                                              : ('${snapshot.data![index2].claseGeneral}' == '1')
                                                                                                  ? 'Servicios'
                                                                                                  : ('${snapshot.data![index2].claseGeneral}' == '2')
                                                                                                      ? 'Bienes / Servicios'
                                                                                                      : '--',
                                                                                          style: TextStyle(fontSize: ScreenUtil().setSp(15)),
                                                                                        )
                                                                                      : (itemsCabeceraTabla[index] == 'INFORMACIÒN\nBANCARIA')
                                                                                          ? Text(
                                                                                              '${snapshot.data![index2].banco1}\n${snapshot.data![index2].banco2}\n${snapshot.data![index2].banco3}',
                                                                                              style: TextStyle(fontSize: ScreenUtil().setSp(15)),
                                                                                            )
                                                                                          : Text(''),
                                                        ),
                                                      ),
                                                    ),
                                                    snapshot.data!,
                                                    index),
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
                child: Text('No hay proveedores'),
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

  FocusedMenuHolder focusGeneral(Widget childs, List<ProveedorModel> proveedores, int index) {
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
              Icons.insert_drive_file_sharp,
              color: Colors.grey,
              size: ScreenUtil().setHeight(20),
            ),
            onPressed: () {
              //DetailProveedor
            },
          ),
          FocusedMenuItem(
            title: Expanded(
              child: Text(
                "ver",
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
                    return DetailProveedor(
                      proveedor: proveedores[index],
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
                "Eliminar",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w400,
                  fontSize: ScreenUtil().setSp(18),
                  letterSpacing: ScreenUtil().setSp(0.016),
                  color: Colors.black,
                ),
              ),
            ),
            trailingIcon: Icon(
              Icons.delete_outlined,
              color: Colors.grey,
              size: ScreenUtil().setHeight(20),
            ),
            onPressed: () async {},
          ),
        ],
        child: childs);
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soal_app/core/database/sedes_database.dart';
import 'package:soal_app/core/util/utils.dart';
import 'package:soal_app/src/bloc/almacen_bloc.dart';
import 'package:soal_app/src/bloc/provider_bloc.dart';
import 'package:soal_app/src/models/almacenModel.dart';
import 'package:soal_app/src/models/sedesModel.dart';
import 'package:soal_app/src/pages/Almacen/busqueda_almacen.dart';
import 'package:soal_app/src/widgets/responsive.dart';

class AlmacenPage extends StatefulWidget {
  const AlmacenPage({Key? key}) : super(key: key);

  @override
  _AlmacenPageState createState() => _AlmacenPageState();
}

class _AlmacenPageState extends State<AlmacenPage> {
  String sedeValue = '';
  int valor = 0;
  List<String> itemsCabeceraTabla = [
    'CÓDIGO',
    '     CLASE     ',
    'DENOMINACION',
    'U.M.',
    'CANTIDAD',
    'SEDE',
  ];

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    final almacenBloc = ProviderBloc.almacen(context);
    if (valor == 0) {
      almacenBloc.getSedes();
    }

    return Scaffold(
      body: StreamBuilder(
        stream: almacenBloc.sedesStream,
        builder: (BuildContext context, AsyncSnapshot<List<SedesModel>> snapshote) {
          if (snapshote.hasData) {
            if (snapshote.data!.length > 0) {
              var listOficial = snapshote.data;

              if (valor == 0) {
                sedeValue = listOficial![0].sedeNombre.toString();
                almacenBloc.getAlmacenPorSede(listOficial[0].idSede.toString());
                valor++;
              }
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
                            'Almacén',
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
                                    return BusquedaAlmacen();
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
                    dropButtonSedes(snapshote.data!),
                    StreamBuilder(
                      stream: almacenBloc.almacenStream,
                      builder: (BuildContext context, AsyncSnapshot<List<AlmacenModel>> data) {
                        if (data.hasData) {
                          if (data.data!.length > 0) {
                            return Expanded(
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
                                    height: ScreenUtil().setHeight(70) * (data.data!.length + 1),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: responsive.wp(25),
                                          child: ListView.builder(
                                            physics: NeverScrollableScrollPhysics(),
                                            itemCount: data.data!.length + 1,
                                            itemBuilder: (context, indexPrimero) {
                                              var ayno = maxLines(
                                                'INFORMACIÒN\nBANCARIA',
                                                ScreenUtil().setWidth(150),
                                                TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: ScreenUtil().setSp(14),
                                                ),
                                              );
                                              if (indexPrimero == 0) {
                                                return Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      height: ayno * ScreenUtil().setHeight(20),
                                                      child: Center(
                                                        child: Text(
                                                          'Tipo',
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
                                              indexPrimero = indexPrimero - 1;

                                              int lineas = 2;

                                              return Column(
                                                children: [
                                                  Container(
                                                    height: lineas * ScreenUtil().setHeight(25),
                                                    child: Container(
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            child: Text(
                                                              '${data.data![indexPrimero].logisticaTipoNombre}',
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
                                                  Divider()
                                                ],
                                              );
                                            },
                                          ),
                                        ),
                                        Container(
                                          width: responsive.wp(72),
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
                                                  itemCount: data.data!.length + 1,
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
                                                    int lineas = 2;

                                                    return Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Container(
                                                          padding: EdgeInsets.symmetric(
                                                            horizontal: ScreenUtil().setWidth(5),
                                                          ),
                                                          height: lineas * ScreenUtil().setHeight(25),
                                                          child: Container(
                                                            child: Center(
                                                              child: (itemsCabeceraTabla[index] == 'CÓDIGO')
                                                                  ? Text(
                                                                      '${data.data![index2].recursoCodigo}',
                                                                      style: TextStyle(fontSize: ScreenUtil().setSp(15)),
                                                                    )
                                                                  : (itemsCabeceraTabla[index] == '     CLASE     ')
                                                                      ? Text(
                                                                          '${data.data![index2].logisticaClaseNombre}',
                                                                          style: TextStyle(fontSize: ScreenUtil().setSp(15)),
                                                                        )
                                                                      : (itemsCabeceraTabla[index] == 'DENOMINACION')
                                                                          ? Text(
                                                                              '${data.data![index2].recursoNombre}',
                                                                              textAlign: TextAlign.start,
                                                                              style: TextStyle(fontSize: ScreenUtil().setSp(15)),
                                                                            )
                                                                          : (itemsCabeceraTabla[index] == 'U.M.')
                                                                              ? Text(
                                                                                  '${data.data![index2].almacenUnidad}',
                                                                                  style: TextStyle(fontSize: ScreenUtil().setSp(15)),
                                                                                )
                                                                              : (itemsCabeceraTabla[index] == 'CANTIDAD')
                                                                                  ? Text(
                                                                                      '${data.data![index2].almacenStock}',
                                                                                      style: TextStyle(fontSize: ScreenUtil().setSp(15)),
                                                                                    )
                                                                                  : (itemsCabeceraTabla[index] == '     CLASE      ')
                                                                                      ? Text(
                                                                                          '${data.data![index2].logisticaClaseNombre}',
                                                                                          style: TextStyle(
                                                                                              fontWeight: FontWeight.bold,
                                                                                              fontSize: ScreenUtil().setSp(15)),
                                                                                        )
                                                                                      : (itemsCabeceraTabla[index] == 'SEDE')
                                                                                          ? Text(
                                                                                              '${data.data![index2].idEmpresa}',
                                                                                              style: TextStyle(fontSize: ScreenUtil().setSp(15)),
                                                                                            )
                                                                                          : Text(''),
                                                            ),
                                                          ),
                                                        ),
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
                            );
                          } else {
                            return Column(
                              children: [
                                SizedBox(
                                  height: ScreenUtil().setHeight(20),
                                ),
                                Text('No hay datos en este Almacén'),
                              ],
                            );
                          }
                        } else {
                          return Center(
                            child: CupertinoActivityIndicator(),
                          );
                        }
                      },
                    ),
                  ],
                ),
              );
            } else {
              return Center(
                child: Text('No existen Sedes'),
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

  List<String> sedesCustomList = [];
  Widget dropButtonSedes(List<SedesModel> sedes) {
    sedesCustomList.clear();

    for (int i = 0; i < sedes.length; i++) {
      String sedesitos = sedes[i].sedeNombre.toString();
      sedesCustomList.add(sedesitos);
    }
    final algo = sedesCustomList.toSet().toList();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(10)),
      child: Row(
        children: [
          Text(
            'Sede :   ',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(5),
              ),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  border: Border.all(
                    color: Colors.grey.shade300,
                  )),
              child: DropdownButton<String>(
                dropdownColor: Colors.white,
                value: sedeValue,
                icon: Icon(Icons.arrow_drop_down),
                iconSize: ScreenUtil().setSp(20),
                elevation: 16,
                isExpanded: true,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: ScreenUtil().setSp(16),
                ),
                underline: Container(),
                onChanged: (String? data) {
                  setState(() {
                    sedeValue = data.toString();
                    final almacenBloc = ProviderBloc.almacen(context);

                    ellanoTeAma(almacenBloc, sedeValue);

                    valor++;
                  });
                },
                items: algo.map((value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      maxLines: 3,
                      style: TextStyle(color: Colors.black),
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void ellanoTeAma(AlmacenBloc almacenBloc, String dato) async {
  final sedesDatabase = SedesDatabase();

  final sedis = await sedesDatabase.getSedesForName(dato);

  almacenBloc.getAlmacenPorSede(sedis[0].idSede.toString());
}

import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:soal_app/core/util/utils.dart';
import 'package:soal_app/src/bloc/provider_bloc.dart';
import 'package:soal_app/src/models/almacenModel.dart';
import 'package:soal_app/src/widgets/responsive.dart';

enum EstadoBusqueda { inicio, datos, vacio }

class BusquedaAlmacen extends StatefulWidget {
  const BusquedaAlmacen({Key? key}) : super(key: key);

  @override
  _BusquedaAlmacenState createState() => _BusquedaAlmacenState();
}

class _BusquedaAlmacenState extends State<BusquedaAlmacen> {
  List<String> itemsCabeceraTabla = [
    'CÓDIGO',
    '     CLASE     ',
    'DENOMINACION',
    'U.M.',
    'CANTIDAD',
    'SEDE',
  ];

  TextEditingController _controller = TextEditingController();

  dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final almacenBloc = ProviderBloc.almacen(context);
    almacenBloc.obtenerAlmacenPorQueryDelivery('');

    final provider = Provider.of<EstadoListenerAlmacen>(context, listen: false);
    final responsive = Responsive.of(context);
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: provider._estado,
        builder: (BuildContext context, EstadoBusqueda data, Widget? child) {
          return Column(
            children: [
              Container(
                color: Colors.white,
                padding: EdgeInsets.only(
                  bottom: ScreenUtil().setHeight(10),
                ),
                child: SafeArea(
                  child: Row(
                    children: [
                      BackButton(),
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            prefixIcon: Icon(Icons.search),
                            hintText: "Buscar producto en almacén",
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                          ),
                          onChanged: (value) {
                            provider.changeDatos();
                            almacenBloc.obtenerAlmacenPorQueryDelivery(value);
                          },
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            provider.changeInicio();

                            _controller.text = '';
                          },
                          icon: Icon(Icons.close)),
                      SizedBox(
                        width: ScreenUtil().setWidth(10),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(10),
              ),
              (data == EstadoBusqueda.datos)
                  ? StreamBuilder(
                      stream: almacenBloc.busquedaAlmacenStream,
                      builder: (BuildContext context, AsyncSnapshot<List<AlmacenModel>> snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data!.length > 0) {
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
                                    height: ScreenUtil().setHeight(60) * (snapshot.data!.length + 1),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: responsive.wp(20),
                                          child: ListView.builder(
                                            padding: EdgeInsets.zero,
                                            physics: NeverScrollableScrollPhysics(),
                                            itemCount: snapshot.data!.length + 1,
                                            itemBuilder: (context, indexPrimero) {
                                              var ayno = maxLines(
                                                'FECHA DE\nSOLICITUD',
                                                ScreenUtil().setWidth(180),
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
                                                          'TIPO',
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
                                                              '${snapshot.data![indexPrimero].logisticaTipoNombre}',
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
                                                  itemCount: snapshot.data!.length + 1,
                                                  shrinkWrap: true,
                                                  padding: EdgeInsets.zero,
                                                  physics: NeverScrollableScrollPhysics(),
                                                  itemBuilder: (context, index2) {
                                                    var ayno = maxLines(
                                                      'FECHA DE\nSOLICITUD',
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
                                                                      '${snapshot.data![index2].recursoCodigo}',
                                                                      style: TextStyle(fontSize: ScreenUtil().setSp(15)),
                                                                    )
                                                                  : (itemsCabeceraTabla[index] == '     CLASE     ')
                                                                      ? Text(
                                                                          '${snapshot.data![index2].logisticaClaseNombre}',
                                                                          style: TextStyle(fontSize: ScreenUtil().setSp(15)),
                                                                        )
                                                                      : (itemsCabeceraTabla[index] == 'DENOMINACION')
                                                                          ? Text(
                                                                              '${snapshot.data![index2].recursoNombre}',
                                                                              textAlign: TextAlign.start,
                                                                              style: TextStyle(fontSize: ScreenUtil().setSp(15)),
                                                                            )
                                                                          : (itemsCabeceraTabla[index] == 'U.M.')
                                                                              ? Text(
                                                                                  '${snapshot.data![index2].almacenUnidad}',
                                                                                  style: TextStyle(fontSize: ScreenUtil().setSp(15)),
                                                                                )
                                                                              : (itemsCabeceraTabla[index] == 'CANTIDAD')
                                                                                  ? Text(
                                                                                      '${snapshot.data![index2].almacenStock}',
                                                                                      style: TextStyle(fontSize: ScreenUtil().setSp(15)),
                                                                                    )
                                                                                  : (itemsCabeceraTabla[index] == '     CLASE      ')
                                                                                      ? Text(
                                                                                          '${snapshot.data![index2].logisticaClaseNombre}',
                                                                                          style: TextStyle(
                                                                                              fontWeight: FontWeight.bold,
                                                                                              fontSize: ScreenUtil().setSp(15)),
                                                                                        )
                                                                                      : (itemsCabeceraTabla[index] == 'SEDE')
                                                                                          ? Text(
                                                                                              '${snapshot.data![index2].idEmpresa}',
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: ScreenUtil().setSp(200),
                                  width: ScreenUtil().setSp(200),
                                  child: SvgPicture.asset(
                                    'assets/svg/backBusquedaAlmacen.svg',
                                  ),
                                ),
                                Text('No existen productos'),
                              ],
                            );
                          }
                        } else {
                          return Center(
                            child: CupertinoActivityIndicator(),
                          );
                        }
                      },
                    )
                  : (data == EstadoBusqueda.inicio)
                      ? Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: ScreenUtil().setSp(200),
                                width: ScreenUtil().setSp(200),
                                child: SvgPicture.asset(
                                  'assets/svg/backBusquedaAlmacen.svg',
                                ),
                              ),
                              Text('Buscar productos en almacén'),
                            ],
                          ),
                        )
                      : (data == EstadoBusqueda.vacio)
                          ? Container()
                          : Container()
            ],
          );
        },
      ),
    );
  }
}

class EstadoListenerAlmacen with ChangeNotifier {
  ValueNotifier<EstadoBusqueda> _estado = ValueNotifier(EstadoBusqueda.inicio);
  ValueNotifier<EstadoBusqueda> get estado => this._estado;

  void changeVacio() {
    _estado.value = EstadoBusqueda.vacio;
    notifyListeners();
  }

  void changeInicio() {
    _estado.value = EstadoBusqueda.inicio;
    notifyListeners();
  }

  void changeDatos() {
    _estado.value = EstadoBusqueda.datos;
    notifyListeners();
  }
}

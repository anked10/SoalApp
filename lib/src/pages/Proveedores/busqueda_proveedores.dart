import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:soal_app/src/bloc/provider_bloc.dart';
import 'package:soal_app/src/models/proveedores_model.dart';
import 'package:soal_app/src/pages/Proveedores/detail_proveedor.dart';

enum EstadoBusqueda { inicio, datos, vacio }

class BusquedaProveedor extends StatefulWidget {
  const BusquedaProveedor({Key? key}) : super(key: key);

  @override
  _BusquedaProveedorState createState() => _BusquedaProveedorState();
}

class _BusquedaProveedorState extends State<BusquedaProveedor> {
  TextEditingController _controller = TextEditingController();

  dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productosBloc = ProviderBloc.busPro(context);
    productosBloc.obtenerProveedorPorQueryDelivery('');

    final provider = Provider.of<EstadoListener>(context, listen: false);

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
                            hintText: "Buscar proveedor",
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                          ),
                          onChanged: (value) {
                            provider.changeDatos();
                            productosBloc.obtenerProveedorPorQueryDelivery(value);
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
              Expanded(
                child: (data == EstadoBusqueda.datos)
                    ? StreamBuilder(
                        stream: productosBloc.busquedaProveedoresStream,
                        builder: (BuildContext context, AsyncSnapshot<List<ProveedorModel>> snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data!.length > 0) {
                              return ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, i) => _itemPedido(
                                  context,
                                  snapshot.data![i],
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
                                      'assets/svg/truck.svg',
                                    ),
                                  ),
                                  Text('No existen proveedores'),
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
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: ScreenUtil().setSp(200),
                                width: ScreenUtil().setSp(200),
                                child: SvgPicture.asset(
                                  'assets/svg/truck.svg',
                                ),
                              ),
                              Text('Buscar proveedor'),
                            ],
                          )
                        : (data == EstadoBusqueda.vacio)
                            ? Container()
                            : Container(),
              )
            ],
          );
        },
      ),
    );
  }

  Widget _itemPedido(BuildContext context, ProveedorModel productosData) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: ScreenUtil().setHeight(10),
          horizontal: ScreenUtil().setWidth(18),
        ),
        padding: EdgeInsets.only(
          right: ScreenUtil().setWidth(18),
        ),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(13),
        ),
        child: Text(
          '${productosData.nombre}',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w400,
            fontSize: ScreenUtil().setSp(16),
          ),
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) {
              return DetailProveedor(
                proveedor: productosData,
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
        /*  Navigator.push(
            context,
            PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 400),
              pageBuilder: (context, animation, secondaryAnimation) {
                return DetalleProductitoss2(
                  productosData: productosData,
                  mostrarback: true,
                );
              },
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
            )); */
        //Navigator.pushNamed(context, 'detalleP', arguments: productosData);
      },
    );
  }
}

class EstadoListener with ChangeNotifier {
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

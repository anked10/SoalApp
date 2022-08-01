import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soal_app/core/util/utils.dart';
import 'package:soal_app/src/bloc/provider_bloc.dart';
import 'package:soal_app/src/models/orden_compra_model.dart';
import 'package:soal_app/src/pages/Actions/eliminar.dart';
import 'package:soal_app/src/pages/OrdenCompra/buscar_oc_pendientes.dart';
import 'package:soal_app/src/pages/OrdenCompra/detalle_oc.dart';
import 'package:soal_app/src/widgets/show_loading.dart';

class OCPendientes extends StatelessWidget {
  const OCPendientes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ocBloc = ProviderBloc.op(context);
    ocBloc.ocPendientes();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Orden de Compras Pendientes',
          style: TextStyle(
            fontSize: ScreenUtil().setSp(18),
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              ocBloc.ocPendientes();
            },
            icon: Icon(
              Icons.refresh,
              color: Colors.deepPurple,
            ),
          ),
          IconButton(
            onPressed: () {
              ocBloc.searchOCPendientes('');
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return const BuscarOCPendientes();
                  },
                ),
              );
            },
            icon: Icon(
              Icons.search,
              color: Colors.deepPurple,
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ocBloc.ocPendientes();
          return null;
        },
        child: StreamBuilder<bool>(
            stream: ocBloc.cargandoStream,
            builder: (_, c) {
              if (c.hasData && !c.data!) {
                return StreamBuilder<List<OrdenCompraNewModel>>(
                    stream: ocBloc.ocPendientesStream,
                    builder: (_, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data!.isNotEmpty) {
                          return ListView.builder(
                            itemCount: snapshot.data!.length + 1,
                            itemBuilder: (_, index) {
                              if (index == 0) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: ScreenUtil().setWidth(16),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        'Se encontraron ${snapshot.data!.length} resultado(s)',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: ScreenUtil().setSp(10),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }

                              index = index - 1;
                              return _item(context, snapshot.data![index], index + 1);
                            },
                          );
                        } else {
                          return const Center(
                            child: Text('No existen órdenes compra pendientes'),
                          );
                        }
                      } else {
                        return Container();
                      }
                    });
              } else {
                return ShowLoadding(
                  active: true,
                  color: Colors.transparent,
                );
              }
            }),
      ),
    );
  }

  Widget _item(BuildContext context, OrdenCompraNewModel orden, int i) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      confirmDismiss: (value) async {
        //Eliminar OC
        Navigator.push(
          context,
          PageRouteBuilder(
            opaque: false,
            pageBuilder: (context, animation, secondaryAnimation) {
              return Eliminar(
                id: orden.idOC ?? '',
                title: 'esta Orden de Compra',
                valueEliminar: '1',
                onChanged: (v) {
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

        return false;
      },
      background: Container(
        padding: EdgeInsets.only(right: ScreenUtil().setWidth(16)),
        color: Colors.redAccent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.cancel,
                  color: Colors.white,
                ),
                Text(
                  'Eliminar',
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
          ],
        ),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) {
                return DetalleOC(
                  idOC: orden.idOC.toString(),
                );
              },
            ),
          );
        },
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
                                orden.nombreProyectoOC ?? '',
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
                                          'Proveedor',
                                          style: TextStyle(
                                            fontSize: ScreenUtil().setSp(11),
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Text(
                                          orden.nombreProveedor ?? '',
                                          style: TextStyle(
                                            fontSize: ScreenUtil().setSp(11),
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          'RUC',
                                          style: TextStyle(
                                            fontSize: ScreenUtil().setSp(11),
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Text(
                                          orden.rucProveedor ?? '',
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
                                    height: ScreenUtil().setHeight(35),
                                    width: ScreenUtil().setWidth(0.5),
                                    color: Colors.grey.withOpacity(0.4),
                                  ),
                                  Container(
                                    width: ScreenUtil().setWidth(120),
                                    child: Column(
                                      children: [
                                        Text(
                                          'Empresa',
                                          style: TextStyle(
                                            fontSize: ScreenUtil().setSp(11),
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Text(
                                          orden.nombreEmpresa ?? '',
                                          style: TextStyle(
                                            fontSize: ScreenUtil().setSp(11),
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          'Sede',
                                          style: TextStyle(
                                            fontSize: ScreenUtil().setSp(11),
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Text(
                                          orden.nombreSede ?? '',
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
                                    "${orden.nameCreateOC?.split(' ').first} ${orden.surnameCreateOC ?? ''}",
                                    style: TextStyle(
                                      fontSize: ScreenUtil().setSp(10),
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    obtenerFecha(orden.dateTimeCreateOC ?? ''),
                                    style: TextStyle(
                                      fontSize: ScreenUtil().setSp(10),
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    orden.totalOC ?? '',
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
        ),
      ),
    );
  }
}

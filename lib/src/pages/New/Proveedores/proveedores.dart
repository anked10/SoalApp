import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soal_app/src/bloc/provider_bloc.dart';
import 'package:soal_app/src/models/proveedores_model.dart';
import 'package:soal_app/src/pages/Home/menu_widget.dart';
import 'package:soal_app/src/widgets/show_loading.dart';

class Proveedores extends StatelessWidget {
  const Proveedores({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final proveedoresBloc = ProviderBloc.provee(context);
    proveedoresBloc.obtenerProveedores();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const MenuWidget(),
        title: Text(
          'Proveedores',
          style: TextStyle(
            fontSize: ScreenUtil().setSp(18),
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              proveedoresBloc.obtenerProveedores();
            },
            icon: Icon(
              Icons.refresh,
              color: Colors.indigo,
            ),
          ),
          IconButton(
            onPressed: () {
              //otBloc.searchOTPendientes('');
              // Navigator.push(
              //   context,
              //   PageRouteBuilder(
              //     pageBuilder: (context, animation, secondaryAnimation) {
              //       return const BuscarOTPendientes();
              //     },
              //   ),
              // );
            },
            icon: Icon(
              Icons.search,
              color: Colors.indigo,
            ),
          ),
        ],
        elevation: 0,
      ),
      body: StreamBuilder<bool>(
        stream: proveedoresBloc.cargandoStream,
        builder: (_, c) {
          if (c.hasData && !c.data!) {
            return StreamBuilder<List<ProveedorModel>>(
              stream: proveedoresBloc.proveedoresStream,
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
                        return _proveedor(context, snapshot.data![index], index + 1);
                      },
                    );
                  } else {
                    return Center(
                      child: Text('No existen proveedores registrados'),
                    );
                  }
                } else {
                  return Container();
                }
              },
            );
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

  Widget _proveedor(BuildContext context, ProveedorModel p, int i) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(16), vertical: ScreenUtil().setHeight(6)),
      child: Row(
        children: [
          SizedBox(
            width: ScreenUtil().setWidth(20),
            child: Text(
              i.toString(),
              style: TextStyle(fontSize: ScreenUtil().setSp(10)),
            ),
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
                            p.nombre ?? '',
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(12),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: ScreenUtil().setHeight(6),
                          ),
                          Row(
                            children: [
                              Text(
                                'RUC:',
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
                                p.ruc ?? '',
                                style: TextStyle(
                                  fontSize: ScreenUtil().setSp(10),
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: ScreenUtil().setHeight(4),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Dirección:',
                                style: TextStyle(
                                  fontSize: ScreenUtil().setSp(10),
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(
                                width: ScreenUtil().setWidth(4),
                              ),
                              Expanded(
                                child: Text(
                                  p.direccion ?? '',
                                  style: TextStyle(
                                    fontSize: ScreenUtil().setSp(10),
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: ScreenUtil().setHeight(4),
                          ),
                          Row(
                            children: [
                              Text(
                                'Teléfono:',
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
                                p.telefono ?? '',
                                style: TextStyle(
                                  fontSize: ScreenUtil().setSp(10),
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: ScreenUtil().setWidth(120),
                                child: Column(
                                  children: [
                                    Text(
                                      'Clasificación',
                                      style: TextStyle(
                                        fontSize: ScreenUtil().setSp(11),
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(height: ScreenUtil().setHeight(4)),
                                    Text(
                                      p.clase2 ?? '',
                                      textAlign: TextAlign.center,
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
                                height: ScreenUtil().setHeight(40),
                                width: ScreenUtil().setWidth(0.5),
                                color: Colors.grey.withOpacity(0.4),
                              ),
                              Container(
                                width: ScreenUtil().setWidth(120),
                                child: Column(
                                  children: [
                                    Text(
                                      'Banco',
                                      style: TextStyle(
                                        fontSize: ScreenUtil().setSp(11),
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(height: ScreenUtil().setHeight(4)),
                                    (p.banco1!.split('/../').first != '' && p.banco1!.split('/../').first != 'Seleccione')
                                        ? Text(
                                            datoBanco(p.banco1 ?? ''),
                                            style: TextStyle(
                                              fontSize: ScreenUtil().setSp(11),
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black,
                                            ),
                                          )
                                        : Container(),
                                    (p.banco2!.split('/../').first != '' && p.banco2!.split('/../').first != 'Seleccione') ? Divider() : Container(),
                                    (p.banco2!.split('/../').first != '' && p.banco2!.split('/../').first != 'Seleccione')
                                        ? Text(
                                            datoBanco(p.banco2 ?? ''),
                                            style: TextStyle(
                                              fontSize: ScreenUtil().setSp(11),
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black,
                                            ),
                                          )
                                        : Container(),
                                    (p.banco3!.split('/../').first != '' && p.banco3!.split('/../').first != 'Seleccione') ? Divider() : Container(),
                                    (p.banco3!.split('/../').first != '' && p.banco3!.split('/../').first != 'Seleccione')
                                        ? Text(
                                            datoBanco(p.banco3 ?? ''),
                                            style: TextStyle(
                                              fontSize: ScreenUtil().setSp(11),
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black,
                                            ),
                                          )
                                        : Container(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Divider(),
                          Text(
                            'Datos de Contacto',
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(10),
                              fontWeight: FontWeight.w400,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(height: ScreenUtil().setHeight(4)),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(width: ScreenUtil().setWidth(4)),
                              Expanded(
                                child: Text(
                                  p.contacto ?? '',
                                  style: TextStyle(
                                    fontSize: ScreenUtil().setSp(10),
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: ScreenUtil().setHeight(4)),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                ' Email:',
                                style: TextStyle(
                                  fontSize: ScreenUtil().setSp(10),
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(width: ScreenUtil().setWidth(4)),
                              Expanded(
                                child: Text(
                                  p.email ?? '',
                                  style: TextStyle(
                                    fontSize: ScreenUtil().setSp(10),
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
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
                    height: ScreenUtil().setHeight(100),
                    decoration: BoxDecoration(
                      color: Colors.indigo,
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
    );
  }

  datoBanco(String dato) {
    var banco = dato.split('/../');
    String result = '';

    for (var i = 0; i < banco.length; i++) {
      if (i == 0 && banco[i] != '') {
        result += '${banco[i]}';
      } else if (banco[i] != '') {
        result += ' / ${banco[i]}';
      }
    }

    return result;
  }
}

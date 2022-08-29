import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:soal_app/core/util/utils.dart';
import 'package:soal_app/src/bloc/provider_bloc.dart';
import 'package:soal_app/src/models/orden_compra_model.dart';
import 'package:soal_app/src/pages/Home/menu_widget.dart';
import 'package:soal_app/src/widgets/show_loading.dart';

class OrdenCompra extends StatefulWidget {
  const OrdenCompra({Key? key}) : super(key: key);

  @override
  State<OrdenCompra> createState() => _OrdenCompraState();
}

class _OrdenCompraState extends State<OrdenCompra> {
  int init = 0;
  @override
  Widget build(BuildContext context) {
    final ordenCompraBloc = ProviderBloc.op(context);
    if (init == 0) {
      ordenCompraBloc.getOrdenCompraGeneradas();
      init++;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const MenuWidget(),
        title: Text(
          'Orden de Compra Generadas',
          style: TextStyle(
            fontSize: ScreenUtil().setSp(18),
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              ordenCompraBloc.getOrdenCompraGeneradas();
            },
            icon: Icon(
              Icons.refresh,
              color: Colors.black,
            ),
          ),
          // IconButton(
          //   onPressed: () {

          //   },
          //   icon: AnimatedBuilder(
          //       animation: _controller,
          //       builder: (context, snapshot) {
          //         return Icon(
          //           Icons.search,
          //           color: _controller.isActiveSearch ? Colors.indigo : Colors.black,
          //         );
          //       }),
          // ),
        ],
        elevation: 0,
      ),
      body: StreamBuilder<bool>(
        stream: ordenCompraBloc.cargando2Stream,
        builder: (_, c) {
          if (c.hasData) {
            if (c.data!) return ShowLoadding(active: true, color: Colors.transparent);
            return StreamBuilder<List<OrdenCompraNewModel>>(
              stream: ordenCompraBloc.ocGeneradasStream,
              builder: (_, snapshot) {
                if (!snapshot.hasData) return Container();
                if (snapshot.data!.isEmpty) return Center(child: Text('No existen ordenes de compras registradas'));

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
                    return _item(context, snapshot.data![index]);
                  },
                );
              },
            );
          } else {
            return ShowLoadding(active: true, color: Colors.transparent);
          }
        },
      ),
    );
  }

  Widget _item(BuildContext context, OrdenCompraNewModel orden) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(16), vertical: ScreenUtil().setHeight(6)),
      child: (orden.activoOC == '0')
          ? FocusedMenuHolder(
              blurBackgroundColor: Colors.black.withOpacity(0.2),
              blurSize: 0,
              animateMenuItems: true,
              onPressed: () {},
              openWithTap: true,
              menuWidth: ScreenUtil().setWidth(210),
              menuItems: [
                itemOption(
                  title: "Cotización",
                  colorText: Colors.black,
                  icon: (orden.cotizacion != "") ? Icons.insert_drive_file_sharp : Icons.file_upload_sharp,
                  colorIcon: Colors.blue,
                  onPressed: () {},
                ),
                itemOption(
                  title: "Estado",
                  colorText: Colors.black,
                  icon: Icons.remove_red_eye,
                  colorIcon: Colors.grey,
                  onPressed: () {},
                ),
                itemOption(
                  title: "Detalle",
                  colorText: Colors.black,
                  icon: Icons.remove_red_eye,
                  colorIcon: Colors.grey,
                  onPressed: () {},
                ),
                itemOption(
                  title: "Rendición",
                  colorText: Colors.black,
                  icon: Icons.remove_red_eye,
                  colorIcon: Colors.grey,
                  onPressed: () {},
                ),
              ],
              child: contenidoItem(orden),
            )
          : InkWell(
              onTap: () {},
              child: contenidoItem(orden),
            ),
    );
  }

  Widget contenidoItem(OrdenCompraNewModel orden) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: (orden.activoOC == '0') ? Colors.white : Colors.redAccent.withOpacity(0.6),
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
                  Row(
                    children: [
                      Text(
                        'Código OC:',
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(10),
                          fontWeight: FontWeight.w400,
                          color: (orden.activoOC == '0') ? Colors.grey : Colors.black,
                        ),
                      ),
                      SizedBox(
                        width: ScreenUtil().setWidth(4),
                      ),
                      Text(
                        orden.numberOC ?? '',
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(10),
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: ScreenUtil().setHeight(4)),
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
                                  color: (orden.activoOC == '0') ? Colors.grey : Colors.black),
                            ),
                            Text(
                              orden.nombreProveedor ?? '',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(11),
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: ScreenUtil().setHeight(4)),
                            Text(
                              'RUC',
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(11),
                                fontWeight: FontWeight.w400,
                                color: (orden.activoOC == '0') ? Colors.grey : Colors.black,
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
                        color: (orden.activoOC == '0') ? Colors.grey.withOpacity(0.4) : Colors.black.withOpacity(0.4),
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
                                color: (orden.activoOC == '0') ? Colors.grey : Colors.black,
                              ),
                            ),
                            Text(
                              orden.nombreEmpresa ?? '',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(11),
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: ScreenUtil().setHeight(4)),
                            Text(
                              'Sede',
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(11),
                                fontWeight: FontWeight.w400,
                                color: (orden.activoOC == '0') ? Colors.grey : Colors.black,
                              ),
                            ),
                            Text(
                              orden.nombreSede ?? '',
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
                    ],
                  ),
                  Divider(),
                  Row(
                    children: [
                      Text(
                        'Solicitado por:',
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(10),
                          fontWeight: FontWeight.w400,
                          color: (orden.activoOC == '0') ? Colors.grey : Colors.black,
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
                            color: (orden.activoOC == '0') ? Colors.grey : Colors.black),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            orden.idMoneda ?? '',
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(12),
                              fontWeight: FontWeight.w400,
                              color: (orden.activoOC == '0') ? Colors.blueGrey : Colors.black,
                            ),
                          ),
                          SizedBox(width: ScreenUtil().setWidth(4)),
                          Text(
                            orden.totalOC ?? '',
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(15),
                              fontWeight: FontWeight.w600,
                              color: (orden.activoOC == '0') ? Colors.green : Colors.black,
                            ),
                          ),
                        ],
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
              color: Colors.indigo,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                bottomLeft: Radius.circular(5),
              ),
            ),
          ),
        ],
      ),
    );
  }

  FocusedMenuItem itemOption({
    required String title,
    required Color colorText,
    required IconData icon,
    required Color colorIcon,
    required Function() onPressed,
  }) {
    return FocusedMenuItem(
      title: Expanded(
        child: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: ScreenUtil().setSp(18),
            color: colorText,
          ),
        ),
      ),
      trailingIcon: Icon(
        icon,
        color: colorIcon,
        size: ScreenUtil().setHeight(20),
      ),
      onPressed: onPressed,
    );
  }
}

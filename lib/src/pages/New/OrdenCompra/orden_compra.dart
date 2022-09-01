import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:path/path.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:soal_app/core/util/constants.dart';
import 'package:soal_app/core/util/utils.dart';
import 'package:soal_app/src/api/orden_compra_api.dart';
import 'package:soal_app/src/api/pdf_api.dart';
import 'package:soal_app/src/bloc/provider_bloc.dart';
import 'package:soal_app/src/models/orden_compra_model.dart';
import 'package:soal_app/src/pages/Home/menu_widget.dart';
import 'package:soal_app/src/pages/New/OrdenCompra/detalle_oc.dart';
import 'package:soal_app/src/pages/New/OrdenCompra/gestion_pago.dart';
import 'package:soal_app/src/widgets/responsive.dart';
import 'package:soal_app/src/widgets/show_loading.dart';
import 'package:soal_app/src/widgets/text_field.dart';

class OrdenCompra extends StatefulWidget {
  const OrdenCompra({Key? key}) : super(key: key);

  @override
  State<OrdenCompra> createState() => _OrdenCompraState();
}

class _OrdenCompraState extends State<OrdenCompra> {
  int init = 0;

  final provider = ControllerFileOC();
  @override
  Widget build(BuildContext context) {
    final ordenCompraBloc = ProviderBloc.op(context);
    if (init == 0) {
      ordenCompraBloc.getOrdenCompraGeneradas();
      init++;
    }

    final responsive = Responsive.of(context);

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
            return Stack(
              children: [
                StreamBuilder<List<OrdenCompraNewModel>>(
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
                ),
                AnimatedBuilder(
                  animation: provider,
                  builder: (context, s) {
                    return Positioned(
                      bottom: 20,
                      left: 0,
                      right: 0,
                      child: (!provider.load)
                          ? Container()
                          : Padding(
                              padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(10)),
                              child: Container(
                                height: ScreenUtil().setHeight(40),
                                child: Column(
                                  children: [
                                    Text('Cargando'),
                                    LinearPercentIndicator(
                                      width: responsive.wp(90),
                                      lineHeight: 14.0,
                                      percent: 50 / 100,
                                      backgroundColor: Colors.white,
                                      progressColor: Colors.blue,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                    );
                  },
                ),
              ],
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
                  onPressed: () async {
                    if (orden.cotizacion != "") {
                      provider.changeLoad(true);
                      final _apiPDF = PdfApi();
                      await _apiPDF.openFile(url: '$API_BASE_URL/${orden.cotizacion}');

                      provider.changeLoad(false);
                    } else {
                      subir(context, orden.idOC!);
                    }
                  },
                ),
                itemOption(
                  title: "Estado",
                  colorText: Colors.black,
                  icon: (double.parse(orden.montoEstado!) <= 0) ? Icons.check_circle : Icons.error,
                  colorIcon: (double.parse(orden.montoEstado!) <= 0)
                      ? Colors.green
                      : (orden.montoEstado == orden.totalOC)
                          ? Colors.redAccent
                          : Colors.orangeAccent,
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return GestionPago(
                            orden: orden,
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
                itemOption(
                  title: "Detalle",
                  colorText: Colors.black,
                  icon: Icons.remove_red_eye,
                  colorIcon: Colors.blueGrey,
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return DetalleOC(
                            idOC: orden.idOC!,
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
                itemOption(
                  title: "Rendición",
                  colorText: Colors.black,
                  icon: (double.parse(orden.montoRendicion!) <= 0) ? Icons.check_circle_outline : Icons.error_outline,
                  colorIcon: (double.parse(orden.montoRendicion!) <= 0)
                      ? Colors.green
                      : (orden.montoRendicion == orden.totalOC)
                          ? Colors.redAccent
                          : Colors.orangeAccent,
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

  void subir(BuildContext context, String idOC) {
    final _controller = ControllerFileOC();
    final _archivoController = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Stack(
          children: [
            GestureDetector(
              child: Container(
                color: const Color.fromRGBO(0, 0, 0, 0.001),
                child: GestureDetector(
                  onTap: () {},
                  child: DraggableScrollableSheet(
                    initialChildSize: 0.8,
                    minChildSize: 0.3,
                    maxChildSize: 0.9,
                    builder: (_, controller) {
                      return Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25.0),
                            topRight: Radius.circular(25.0),
                          ),
                        ),
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: ScreenUtil().setWidth(24),
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: ScreenUtil().setHeight(16),
                                ),
                                Center(
                                  child: Container(
                                    width: ScreenUtil().setWidth(100),
                                    height: ScreenUtil().setHeight(5),
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: ScreenUtil().setHeight(20),
                                ),
                                Text(
                                  'Agregar Cotización',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: ScreenUtil().setSp(18),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(
                                  height: ScreenUtil().setHeight(20),
                                ),
                                TextFieldSelect(
                                  label: 'Seleccionar Archivo',
                                  hingText: '',
                                  controller: _archivoController,
                                  widget: Icon(
                                    Icons.file_copy,
                                    color: Colors.indigo,
                                  ),
                                  icon: true,
                                  readOnly: true,
                                  ontap: () async {
                                    FocusScope.of(context).unfocus();
                                    final path = await PdfApi().seleccionarDoc();

                                    _archivoController.text = path?.path != null ? basename(path!.path) : 'Seleccionar Archivo';
                                    _controller.changeFile(path);
                                  },
                                ),
                                SizedBox(
                                  height: ScreenUtil().setHeight(20),
                                ),
                                ElevatedButton.icon(
                                  onPressed: () async {
                                    if (_archivoController.value.text.isEmpty && _archivoController.value.text == 'Seleccionar Archivo')
                                      return showToast2('Seleccione un Archivo', Colors.redAccent);

                                    _controller.changeCargando(true);
                                    final _api = OrdenCompraApi();
                                    final res = await _api.uploadCotizacionOC(
                                      _controller.file!,
                                      idOC,
                                    );
                                    if (res.code == 200) {
                                      showToast2(res.message, Colors.green);
                                      final ordenCompraBloc = ProviderBloc.op(context);
                                      ordenCompraBloc.getOrdenCompraGeneradas();
                                      _archivoController.clear();
                                      _controller.file = null;
                                      Navigator.pop(context);
                                    } else {
                                      showToast2(res.message, Colors.redAccent);
                                    }
                                    _controller.changeCargando(false);
                                  },
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(18.0),
                                      ),
                                    ),
                                    backgroundColor: MaterialStateProperty.all(Colors.indigo),
                                    padding: MaterialStateProperty.all<EdgeInsets>(
                                      EdgeInsets.symmetric(
                                        horizontal: ScreenUtil().setWidth(15),
                                        vertical: ScreenUtil().setHeight(4),
                                      ),
                                    ),
                                  ),
                                  icon: Icon(
                                    Icons.upload_file_outlined,
                                    size: ScreenUtil().setHeight(25),
                                  ),
                                  label: Text(
                                    'Subir',
                                    style: TextStyle(fontSize: ScreenUtil().setSp(20), fontWeight: FontWeight.w500),
                                  ),
                                ),
                                SizedBox(height: ScreenUtil().setHeight(6)),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    'Cerrar',
                                    style: TextStyle(color: Colors.red, fontSize: ScreenUtil().setSp(18)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            AnimatedBuilder(
                animation: _controller,
                builder: (context, snapshot) {
                  return ShowLoadding(
                    active: _controller.cargando,
                    color: Colors.black.withOpacity(0.4),
                  );
                }),
          ],
        );
      },
    );
  }
}

class ControllerFileOC extends ChangeNotifier {
  File? file;
  bool cargando = false;

  bool load = false;

  void changeLoad(bool l) {
    load = l;
    notifyListeners();
  }

  void changeCargando(bool c) {
    cargando = c;
    notifyListeners();
  }

  void changeFile(File? f) {
    file = f;
    notifyListeners();
  }
}

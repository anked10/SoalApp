import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path/path.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:soal_app/core/util/constants.dart';
import 'package:soal_app/core/util/utils.dart';
import 'package:soal_app/src/api/gestion_pagos_api.dart';
import 'package:soal_app/src/api/pdf_api.dart';
import 'package:soal_app/src/bloc/provider_bloc.dart';
import 'package:soal_app/src/models/orden_compra_model.dart';
import 'package:soal_app/src/models/pagos_model.dart';
import 'package:soal_app/src/widgets/responsive.dart';
import 'package:soal_app/src/widgets/show_loading.dart';
import 'package:soal_app/src/widgets/text_field.dart';
import 'package:soal_app/src/widgets/widgets.dart';

class GestionPago extends StatefulWidget {
  const GestionPago({Key? key, required this.orden}) : super(key: key);
  final OrdenCompraNewModel orden;

  @override
  State<GestionPago> createState() => _GestionPagoState();
}

class _GestionPagoState extends State<GestionPago> {
  final provider = ControllerFileGP();
  final _entidadFinancieraComprobanteController = TextEditingController();
  final _monedaComprobanteController = TextEditingController();
  final _montoRestanteOCController = TextEditingController();
  final _importePagoController = TextEditingController();
  final _saldoController = TextEditingController();
  final _fechaComprobanteController = TextEditingController();
  final _nroComprobanteController = TextEditingController();
  final _referenciaController = TextEditingController();
  final _archivoController = TextEditingController();

  @override
  void initState() {
    _montoRestanteOCController.text = widget.orden.montoEstado ?? '';
    _saldoController.text = widget.orden.montoEstado ?? '';
    super.initState();
  }

  List<String> entidadFinancieraList = [
    'BANBIF',
    'BANCO DE COMERCIO',
    'BANCO DE LA NACION',
    'BANCO FALABELLA',
    'BANCO PICHINCHA',
    'BANCO GNB',
    'BANCO CONTINENTAL',
    'BANCO DE CREDITO',
    'CAJA AREQUIPA',
    'CAJA CUSCO',
    'CAJA PIURA',
    'CAJA SULLANA',
    'CAJA TRUJILLO',
    'CITIBANK',
    'CREDISCOTIA',
    'INTERBANK',
    'MIBANCO',
    'SCOTIABANK',
    'EFECTIVO',
  ];

  List<String> monedas = ['SOLES', 'DOLARES'];
  int cargaInicial = 0;

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);

    final ordenCompraBloc = ProviderBloc.op(context);
    final pagosBloc = ProviderBloc.gestionPagos(context);

    if (cargaInicial == 0) {
      ordenCompraBloc.getOCById(widget.orden.idOC!);
      pagosBloc.getDocumentosOC(widget.orden.idOC!);
      cargaInicial++;
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Gestión de Pagos',
          style: TextStyle(
            fontSize: ScreenUtil().setSp(18),
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: StreamBuilder<bool>(
        stream: ordenCompraBloc.cargando3Stream,
        builder: (_, car) {
          if (!car.hasData) return ShowLoadding(active: true, color: Colors.transparent);
          if (car.hasData && car.data!) return ShowLoadding(active: true, color: Colors.transparent);
          return StreamBuilder<List<OrdenCompraNewModel>>(
            stream: ordenCompraBloc.ocERStream,
            builder: (_, snapshots) {
              if (!snapshots.hasData) return Container();
              if (snapshots.data!.isEmpty) return Text('No existe información disponible');
              return Stack(
                children: [
                  SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(16), vertical: ScreenUtil().setHeight(10)),
                      child: Column(
                        children: [
                          cards(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Orden de Compra ${widget.orden.numberOC ?? ''}",
                                  style: TextStyle(
                                    fontSize: ScreenUtil().setSp(14),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: ScreenUtil().setHeight(6)),
                                rows(
                                    titulo: 'Fecha',
                                    data: obtenerFecha(widget.orden.dateTimeAprobacionOC ?? ''),
                                    st: 11,
                                    sd: 12,
                                    crossAxisAlignment: CrossAxisAlignment.start),
                                SizedBox(height: ScreenUtil().setHeight(4)),
                                rows(
                                    titulo: 'Solicitado por:',
                                    data: widget.orden.nameCreateOC ?? '',
                                    st: 11,
                                    sd: 12,
                                    crossAxisAlignment: CrossAxisAlignment.start),
                                SizedBox(
                                  height: ScreenUtil().setHeight(6),
                                ),
                              ],
                            ),
                            fondo: Colors.white,
                            color: Colors.blue,
                            height: 40,
                            mtop: 15,
                          ),
                          SizedBox(height: ScreenUtil().setHeight(20)),
                          (double.parse(snapshots.data![0].montoEstado!) <= 0) ? Container() : registerPay(context),
                          SizedBox(height: ScreenUtil().setHeight(20)),
                          StreamBuilder<bool>(
                            stream: pagosBloc.cargandoStream,
                            builder: (_, c) {
                              if (!c.hasData)
                                return SizedBox(height: ScreenUtil().setHeight(100), child: ShowLoadding(active: true, color: Colors.transparent));
                              if (c.hasData && c.data!)
                                return SizedBox(height: ScreenUtil().setHeight(100), child: ShowLoadding(active: true, color: Colors.transparent));
                              return StreamBuilder<List<PagosModel>>(
                                stream: pagosBloc.docsPagosOCStream,
                                builder: (_, snapshot) {
                                  if (!snapshot.hasData) return Container();
                                  if (snapshot.data!.isEmpty) return Text('No existen documentos adjuntos');
                                  return ExpansionTile(
                                    initiallyExpanded: true,
                                    maintainState: true,
                                    title: Text(
                                      'Documentos Adjuntos',
                                      style: TextStyle(
                                        fontSize: ScreenUtil().setSp(16),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    children: snapshot.data!.asMap().entries.map((item) {
                                      int idx = item.key;
                                      return docsItem(item.value, idx + 1);
                                    }).toList(),
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
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
                  AnimatedBuilder(
                    animation: provider,
                    builder: (context, s) {
                      return ShowLoadding(active: provider.cargando, color: Colors.black.withOpacity(0.4));
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Widget registerPay(BuildContext context) {
    return ExpansionTile(
      initiallyExpanded: false,
      maintainState: true,
      backgroundColor: Colors.transparent,
      title: Text(
        'Registrar Pago',
        style: TextStyle(
          fontSize: ScreenUtil().setSp(16),
          fontWeight: FontWeight.w500,
        ),
      ),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: ScreenUtil().setHeight(15)),
            TextFieldSelect(
              label: 'Entidad Financiera',
              hingText: 'Seleccionar',
              controller: _entidadFinancieraComprobanteController,
              widget: Icon(
                Icons.keyboard_arrow_down,
                color: Colors.indigo,
              ),
              icon: true,
              readOnly: true,
              ontap: () {
                FocusScope.of(context).unfocus();
                _selectEntityBanck(context);
              },
            ),
            SizedBox(height: ScreenUtil().setHeight(15)),
            TextFieldSelect(
              label: 'Moneda',
              hingText: 'Seleccionar',
              controller: _monedaComprobanteController,
              widget: Icon(
                Icons.keyboard_arrow_down,
                color: Colors.indigo,
              ),
              icon: true,
              readOnly: true,
              ontap: () {
                FocusScope.of(context).unfocus();
                _selectMoney(context);
              },
            ),
            SizedBox(height: ScreenUtil().setHeight(15)),
            TextFieldSelect(
              label: 'Monto OC Restante',
              hingText: '',
              controller: _montoRestanteOCController,
              icon: false,
              readOnly: true,
              ontap: () {
                FocusScope.of(context).unfocus();
              },
            ),
            SizedBox(height: ScreenUtil().setHeight(15)),
            TextFieldSelect(
              label: 'Importe de Pago',
              hingText: '',
              controller: _importePagoController,
              widget: Icon(
                Icons.edit,
                color: Colors.indigo,
              ),
              icon: true,
              readOnly: false,
              keyboardType: TextInputType.number,
              onchange: (value) {
                if (value.isNotEmpty)
                  _saldoController.text = (double.parse(widget.orden.montoEstado!) - double.parse(value)).toStringAsFixed(2);
                else
                  _saldoController.text = widget.orden.montoEstado!;
              },
            ),
            SizedBox(height: ScreenUtil().setHeight(15)),
            TextFieldSelect(
              label: 'Saldo',
              hingText: '',
              controller: _saldoController,
              icon: false,
              readOnly: true,
              ontap: () {
                FocusScope.of(context).unfocus();
              },
            ),
            SizedBox(height: ScreenUtil().setHeight(15)),
            TextFieldSelect(
              label: 'Fecha de Comprobante RUC',
              hingText: '',
              controller: _fechaComprobanteController,
              widget: Icon(
                Icons.calendar_month_outlined,
                color: Colors.indigo,
              ),
              readOnly: true,
              icon: true,
              ontap: () {
                FocusScope.of(context).unfocus();
                selectdate(context, _fechaComprobanteController);
              },
            ),
            SizedBox(height: ScreenUtil().setHeight(15)),
            TextFieldSelect(
              label: 'Nro Comprobante',
              hingText: '',
              controller: _nroComprobanteController,
              widget: Icon(
                Icons.edit,
                color: Colors.indigo,
              ),
              icon: true,
              readOnly: false,
            ),
            SizedBox(height: ScreenUtil().setHeight(15)),
            TextFieldSelect(
              label: 'Referencia',
              hingText: '',
              controller: _referenciaController,
              widget: Icon(
                Icons.edit,
                color: Colors.indigo,
              ),
              icon: true,
              readOnly: false,
            ),
            SizedBox(
              height: ScreenUtil().setHeight(15),
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
                provider.changeFile(path);
              },
            ),
            SizedBox(height: ScreenUtil().setHeight(20)),
            ElevatedButton.icon(
              onPressed: () async {
                if (_entidadFinancieraComprobanteController.value.text.isEmpty)
                  return showToast2('Seleccione una Entidad Financiera', Colors.redAccent);
                if (_monedaComprobanteController.value.text.isEmpty) return showToast2('Seleccione un tipo de Moneda', Colors.redAccent);
                if (_importePagoController.value.text.isEmpty) return showToast2('Ingrese el Importe de Pago', Colors.redAccent);
                if (_fechaComprobanteController.value.text.isEmpty) return showToast2('Ingrese la Fecha del Comprobante RUC', Colors.redAccent);
                if (_nroComprobanteController.value.text.isEmpty) return showToast2('Ingrese el Número de Comprobante', Colors.redAccent);
                if (_referenciaController.value.text.isEmpty) return showToast2('Ingrese una Referencia de Pago', Colors.redAccent);
                if (_archivoController.value.text.isEmpty || _archivoController.value.text == 'Seleccionar Archivo')
                  return showToast2('Seleccione un Archivo', Colors.redAccent);

                provider.changeCargando(true);
                final _api = GestionPagosApi();
                final res = await _api.uploadPagoOC(
                  archivo: provider.file!,
                  idOC: widget.orden.idOC!,
                  bancoPago: _entidadFinancieraComprobanteController.value.text,
                  monedaPago: _monedaComprobanteController.value.text,
                  montoPago: _importePagoController.value.text,
                  fechaPago: _fechaComprobanteController.value.text,
                  referenciaPago: _referenciaController.value.text.trim(),
                );

                if (res.code != 200) return showToast2(res.message, Colors.redAccent);

                showToast2(res.message, Colors.green);
                final ordenCompraBloc = ProviderBloc.op(context);
                ordenCompraBloc.getOCById(widget.orden.idOC!);
                ordenCompraBloc.getOrdenCompraGeneradas();
                final pagosBloc = ProviderBloc.gestionPagos(context);
                pagosBloc.getDocumentosOC(widget.orden.idOC!);
                _entidadFinancieraComprobanteController.clear();
                _monedaComprobanteController.clear();
                _montoRestanteOCController.text = _saldoController.text;
                _importePagoController.clear();
                _fechaComprobanteController.clear();
                _nroComprobanteController.clear();
                _referenciaController.clear();
                _archivoController.clear();
                provider.file = null;

                provider.changeCargando(false);
              },
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                ),
                alignment: Alignment.center,
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
            SizedBox(height: ScreenUtil().setHeight(20)),
          ],
        ),
      ],
    );
  }

  Widget docsItem(PagosModel pago, int i) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          SizedBox(
            width: ScreenUtil().setWidth(20),
            child: Text(i.toString()),
          ),
          Expanded(
            child: cards(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        rows(titulo: 'Entidad Bancaria:', data: pago.bancoPago ?? '', st: 10, sd: 12, crossAxisAlignment: CrossAxisAlignment.start),
                        SizedBox(height: ScreenUtil().setHeight(4)),
                        rows(titulo: 'Referencia:', data: pago.referenciaPago ?? '', st: 10, sd: 12, crossAxisAlignment: CrossAxisAlignment.start),
                        SizedBox(height: ScreenUtil().setHeight(4)),
                        rows(titulo: pago.monedaPago ?? '', data: pago.montoPago ?? '', st: 12, sd: 12, crossAxisAlignment: CrossAxisAlignment.start),
                        Divider(),
                        rows(
                            titulo: 'Fecha  de Pago:',
                            data: obtenerFecha(pago.fechaAdjuntadaPago ?? ''),
                            st: 9,
                            sd: 10,
                            crossAxisAlignment: CrossAxisAlignment.start),
                        SizedBox(height: ScreenUtil().setHeight(4)),
                        rows(titulo: 'Atendido por:', data: pago.nameAtended ?? '', st: 9, sd: 10, crossAxisAlignment: CrossAxisAlignment.start),
                      ],
                    ),
                  ),
                  IconButton(
                      onPressed: () async {
                        provider.changeLoad(true);
                        final _apiPDF = PdfApi();
                        await _apiPDF.openFile(url: '$API_BASE_URL/${pago.voucherPago}');

                        provider.changeLoad(false);
                      },
                      icon: Icon(
                        Icons.remove_red_eye,
                        color: Colors.blueGrey,
                      )),
                ],
              ),
              fondo: Colors.white,
              color: Colors.purple,
              height: 45,
              mtop: 20,
            ),
          ),
        ],
      ),
    );
  }

  void _selectEntityBanck(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return GestureDetector(
          child: Container(
            color: const Color.fromRGBO(0, 0, 0, 0.001),
            child: GestureDetector(
              onTap: () {},
              child: DraggableScrollableSheet(
                initialChildSize: 0.5,
                minChildSize: 0.2,
                maxChildSize: 0.7,
                builder: (_, controller) {
                  return Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25.0),
                        topRight: Radius.circular(25.0),
                      ),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.remove,
                          color: Colors.grey[600],
                        ),
                        Text(
                          'Seleccionar Entidad Financiera',
                          style: TextStyle(
                            color: const Color(0xff5a5a5a),
                            fontWeight: FontWeight.w600,
                            fontSize: ScreenUtil().setSp(20),
                          ),
                        ),
                        const Divider(
                          thickness: 1,
                          color: Colors.black,
                        ),
                        Expanded(
                          child: ListView.builder(
                            controller: controller,
                            itemCount: entidadFinancieraList.length,
                            itemBuilder: (_, index) {
                              return InkWell(
                                onTap: () {
                                  _entidadFinancieraComprobanteController.text = entidadFinancieraList[index];
                                  Navigator.pop(context);
                                },
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Text(entidadFinancieraList[index]),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  void _selectMoney(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return GestureDetector(
          child: Container(
            color: const Color.fromRGBO(0, 0, 0, 0.001),
            child: GestureDetector(
              onTap: () {},
              child: DraggableScrollableSheet(
                initialChildSize: 0.5,
                minChildSize: 0.2,
                maxChildSize: 0.7,
                builder: (_, controller) {
                  return Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25.0),
                        topRight: Radius.circular(25.0),
                      ),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.remove,
                          color: Colors.grey[600],
                        ),
                        Text(
                          'Seleccionar Moneda',
                          style: TextStyle(
                            color: const Color(0xff5a5a5a),
                            fontWeight: FontWeight.w600,
                            fontSize: ScreenUtil().setSp(20),
                          ),
                        ),
                        const Divider(
                          thickness: 1,
                          color: Colors.black,
                        ),
                        Expanded(
                          child: ListView.builder(
                            controller: controller,
                            itemCount: monedas.length,
                            itemBuilder: (_, index) {
                              return InkWell(
                                onTap: () {
                                  _monedaComprobanteController.text = monedas[index];
                                  Navigator.pop(context);
                                },
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Text(monedas[index]),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

class ControllerFileGP extends ChangeNotifier {
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

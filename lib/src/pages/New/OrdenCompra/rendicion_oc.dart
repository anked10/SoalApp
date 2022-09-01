import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path/path.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:soal_app/core/util/constants.dart';
import 'package:soal_app/core/util/utils.dart';
import 'package:soal_app/src/api/consulta_ruc_api.dart';
import 'package:soal_app/src/api/orden_compra_api.dart';
import 'package:soal_app/src/api/pdf_api.dart';
import 'package:soal_app/src/bloc/provider_bloc.dart';
import 'package:soal_app/src/models/orden_compra_model.dart';
import 'package:soal_app/src/models/pagos_model.dart';
import 'package:soal_app/src/widgets/responsive.dart';
import 'package:soal_app/src/widgets/show_loading.dart';
import 'package:soal_app/src/widgets/text_field.dart';
import 'package:soal_app/src/widgets/widgets.dart';

class RendicionOC extends StatefulWidget {
  const RendicionOC({Key? key, required this.orden, required this.mes}) : super(key: key);
  final OrdenCompraNewModel orden;
  final String mes;

  @override
  State<RendicionOC> createState() => _RendicionOCState();
}

class _RendicionOCState extends State<RendicionOC> {
  final provider = ControllerFileGP();
  final _tipoComprobanteController = TextEditingController();
  final _monedaComprobanteController = TextEditingController();
  final _montoRestanteOCController = TextEditingController();
  final _importePagoController = TextEditingController();
  final _saldoController = TextEditingController();
  final _fechaComprobanteController = TextEditingController();
  final _rucController = TextEditingController();
  final _nroComprobanteController = TextEditingController();
  final _referenciaController = TextEditingController();
  final _archivoController = TextEditingController();

  @override
  void initState() {
    _montoRestanteOCController.text = widget.orden.montoRendicion ?? '';
    _saldoController.text = widget.orden.montoRendicion ?? '';
    super.initState();
  }

  List<String> tipoComprobanteList = [
    'Factura de Venta',
    'Boleta de Venta',
    'Nota de Crédito',
    'Nota de Débito',
    'Recibo por honorarios',
    'Devolución a la Empresa',
    'Acta de Comunidades',
    'Transferencia',
    'Cheque',
    'Efectivo',
    'Otros',
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
      pagosBloc.getDocumentosOC(widget.orden.idOC!, '2');
      cargaInicial++;
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Orden de Compra',
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
                            color: Colors.indigo,
                            height: 40,
                            mtop: 15,
                          ),
                          SizedBox(height: ScreenUtil().setHeight(20)),
                          (double.parse(snapshots.data![0].montoRendicion!) <= 0) ? Container() : registerDocPay(context),
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
                          SizedBox(height: ScreenUtil().setHeight(50)),
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

  Widget registerDocPay(BuildContext context) {
    return ExpansionTile(
      initiallyExpanded: false,
      maintainState: true,
      backgroundColor: Colors.transparent,
      title: Text(
        'Registrar Información de Pago',
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
              label: 'Tipo de Comprobante',
              hingText: 'Seleccionar',
              controller: _tipoComprobanteController,
              widget: Icon(
                Icons.keyboard_arrow_down,
                color: Colors.indigo,
              ),
              icon: true,
              readOnly: true,
              ontap: () {
                FocusScope.of(context).unfocus();
                _selectTypeDoc(context);
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
                  _saldoController.text = (double.parse(widget.orden.montoRendicion!) - double.parse(value)).toStringAsFixed(2);
                else
                  _saldoController.text = widget.orden.montoRendicion!;
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
              label: 'Fecha de Comprobante',
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
              label: 'RUC',
              hingText: '',
              controller: _rucController,
              keyboardType: TextInputType.number,
              widget: Icon(
                Icons.edit,
                color: Colors.indigo,
              ),
              icon: true,
              readOnly: false,
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
            AnimatedBuilder(
                animation: provider,
                builder: (_, b) {
                  return provider.isActivebuttonConsultaRuc
                      ? ElevatedButton.icon(
                          onPressed: () async {
                            if (_tipoComprobanteController.value.text.isEmpty)
                              return showToast2('Seleccione una Entidad Financiera', Colors.redAccent);
                            if (_monedaComprobanteController.value.text.isEmpty) return showToast2('Seleccione un tipo de Moneda', Colors.redAccent);
                            if (_importePagoController.value.text.isEmpty) return showToast2('Ingrese el Importe de Pago', Colors.redAccent);
                            if (_fechaComprobanteController.value.text.isEmpty)
                              return showToast2('Ingrese la Fecha del Comprobante RUC', Colors.redAccent);
                            if (_nroComprobanteController.value.text.isEmpty) return showToast2('Ingrese el Número de Comprobante', Colors.redAccent);
                            if (_referenciaController.value.text.isEmpty) return showToast2('Ingrese una Referencia de Pago', Colors.redAccent);
                            if (_archivoController.value.text.isEmpty || _archivoController.value.text == 'Seleccionar Archivo')
                              return showToast2('Seleccione un Archivo', Colors.redAccent);

                            provider.changeCargando(true);
                            final _api = OrdenCompraApi();
                            final res = await _api.uploadDocumentoPagoOC(
                              archivo: provider.file!,
                              idOC: widget.orden.idOC!,
                              tipoComprobante: _tipoComprobanteController.value.text,
                              rucPago: _rucController.value.text,
                              nroComprobante: _nroComprobanteController.value.text,
                              monedaPago: _monedaComprobanteController.value.text,
                              montoPago: _importePagoController.value.text,
                              fechaPago: _fechaComprobanteController.value.text,
                              referenciaPago: _referenciaController.value.text.trim(),
                            );

                            if (res.code != 200) return showToast2(res.message, Colors.redAccent);

                            showToast2(res.message, Colors.green);
                            final ordenCompraBloc = ProviderBloc.op(context);
                            ordenCompraBloc.getOCById(widget.orden.idOC!);
                            ordenCompraBloc.getOrdenCompraGeneradas(widget.mes);
                            final pagosBloc = ProviderBloc.gestionPagos(context);
                            pagosBloc.getDocumentosOC(widget.orden.idOC!, '2');
                            _tipoComprobanteController.clear();
                            _monedaComprobanteController.clear();
                            _rucController.clear();
                            _montoRestanteOCController.text = _saldoController.text;
                            _importePagoController.clear();
                            _fechaComprobanteController.clear();
                            _nroComprobanteController.clear();
                            _referenciaController.clear();
                            _archivoController.clear();
                            provider.file = null;
                            provider.changeButton(false);

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
                        )
                      : ElevatedButton.icon(
                          onPressed: () async {
                            if (_rucController.value.text.isEmpty) return showToast2('Ingrese un número de RUC', Colors.redAccent);
                            if (_rucController.value.text.length != 11)
                              return showToast2('El número de RUC debe contener 11 dígitos', Colors.redAccent);

                            final _api = ConsultaRucApi();
                            provider.changeCargando(true);
                            final res = await _api.searchRUC(_rucController.value.text);
                            provider.changeCargando(false);

                            if (res.code != 200) return showToast2(res.message, Colors.redAccent);

                            showToast2(res.message, Colors.green);
                            provider.changeButton(true);
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                            ),
                            alignment: Alignment.center,
                            backgroundColor: MaterialStateProperty.all(Colors.cyan),
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
                            'Validar RUC',
                            style: TextStyle(fontSize: ScreenUtil().setSp(20), fontWeight: FontWeight.w500),
                          ),
                        );
                }),
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
                        rows(
                            titulo: 'Tipo de Comprobante:',
                            data: pago.comprobanteTipo ?? '',
                            st: 10,
                            sd: 12,
                            crossAxisAlignment: CrossAxisAlignment.start),
                        SizedBox(height: ScreenUtil().setHeight(4)),
                        rows(titulo: 'RUC:', data: pago.rucPago ?? '', st: 10, sd: 12, crossAxisAlignment: CrossAxisAlignment.start),
                        SizedBox(height: ScreenUtil().setHeight(4)),
                        rows(
                            titulo: 'Nro Comprobante:',
                            data: pago.nroComprobantePago ?? '',
                            st: 10,
                            sd: 12,
                            crossAxisAlignment: CrossAxisAlignment.start),
                        SizedBox(height: ScreenUtil().setHeight(4)),
                        rows(titulo: 'Referencia:', data: pago.referenciaPago ?? '', st: 10, sd: 12, crossAxisAlignment: CrossAxisAlignment.start),
                        SizedBox(height: ScreenUtil().setHeight(4)),
                        rows(titulo: pago.monedaPago ?? '', data: pago.montoPago ?? '', st: 12, sd: 12, crossAxisAlignment: CrossAxisAlignment.start),
                        Divider(),
                        rows(titulo: 'Fecha:', data: obtenerFecha(pago.fechaPago ?? ''), st: 9, sd: 10, crossAxisAlignment: CrossAxisAlignment.start),
                        SizedBox(height: ScreenUtil().setHeight(4)),
                        rows(titulo: 'Adjuntado por:', data: pago.nameAtended ?? '', st: 9, sd: 10, crossAxisAlignment: CrossAxisAlignment.start),
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
              color: Colors.deepPurple,
              height: 45,
              mtop: 20,
            ),
          ),
        ],
      ),
    );
  }

  void _selectTypeDoc(BuildContext context) {
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
                          'Seleccionar Tipo',
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
                            itemCount: tipoComprobanteList.length,
                            itemBuilder: (_, index) {
                              return InkWell(
                                onTap: () {
                                  _tipoComprobanteController.text = tipoComprobanteList[index];
                                  Navigator.pop(context);
                                },
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Text(tipoComprobanteList[index]),
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
  bool isActivebuttonConsultaRuc = false;

  bool load = false;

  void changeLoad(bool l) {
    load = l;
    notifyListeners();
  }

  void changeButton(bool l) {
    isActivebuttonConsultaRuc = l;
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

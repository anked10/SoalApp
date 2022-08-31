import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:soal_app/core/util/constants.dart';
import 'package:soal_app/core/util/utils.dart';
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
  final _fechaComprobanteController = TextEditingController();
  final _nroComprobanteController = TextEditingController();
  final _referenciaController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    final pagosBloc = ProviderBloc.gestionPagos(context);
    pagosBloc.getDocumentosOC(widget.orden.idOC!);
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
      body: Stack(
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
                  cards(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Registrar Pago",
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(14),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Divider(),
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
                      ],
                    ),
                    fondo: Colors.white,
                    color: Colors.green,
                    height: 40,
                    mtop: 20,
                  ),
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
        ],
      ),
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

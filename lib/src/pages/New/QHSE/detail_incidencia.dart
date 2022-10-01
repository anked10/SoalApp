import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path/path.dart';
import 'package:soal_app/core/util/constants.dart';
import 'package:soal_app/core/util/utils.dart';
import 'package:soal_app/src/api/QHSE/qhse_api.dart';
import 'package:soal_app/src/api/pdf_api.dart';
import 'package:soal_app/src/bloc/provider_bloc.dart';
import 'package:soal_app/src/models/Rqhse/documentos_anexados_model.dart';
import 'package:soal_app/src/models/Rqhse/incidencia_model.dart';
import 'package:soal_app/src/pages/New/QHSE/check_box_state.dart';
import 'package:soal_app/src/widgets/show_loading.dart';
import 'package:soal_app/src/widgets/text_field.dart';
import 'package:soal_app/src/widgets/widgets.dart';

class DetailIncidencia extends StatefulWidget {
  const DetailIncidencia({Key? key, required this.incidencia}) : super(key: key);
  final IncidenciaModel incidencia;

  @override
  State<DetailIncidencia> createState() => _DetailIncidenciaState();
}

class _DetailIncidenciaState extends State<DetailIncidencia> {
  final _dateController = TextEditingController();
  final _dniController = TextEditingController();
  final _personNameController = TextEditingController();
  final _cargoController = TextEditingController();
  final _empresaController = TextEditingController();
  final _locationController = TextEditingController();
  final _hourController = TextEditingController();
  final _placeSController = TextEditingController();
  final _descripcionBreveController = TextEditingController();
  final _actionRealizedController = TextEditingController();
  final _saveActController = TextEditingController();
  final _othersInsaveController = TextEditingController();
  final _saveCondictionController = TextEditingController();
  final _othersInsave2Controller = TextEditingController();

  //Aprobe
  final _comentsController = TextEditingController();
  final _firmaController = TextEditingController();
  final _dateNewController = TextEditingController();

  final _controller = DetailController();

  String selectRadio = '0';
  String selectRadio2 = '0';

  List<CheckBoxState> actitud = [];
  List<CheckBoxState> epp = [];
  List<CheckBoxState> herramientas = [];
  List<CheckBoxState> procedimientos = [];
  List<CheckBoxState> herraEquipos = [];
  List<CheckBoxState> ambientes = [];

  @override
  void initState() {
    _dateController.text = widget.incidencia.dateCreated ?? '';
    _dniController.text = widget.incidencia.dniGenerated ?? '';
    _personNameController.text = widget.incidencia.personGenerated ?? '';
    _cargoController.text = widget.incidencia.cargoGenerado ?? '';
    _empresaController.text = widget.incidencia.businessName ?? '';
    _locationController.text = widget.incidencia.locationIncidencia ?? '';
    _hourController.text = widget.incidencia.hourIncidencia ?? '';
    _placeSController.text = widget.incidencia.placeEspecificIncidencia ?? '';
    _descripcionBreveController.text = widget.incidencia.descripcionObsIncidencia ?? '';
    _actionRealizedController.text = widget.incidencia.accionRealizadaIncidencia ?? '';
    _saveActController.text = widget.incidencia.actoSeguroIncidencia ?? '';
    _othersInsaveController.text = widget.incidencia.evaluacionCausaOtro ?? '';
    _saveCondictionController.text = widget.incidencia.condicionSegura ?? '';
    _othersInsave2Controller.text = widget.incidencia.inseguraOtro ?? '';

    selectRadio = widget.incidencia.typeIncidencia ?? '0';
    selectRadio2 = widget.incidencia.openClosedIncidencia ?? '0';

    getDataInit();

    actitud = [
      CheckBoxState(title: 'Frustración (Mal genio)', value: widget.incidencia.actitudFrustracion == '1' ? true : false),
      CheckBoxState(title: 'Fatiga', value: widget.incidencia.actitudFatiga == '1' ? true : false),
      CheckBoxState(title: 'Prisa (Afán)', value: widget.incidencia.actitudPrisa == '1' ? true : false),
    ];

    epp = [
      CheckBoxState(title: 'Elemento Inadecuado', value: widget.incidencia.appElementoInadeciado == '1' ? true : false),
      CheckBoxState(title: 'Mal uso', value: widget.incidencia.appMalUso == '1' ? true : false),
      CheckBoxState(title: 'No uso', value: widget.incidencia.appNoUso == '1' ? true : false),
    ];

    herramientas = [
      CheckBoxState(title: 'Herramientas o Equipo Inadecuado', value: widget.incidencia.herramientaInadecuado == '1' ? true : false),
      CheckBoxState(title: 'Mal uso', value: widget.incidencia.herramientaMalUso == '1' ? true : false),
      CheckBoxState(title: 'No uso', value: widget.incidencia.herramientaNoUso == '1' ? true : false),
    ];

    procedimientos = [
      CheckBoxState(title: 'No se comprende', value: widget.incidencia.proceNoseComprende == '1' ? true : false),
      CheckBoxState(title: 'No se sabe', value: widget.incidencia.proceNoseSabe == '1' ? true : false),
      CheckBoxState(title: 'No se sigue', value: widget.incidencia.proceNoseSigue == '1' ? true : false),
    ];

    herraEquipos = [
      CheckBoxState(title: 'Inadecuadas', value: widget.incidencia.herraInadecuada == '1' ? true : false),
      CheckBoxState(title: 'Dañadas', value: widget.incidencia.herraDanada == '1' ? true : false),
      CheckBoxState(title: 'Falta de Mantenimiento', value: widget.incidencia.herraFaltaMante == '1' ? true : false),
      CheckBoxState(title: 'Inexistentes', value: widget.incidencia.herraInexistente == '1' ? true : false),
    ];

    ambientes = [
      CheckBoxState(title: 'Exceso de Ruido', value: widget.incidencia.ambienteExcesoRuido == '1' ? true : false),
      CheckBoxState(title: 'Ambiente Peligroso', value: widget.incidencia.ambientePeligroso == '1' ? true : false),
      CheckBoxState(title: 'Inadecuada Iluminación', value: widget.incidencia.ambienteInaIluminacion == '1' ? true : false),
      CheckBoxState(title: 'Falta de Orden y Limpieza', value: widget.incidencia.ambienteFaltaOrden == '1' ? true : false),
      CheckBoxState(title: 'Mala Señalización', value: widget.incidencia.ambienteMalaSenalizacion == '1' ? true : false),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final docsBloc = ProviderBloc.incidencias(context);
    docsBloc.getDocumentsByIdIncidencia(widget.incidencia.idIncidencia!);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Aprobar Incidencia',
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
              padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(10), horizontal: ScreenUtil().setWidth(16)),
              child: Column(
                children: [
                  ExpansionTile(
                    initiallyExpanded: true,
                    maintainState: true,
                    title: Text(
                      'DATOS',
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(16),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    children: [
                      SizedBox(height: ScreenUtil().setHeight(10)),
                      TextFieldSelect(
                        label: 'Fecha',
                        hingText: '',
                        controller: _dateController,
                        readOnly: true,
                        icon: true,
                        widget: Icon(Icons.calendar_month, color: Colors.indigo),
                      ),
                      SizedBox(height: ScreenUtil().setHeight(20)),
                      TextFieldSelect(
                        label: 'DNI',
                        hingText: '',
                        controller: _dniController,
                        readOnly: true,
                        icon: false,
                      ),
                      SizedBox(height: ScreenUtil().setHeight(20)),
                      TextFieldSelect(
                        label: 'Nombre',
                        hingText: '',
                        controller: _personNameController,
                        readOnly: true,
                        icon: false,
                      ),
                      SizedBox(height: ScreenUtil().setHeight(20)),
                      TextFieldSelect(
                        label: 'Cargo',
                        hingText: '',
                        controller: _cargoController,
                        readOnly: true,
                        icon: false,
                      ),
                      SizedBox(height: ScreenUtil().setHeight(20)),
                      TextFieldSelect(
                        label: 'Empresa',
                        hingText: '',
                        controller: _empresaController,
                        readOnly: true,
                        icon: false,
                      ),
                      SizedBox(height: ScreenUtil().setHeight(20)),
                      RadioListTile<String>(value: '1', groupValue: selectRadio, title: Text('Seguridad'), onChanged: (i) {}),
                      RadioListTile<String>(value: '2', groupValue: selectRadio, title: Text('Salud'), onChanged: (i) {}),
                      RadioListTile<String>(value: ' 3', groupValue: selectRadio, title: Text('Ambiental'), onChanged: (i) {}),
                    ],
                  ),
                  SizedBox(height: ScreenUtil().setHeight(10)),
                  ExpansionTile(
                    initiallyExpanded: true,
                    maintainState: true,
                    title: Text(
                      'OBSERVACIÓN',
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(16),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    children: [
                      SizedBox(height: ScreenUtil().setHeight(10)),
                      TextFieldSelect(
                        label: 'Locación',
                        hingText: '',
                        controller: _locationController,
                        readOnly: true,
                        icon: false,
                      ),
                      SizedBox(height: ScreenUtil().setHeight(20)),
                      TextFieldSelect(
                        label: 'Hora',
                        hingText: '',
                        controller: _hourController,
                        readOnly: true,
                        icon: true,
                        widget: Icon(Icons.watch_later, color: Colors.indigo),
                      ),
                      SizedBox(height: ScreenUtil().setHeight(20)),
                      TextFieldSelect(
                        label: 'Lugar Específico',
                        hingText: '',
                        controller: _placeSController,
                        readOnly: true,
                        icon: false,
                      ),
                      SizedBox(height: ScreenUtil().setHeight(20)),
                      TextFieldSelect(
                        label: 'Breve Descripción',
                        hingText: '',
                        controller: _descripcionBreveController,
                        readOnly: true,
                        icon: false,
                      ),
                      SizedBox(height: ScreenUtil().setHeight(20)),
                    ],
                  ),
                  SizedBox(height: ScreenUtil().setHeight(10)),
                  ExpansionTile(
                    initiallyExpanded: true,
                    maintainState: true,
                    title: Text(
                      'ACCIÓN REALIZADA',
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(16),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    children: [
                      SizedBox(height: ScreenUtil().setHeight(10)),
                      TextFieldSelect(
                        label: '',
                        hingText: '',
                        controller: _actionRealizedController,
                        readOnly: true,
                        icon: false,
                      ),
                      SizedBox(height: ScreenUtil().setHeight(20)),
                      RadioListTile<String>(value: '1', groupValue: selectRadio2, title: Text('Abierto'), onChanged: (i) {}),
                      RadioListTile<String>(value: '2', groupValue: selectRadio2, title: Text('Cerrado'), onChanged: (i) {}),
                      SizedBox(height: ScreenUtil().setHeight(20)),
                    ],
                  ),
                  SizedBox(height: ScreenUtil().setHeight(10)),
                  ExpansionTile(
                    initiallyExpanded: true,
                    maintainState: true,
                    title: Text(
                      'EVALUACIÓN DE CAUSAS',
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(16),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    children: [
                      SizedBox(height: ScreenUtil().setHeight(10)),
                      TextFieldSelect(
                        label: 'Acto Seguro',
                        hingText: '',
                        controller: _saveActController,
                        readOnly: true,
                        icon: false,
                      ),
                      SizedBox(height: ScreenUtil().setHeight(10)),
                      Divider(),
                      SizedBox(height: ScreenUtil().setHeight(10)),
                      Text('ACTO INSEGURO', style: TextStyle(fontSize: ScreenUtil().setSp(16), fontWeight: FontWeight.w500, color: Colors.indigo)),
                      SizedBox(height: ScreenUtil().setHeight(20)),
                      Align(
                          alignment: Alignment.topLeft,
                          child:
                              Text('ACTITUD', style: TextStyle(fontSize: ScreenUtil().setSp(14), fontWeight: FontWeight.w500, color: Colors.indigo))),
                      SizedBox(height: ScreenUtil().setHeight(10)),
                      ...actitud.map(buildSingleCheckBox).toList(),
                      SizedBox(height: ScreenUtil().setHeight(20)),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Text('EPP', style: TextStyle(fontSize: ScreenUtil().setSp(14), fontWeight: FontWeight.w500, color: Colors.indigo))),
                      SizedBox(height: ScreenUtil().setHeight(10)),
                      ...epp.map(buildSingleCheckBox).toList(),
                      SizedBox(height: ScreenUtil().setHeight(20)),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Text('HERRAMIENTAS Y EQUIPOS',
                              style: TextStyle(fontSize: ScreenUtil().setSp(14), fontWeight: FontWeight.w500, color: Colors.indigo))),
                      SizedBox(height: ScreenUtil().setHeight(10)),
                      ...herramientas.map(buildSingleCheckBox).toList(),
                      SizedBox(height: ScreenUtil().setHeight(20)),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Text('PROCEDIMIENTOS Y NORMAS',
                              style: TextStyle(fontSize: ScreenUtil().setSp(14), fontWeight: FontWeight.w500, color: Colors.indigo))),
                      SizedBox(height: ScreenUtil().setHeight(10)),
                      ...procedimientos.map(buildSingleCheckBox).toList(),
                      SizedBox(height: ScreenUtil().setHeight(10)),
                      Divider(),
                      SizedBox(height: ScreenUtil().setHeight(10)),
                      TextFieldSelect(
                        label: 'Otro',
                        hingText: '',
                        controller: _othersInsaveController,
                        readOnly: true,
                        icon: false,
                      ),
                      SizedBox(height: ScreenUtil().setHeight(10)),
                      Divider(color: Colors.indigo, thickness: 2),
                      SizedBox(height: ScreenUtil().setHeight(20)),
                      TextFieldSelect(
                        label: 'Condición Segura',
                        hingText: '',
                        controller: _saveCondictionController,
                        readOnly: true,
                        icon: false,
                      ),
                      SizedBox(height: ScreenUtil().setHeight(10)),
                      Divider(),
                      SizedBox(height: ScreenUtil().setHeight(10)),
                      Text('CONDICIÓN INSEGURA',
                          style: TextStyle(fontSize: ScreenUtil().setSp(16), fontWeight: FontWeight.w500, color: Colors.indigo)),
                      SizedBox(height: ScreenUtil().setHeight(20)),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Text('Herramientas y Equipos',
                              style: TextStyle(fontSize: ScreenUtil().setSp(14), fontWeight: FontWeight.w500, color: Colors.indigo))),
                      SizedBox(height: ScreenUtil().setHeight(10)),
                      ...herraEquipos.map(buildSingleCheckBox).toList(),
                      SizedBox(height: ScreenUtil().setHeight(20)),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Text('AMBIENTES DE TRABAJO',
                              style: TextStyle(fontSize: ScreenUtil().setSp(14), fontWeight: FontWeight.w500, color: Colors.indigo))),
                      SizedBox(height: ScreenUtil().setHeight(10)),
                      ...ambientes.map(buildSingleCheckBox).toList(),
                      SizedBox(height: ScreenUtil().setHeight(10)),
                      Divider(),
                      SizedBox(height: ScreenUtil().setHeight(10)),
                      TextFieldSelect(
                        label: 'Otro',
                        hingText: '',
                        controller: _othersInsave2Controller,
                        readOnly: true,
                        icon: false,
                      ),
                      SizedBox(height: ScreenUtil().setHeight(10)),
                    ],
                  ),
                  SizedBox(height: ScreenUtil().setHeight(10)),
                  ExpansionTile(
                    initiallyExpanded: true,
                    maintainState: true,
                    title: Text(
                      'ESPACIO PARA HSE',
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(16),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    children: [
                      SizedBox(height: ScreenUtil().setHeight(10)),
                      TextFieldSelect(
                        label: 'Comentarios',
                        hingText: '',
                        controller: _comentsController,
                        readOnly: false,
                        icon: false,
                      ),
                      SizedBox(height: ScreenUtil().setHeight(20)),
                      TextFieldSelect(
                        label: 'Firma',
                        hingText: 'Seleccionar Archivo',
                        controller: _firmaController,
                        readOnly: true,
                        icon: true,
                        widget: Icon(Icons.upload, color: Colors.indigo),
                        ontap: () async {
                          FocusScope.of(context).unfocus();
                          final path = await PdfApi().seleccionarDoc();

                          _firmaController.text = path?.path != null ? basename(path!.path) : 'Seleccionar Archivo';
                          _controller.changeFile(path);
                        },
                      ),
                      SizedBox(height: ScreenUtil().setHeight(20)),
                      TextFieldSelect(
                        label: 'Fecha',
                        hingText: '',
                        controller: _dateNewController,
                        readOnly: true,
                        icon: true,
                        widget: Icon(Icons.calendar_month, color: Colors.indigo),
                        ontap: () {
                          selectdate(context, _dateNewController);
                        },
                      ),
                      SizedBox(height: ScreenUtil().setHeight(20)),
                      ElevatedButton.icon(
                        onPressed: () async {
                          FocusScope.of(context).unfocus();
                          if (_comentsController.text.isEmpty) return showToast2('Debe ingresar un Comentario', Colors.redAccent);
                          if (_controller.file == null) return showToast2('Debe seleccionar un archivo, imagen, etc como firma', Colors.redAccent);
                          if (_dateNewController.text.isEmpty) return showToast2('Debe ingresar una fecha', Colors.redAccent);

                          final _api = QHSEApi();
                          _controller.changeCargando(true);
                          final res = await _api.aprobarIncidenciaPendienteVerificacion(
                              _controller.file!, widget.incidencia.idIncidencia!, _comentsController.text, _dateNewController.text);

                          _controller.changeCargando(false);

                          if (res.code != 200) return showToast2(res.message, Colors.redAccent);

                          showToast2(res.message, Colors.green);
                          Navigator.pop(context);
                          docsBloc.getIncidenciasPendientes();
                        },
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                          ),
                          padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.symmetric(
                              horizontal: ScreenUtil().setWidth(15),
                              vertical: ScreenUtil().setHeight(4),
                            ),
                          ),
                        ),
                        icon: Icon(
                          Icons.check_circle_outline,
                          size: ScreenUtil().setHeight(25),
                        ),
                        label: Text(
                          'APROBAR',
                          style: TextStyle(fontSize: ScreenUtil().setSp(20), fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(height: ScreenUtil().setHeight(20)),
                    ],
                  ),
                  SizedBox(height: ScreenUtil().setHeight(20)),
                  StreamBuilder<List<DocumentsAnexadosModel>>(
                    stream: docsBloc.docsIncidenciasStream,
                    builder: (_, snapshot) {
                      if (!snapshot.hasData) return CircularProgressIndicator();
                      if (snapshot.data!.isEmpty) return Text('No existen archivos para este registro');

                      return ExpansionTile(
                          initiallyExpanded: true,
                          maintainState: true,
                          title: Text(
                            'ARCHIVOS ANEXADOS',
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(16),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          children: [
                            ...snapshot.data!.map((dc) {
                              return buildDocsAnex(context, dc);
                            }).toList(),
                          ]);
                    },
                  ),
                  SizedBox(height: ScreenUtil().setHeight(20)),
                ],
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
            },
          ),
        ],
      ),
    );
  }

  Widget buildSingleCheckBox(CheckBoxState item) {
    return CheckboxListTile(
      controlAffinity: ListTileControlAffinity.leading,
      activeColor: Colors.indigo,
      title: Text(item.title),
      value: item.value,
      onChanged: (value) {},
    );
  }

  Widget buildDocsAnex(BuildContext context, DocumentsAnexadosModel doc) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () async {
          _controller.changeCargando(true);
          final _apiPdf = PdfApi();
          await _apiPdf.openFile(url: '$API_BASE_URL/${doc.urlDoc ?? ''}');
          _controller.changeCargando(false);
        },
        child: cards(
          child: Row(
            children: [
              SizedBox(width: ScreenUtil().setWidth(50), child: Icon(Icons.remove_red_eye, color: Colors.blueGrey)),
              Expanded(
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        obtenerFechaHour(doc.dateCreated ?? ''),
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(10),
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    SizedBox(height: ScreenUtil().setHeight(4)),
                    Text(
                      doc.descripcionDoc ?? '',
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(11),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: ScreenUtil().setHeight(4)),
                    rows(
                        titulo: 'Tipo:',
                        data: doc.typeDoc == '1' ? 'Fotografía' : 'Documento',
                        st: 9,
                        sd: 10,
                        crossAxisAlignment: CrossAxisAlignment.start),
                    SizedBox(height: ScreenUtil().setHeight(4)),
                    rows(titulo: 'Fecha del Archivo:', data: doc.dateRegisterDoc ?? '', st: 9, sd: 10, crossAxisAlignment: CrossAxisAlignment.start),
                  ],
                ),
              ),
            ],
          ),
          fondo: Colors.white,
          color: Colors.deepPurple,
          height: 40,
          mtop: 20,
        ),
      ),
    );
  }

  void getDataInit() {
    var picked = DateTime.now();
    _dateNewController.text =
        "${picked.year.toString().padLeft(2, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
  }
}

class DetailController extends ChangeNotifier {
  File? file;
  bool cargando = false;

  void changeCargando(bool c) {
    cargando = c;
    notifyListeners();
  }

  void changeFile(File? f) {
    file = f;
    notifyListeners();
  }
}

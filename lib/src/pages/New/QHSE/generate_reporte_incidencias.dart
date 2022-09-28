import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soal_app/core/util/utils.dart';
import 'package:soal_app/src/api/QHSE/qhse_api.dart';
import 'package:soal_app/src/bloc/data_user.dart';
import 'package:soal_app/src/bloc/provider_bloc.dart';
import 'package:soal_app/src/pages/New/QHSE/check_box_state.dart';
import 'package:soal_app/src/widgets/show_loading.dart';
import 'package:soal_app/src/widgets/text_field.dart';

class GenerateReport extends StatefulWidget {
  const GenerateReport({Key? key, required this.datosUsuario}) : super(key: key);
  final UserModel datosUsuario;

  @override
  State<GenerateReport> createState() => _GenerateReportState();
}

class _GenerateReportState extends State<GenerateReport> {
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

  int selectRadio = 1;
  final actitud = [
    CheckBoxState(title: 'Frustración (Mal genio)'),
    CheckBoxState(title: 'Fatiga'),
    CheckBoxState(title: 'Prisa (Afán)'),
  ];

  final epp = [
    CheckBoxState(title: 'Elemento Inadecuado'),
    CheckBoxState(title: 'Mal uso'),
    CheckBoxState(title: 'No uso'),
  ];

  final herramientas = [
    CheckBoxState(title: 'Herramientas o Equipo Inadecuado'),
    CheckBoxState(title: 'Mal uso'),
    CheckBoxState(title: 'No uso'),
  ];

  final procedimientos = [
    CheckBoxState(title: 'No se comprende'),
    CheckBoxState(title: 'No se sabe'),
    CheckBoxState(title: 'No se sigue'),
  ];

  final herraEquipos = [
    CheckBoxState(title: 'Inadecuadas'),
    CheckBoxState(title: 'Dañadas'),
    CheckBoxState(title: 'Falta de Mantenimiento'),
    CheckBoxState(title: 'Inexistentes'),
  ];

  final ambientes = [
    CheckBoxState(title: 'Exceso de Ruido'),
    CheckBoxState(title: 'Ambiente Peligroso'),
    CheckBoxState(title: 'Inadecuada Iluminación'),
    CheckBoxState(title: 'Falta de Orden y Limpieza'),
    CheckBoxState(title: 'Mala Señalización'),
  ];

  @override
  void initState() {
    var dataUser = widget.datosUsuario;
    _dniController.text = dataUser.dniPerson ?? '';
    _personNameController.text = '${dataUser.personName ?? ''} ${dataUser.personSurname ?? ''} ${dataUser.personSurname2 ?? ''}';
    _cargoController.text = dataUser.cargoName ?? '';
    _empresaController.text = dataUser.businessName ?? '';
    getDataInit();
    super.initState();
  }

  final _controller = ControllerQHSE();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(10), horizontal: ScreenUtil().setWidth(16)),
          child: (widget.datosUsuario.peridoID == '')
              ? Center(
                  child: Column(
                  children: [
                    Text(
                      'Generar Reporte de Incidencias',
                      style: TextStyle(fontSize: ScreenUtil().setSp(16), fontWeight: FontWeight.w500, color: Colors.indigo),
                    ),
                    SizedBox(height: ScreenUtil().setHeight(10)),
                    Text('El usuario no cuenta con un Periodo Laboral activo'),
                  ],
                ))
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Text('Generar Reporte de Incidencias',
                          style: TextStyle(fontSize: ScreenUtil().setSp(16), fontWeight: FontWeight.w500, color: Colors.indigo)),
                      SizedBox(height: ScreenUtil().setHeight(10)),
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
                            ontap: () {
                              selectdate(context, _dateController);
                            },
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
                          RadioListTile<int>(
                            value: 1,
                            groupValue: selectRadio,
                            title: Text('Seguridad'),
                            onChanged: (i) => setState(
                              () {
                                selectRadio = i!;
                              },
                            ),
                          ),
                          RadioListTile<int>(
                            value: 2,
                            groupValue: selectRadio,
                            title: Text('Salud'),
                            onChanged: (i) => setState(
                              () {
                                selectRadio = i!;
                              },
                            ),
                          ),
                          RadioListTile<int>(
                            value: 3,
                            groupValue: selectRadio,
                            title: Text('Ambiental'),
                            onChanged: (i) => setState(
                              () {
                                selectRadio = i!;
                              },
                            ),
                          ),
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
                            readOnly: false,
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
                            ontap: () {
                              selectHour(context, _hourController);
                            },
                          ),
                          SizedBox(height: ScreenUtil().setHeight(20)),
                          TextFieldSelect(
                            label: 'Lugar Específico',
                            hingText: '',
                            controller: _placeSController,
                            readOnly: false,
                            icon: false,
                          ),
                          SizedBox(height: ScreenUtil().setHeight(20)),
                          TextFieldSelect(
                            label: 'Breve Descripción',
                            hingText: '',
                            controller: _descripcionBreveController,
                            readOnly: false,
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
                            readOnly: false,
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
                            readOnly: false,
                            icon: false,
                          ),
                          SizedBox(height: ScreenUtil().setHeight(10)),
                          Divider(),
                          SizedBox(height: ScreenUtil().setHeight(10)),
                          Text('ACTO INSEGURO',
                              style: TextStyle(fontSize: ScreenUtil().setSp(16), fontWeight: FontWeight.w500, color: Colors.indigo)),
                          SizedBox(height: ScreenUtil().setHeight(20)),
                          Align(
                              alignment: Alignment.topLeft,
                              child: Text('ACTITUD',
                                  style: TextStyle(fontSize: ScreenUtil().setSp(14), fontWeight: FontWeight.w500, color: Colors.indigo))),
                          SizedBox(height: ScreenUtil().setHeight(10)),
                          ...actitud.map(buildSingleCheckBox).toList(),
                          SizedBox(height: ScreenUtil().setHeight(20)),
                          Align(
                              alignment: Alignment.topLeft,
                              child:
                                  Text('EPP', style: TextStyle(fontSize: ScreenUtil().setSp(14), fontWeight: FontWeight.w500, color: Colors.indigo))),
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
                            readOnly: false,
                            icon: false,
                          ),
                          SizedBox(height: ScreenUtil().setHeight(10)),
                          Divider(color: Colors.indigo, thickness: 2),
                          SizedBox(height: ScreenUtil().setHeight(20)),
                          TextFieldSelect(
                            label: 'Condición Segura',
                            hingText: '',
                            controller: _saveCondictionController,
                            readOnly: false,
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
                            readOnly: false,
                            icon: false,
                          ),
                          SizedBox(height: ScreenUtil().setHeight(10)),
                        ],
                      ),
                      SizedBox(height: ScreenUtil().setHeight(10)),
                      ElevatedButton.icon(
                        onPressed: () async {
                          if (_dateController.text.isEmpty) return showToast2('Debe ingresar una Fecha', Colors.redAccent);
                          if (_locationController.text.isEmpty) return showToast2('Debe ingresar una Locación', Colors.redAccent);
                          if (_hourController.text.isEmpty) return showToast2('Debe ingresar una Hora', Colors.redAccent);
                          if (_placeSController.text.isEmpty) return showToast2('Debe ingresar una Lugar Específico', Colors.redAccent);
                          if (_descripcionBreveController.text.isEmpty) return showToast2('Debe ingresar una Breve Descripción', Colors.redAccent);
                          if (_actionRealizedController.text.isEmpty) return showToast2('Debe ingresar una Acción Realizada', Colors.redAccent);

                          final _api = QHSEApi();
                          _controller.changeLoadinn(true);
                          final res = await _api.generateIncidencia(
                              idEmpresa: widget.datosUsuario.businessID!,
                              idPerido: widget.datosUsuario.peridoID!,
                              dateCreated: _dateController.text,
                              typeIncidencia: selectRadio.toString(),
                              place: _locationController.text,
                              hourIncidencia: _hourController.text,
                              placeEspecific: _placeSController.text,
                              descripcion: _descripcionBreveController.text,
                              accionRealizada: _actionRealizedController.text,
                              openCloseIncidencia: '1',
                              safeAct: _saveActController.text,
                              frustracion: actitud[0].value ? '1' : '0',
                              fatiga: actitud[1].value ? '1' : '0',
                              prisa: actitud[2].value ? '1' : '0',
                              eppElemento: epp[0].value ? '1' : '0',
                              eppMaluso: epp[1].value ? '1' : '0',
                              eppNouso: epp[2].value ? '1' : '0',
                              herramientaInadec: herramientas[0].value ? '1' : '0',
                              herramientaMaluso: herramientas[1].value ? '1' : '0',
                              herramientaNouso: herramientas[2].value ? '1' : '0',
                              proceNoseComprende: procedimientos[0].value ? '1' : '0',
                              proceNoseSabe: procedimientos[1].value ? '1' : '0',
                              proceNoseSigue: procedimientos[2].value ? '1' : '0',
                              evalCausaOtro: _othersInsaveController.text,
                              condicionSegura: _saveCondictionController.text,
                              herraInadecuada: herraEquipos[0].value ? '1' : '0',
                              herraDaNada: herraEquipos[1].value ? '1' : '0',
                              herraFaltaMante: herraEquipos[2].value ? '1' : '0',
                              herraInexistente: herraEquipos[3].value ? '1' : '0',
                              ambienteExcesoRuido: ambientes[0].value ? '1' : '0',
                              ambienteFaltaOrden: ambientes[1].value ? '1' : '0',
                              ambientePeligroso: ambientes[2].value ? '1' : '0',
                              ambienteInaIluminacion: ambientes[3].value ? '1' : '0',
                              ambienteMalaSenal: ambientes[4].value ? '1' : '0',
                              otro2: _othersInsave2Controller.text);
                          _controller.changeLoadinn(false);

                          if (res.code != 1) return showToast2(res.message, Colors.redAccent);
                          showToast2('Reporte Generado Correctamente', Colors.green);
                          getDataInit();
                          _locationController.clear();
                          _placeSController.clear();
                          _descripcionBreveController.clear();
                          _actionRealizedController.clear();
                          _saveActController.clear();
                          _othersInsaveController.clear();
                          _saveCondictionController.clear();
                          _othersInsave2Controller.clear();

                          actitud.forEach((element) => element.value = false);
                          epp.forEach((element) => element.value = false);
                          herramientas.forEach((element) => element.value = false);
                          procedimientos.forEach((element) => element.value = false);
                          herraEquipos.forEach((element) => element.value = false);
                          ambientes.forEach((element) => element.value = false);
                          setState(() {});
                          final dataUserBloc = ProviderBloc.data(context);
                          dataUserBloc.obtenerUser();
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
                          Icons.save_outlined,
                          size: ScreenUtil().setHeight(25),
                        ),
                        label: Text(
                          'GUARDAR',
                          style: TextStyle(fontSize: ScreenUtil().setSp(20), fontWeight: FontWeight.w500),
                        ),
                      ),
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
            }),
      ],
    );
  }

  void getDataInit() {
    var picked = DateTime.now();
    _dateController.text =
        "${picked.year.toString().padLeft(2, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
    _hourController.text =
        "${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}:${picked.second.toString().padLeft(2, '0')}";
  }

  Widget buildSingleCheckBox(CheckBoxState item) {
    return CheckboxListTile(
      controlAffinity: ListTileControlAffinity.leading,
      activeColor: Colors.indigo,
      title: Text(item.title),
      value: item.value,
      onChanged: ((value) => setState(() {
            item.value = value!;
          })),
    );
  }
}

class ControllerQHSE extends ChangeNotifier {
  bool cargando = false;

  void changeLoadinn(bool v) {
    cargando = v;
    notifyListeners();
  }
}

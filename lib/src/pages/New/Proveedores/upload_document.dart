import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path/path.dart';
import 'package:soal_app/core/util/utils.dart';
import 'package:soal_app/src/api/pdf_api.dart';
import 'package:soal_app/src/api/proveedores_api.dart';
import 'package:soal_app/src/bloc/provider_bloc.dart';
import 'package:soal_app/src/widgets/show_loading.dart';
import 'package:soal_app/src/widgets/text_field.dart';

class UploadDocument extends StatefulWidget {
  const UploadDocument({Key? key, required this.idProveedor}) : super(key: key);
  final String idProveedor;

  @override
  State<UploadDocument> createState() => _UploadDocumentState();
}

class _UploadDocumentState extends State<UploadDocument> {
  final _tipoComprobanteController = TextEditingController();
  final _fechaReferenciaController = TextEditingController();
  final _referenciaController = TextEditingController();
  final _archivoController = TextEditingController();

  final _controller = ControllerFile();

  List<String> spinnerItems = ['Seleccionar', 'Certificacion de Calidad', 'Ficha Tecnica', 'Hoja de Seguridad', 'Brochure'];

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      label: Text('Subir'),
      icon: Icon(Icons.upload_file),
      onPressed: () {
        _tipoComprobanteController.clear();
        _fechaReferenciaController.clear();
        _referenciaController.clear();
        _archivoController.clear();
        _controller.file = null;
        subir(context);
      },
    );
  }

  void subir(BuildContext context) {
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
                                  'Adjuntar Documento del Proveedor',
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
                                    _bottomShetTipe(context);
                                  },
                                ),
                                SizedBox(
                                  height: ScreenUtil().setHeight(20),
                                ),
                                TextFieldSelect(
                                  label: 'Fecha de Referencia',
                                  hingText: '',
                                  controller: _fechaReferenciaController,
                                  widget: Icon(
                                    Icons.calendar_month_outlined,
                                    color: Colors.indigo,
                                  ),
                                  readOnly: true,
                                  icon: true,
                                  ontap: () {
                                    FocusScope.of(context).unfocus();
                                    selectdate(context, _fechaReferenciaController);
                                  },
                                ),
                                SizedBox(
                                  height: ScreenUtil().setHeight(20),
                                ),
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
                                    // setState(() {
                                    //   file = File(path!.path);
                                    // });
                                  },
                                ),
                                SizedBox(
                                  height: ScreenUtil().setHeight(20),
                                ),
                                ElevatedButton.icon(
                                  onPressed: () async {
                                    if (_tipoComprobanteController.value.text.isNotEmpty) {
                                      if (_fechaReferenciaController.value.text.isNotEmpty) {
                                        if (_archivoController.value.text.isNotEmpty && _archivoController.value.text != 'Seleccionar Archivo') {
                                          _controller.changeCargando(true);
                                          final _api = ProveedoresApi();
                                          final res = await _api.uploadDocumentoProveedor(
                                              _controller.file!,
                                              widget.idProveedor,
                                              _tipoComprobanteController.value.text.trim(),
                                              _referenciaController.value.text.trim(),
                                              _fechaReferenciaController.value.text.trim());
                                          if (res.code == 200) {
                                            showToast2(res.message, Colors.green);
                                            final documentsBloc = ProviderBloc.documents(context);
                                            documentsBloc.obtenerDocumentos('1', widget.idProveedor.toString());
                                            _tipoComprobanteController.clear();
                                            _fechaReferenciaController.clear();
                                            _referenciaController.clear();
                                            _archivoController.clear();
                                            _controller.file = null;
                                            Navigator.pop(context);
                                          } else {
                                            showToast2(res.message, Colors.redAccent);
                                          }
                                          _controller.changeCargando(false);
                                        } else {
                                          showToast2('Seleccione un Archivo', Colors.redAccent);
                                        }
                                      } else {
                                        showToast2('Seleccione una Fecha de referencia', Colors.redAccent);
                                      }
                                    } else {
                                      showToast2('Seleccione un tipo de Comprobante', Colors.redAccent);
                                    }
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

  void _bottomShetTipe(BuildContext context) {
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
                          'Seleccionar Tipo de Comprobante',
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
                            itemCount: spinnerItems.length,
                            itemBuilder: (_, index) {
                              return InkWell(
                                onTap: () {
                                  _tipoComprobanteController.text = spinnerItems[index];
                                  Navigator.pop(context);
                                },
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Text(spinnerItems[index]),
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

class ControllerFile extends ChangeNotifier {
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

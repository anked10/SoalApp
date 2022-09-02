// import 'dart:io';

// import 'package:dio/dio.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:path/path.dart';
// import 'package:percent_indicator/linear_percent_indicator.dart';
// import 'package:provider/provider.dart';
// import 'package:soal_app/core/sharedpreferences/storage_manager.dart';
// import 'package:soal_app/core/util/constants.dart';
// import 'package:soal_app/core/util/utils.dart';
// import 'package:soal_app/src/bloc/provider_bloc.dart';
// import 'package:soal_app/src/models/si_model.dart';
// import 'package:soal_app/src/widgets/responsive.dart';

// class NuevoDocumento extends StatefulWidget {
//   final SiModel siModel;
//   const NuevoDocumento({Key? key, required this.siModel}) : super(key: key);

//   @override
//   _NuevoDocumentoState createState() => _NuevoDocumentoState();
// }

// class _NuevoDocumentoState extends State<NuevoDocumento> {
//   TextEditingController _fechaController = new TextEditingController();
//   TextEditingController _referenciaController = new TextEditingController();
//   TextEditingController _documentController = new TextEditingController();

//   late File selectedfile;
//   late Response response;
//   late String progress;
//   late Dio dio = new Dio();

//   @override
//   void dispose() {
//     _fechaController.dispose();
//     _referenciaController.dispose();
//     _documentController.dispose();
//     super.dispose();
//   }

//   String tipo = "Seleccionar tipo de documento";
//   List<DropdownMenuItem<String>> get dropdownTipo {
//     List<DropdownMenuItem<String>> menuItems = [
//       DropdownMenuItem(
//           child: Text("Seleccionar tipo de documento"),
//           value: "Seleccionar tipo de documento"),
//       DropdownMenuItem(child: Text("COTIZACIÓN"), value: "COTIZACIÓN"),
//       DropdownMenuItem(child: Text("AVISO"), value: "AVISO"),
//       DropdownMenuItem(child: Text("OTROS"), value: "OTROS"),
//     ];
//     return menuItems;
//   }

//   @override
//   void initState() {
//     _fechaController.text = 'Fecha';
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<UploapBloc>(context, listen: false);
//     final responsive = Responsive.of(context);
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: false,
//         title: Text(
//           'Nuevo Documento',
//           style: TextStyle(
//             color: Colors.black,
//           ),
//         ),
//         elevation: 0,
//         backgroundColor: Colors.white,
//         iconTheme: IconThemeData(color: Colors.black),
//       ),
//       body: Padding(
//         padding: EdgeInsets.symmetric(
//           horizontal: ScreenUtil().setWidth(20),
//         ),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               SizedBox(
//                 height: ScreenUtil().setHeight(20),
//               ),
//               Text(
//                 'Información del documento',
//                 style: TextStyle(
//                   fontSize: ScreenUtil().setSp(19),
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(
//                 height: ScreenUtil().setHeight(20),
//               ),
//               Container(
//                 width: double.infinity,
//                 padding: EdgeInsets.symmetric(
//                   horizontal: ScreenUtil().setWidth(10),
//                 ),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   border: Border.all(color: Colors.grey.shade300),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: DropdownButton(
//                     underline: Container(),
//                     isExpanded: true,
//                     value: tipo,
//                     onChanged: (String? newValue) {
//                       setState(() {
//                         tipo = newValue!;
//                       });
//                     },
//                     items: dropdownTipo),
//               ),
//               SizedBox(
//                 height: ScreenUtil().setHeight(40),
//               ),
//               Container(
//                 width: double.infinity,
//                 padding: EdgeInsets.symmetric(
//                   horizontal: ScreenUtil().setWidth(10),
//                 ),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   border: Border.all(color: Colors.grey.shade300),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: TextButton(
//                     onPressed: () {
//                       DatePicker.showDatePicker(context, showTitleActions: true,
//                           onChanged: (date) {
//                         print('change $date');
//                         setState(() {
//                           _fechaController.text =
//                               "${date.year.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
//                         });
//                       }, onConfirm: (date) {
//                         print('confirm $date');
//                       }, currentTime: DateTime.now(), locale: LocaleType.es);
//                     },
//                     child: Text(
//                       '${_fechaController.text}',
//                       style: TextStyle(color: Colors.black),
//                     )),
//               ),
//               SizedBox(
//                 height: ScreenUtil().setHeight(40),
//               ),
//               TextField(
//                 controller: _referenciaController,
//                 decoration: InputDecoration(
//                   filled: true,
//                   fillColor: Colors.white,
//                   hintText: 'Referencia',
//                   hintStyle: TextStyle(
//                     fontSize: ScreenUtil().setSp(14),
//                     color: Colors.grey[600],
//                   ),
//                   enabledBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                     borderSide: BorderSide(
//                       color: Colors.grey.shade300,
//                       width: 1.0,
//                     ),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                     borderSide: BorderSide(
//                       color: Colors.grey.shade300,
//                       width: 2.0,
//                     ),
//                   ),
//                   border: OutlineInputBorder(
//                     borderSide: BorderSide(
//                       color: Colors.grey.shade300,
//                       width: 1.0,
//                     ),
//                     borderRadius: BorderRadius.circular(
//                       ScreenUtil().setWidth(10),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: ScreenUtil().setHeight(40),
//               ),
//               Container(
//                 width: double.infinity,
//                 padding: EdgeInsets.symmetric(
//                   horizontal: ScreenUtil().setWidth(10),
//                 ),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   border: Border.all(color: Colors.grey.shade300),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: TextButton(
//                   onPressed: () async {
//                     String? selectedDirectory =
//                         await FilePicker.platform.getDirectoryPath();

//                     if (selectedDirectory == null) {
//                       // User canceled the picker
//                     }

//                     FilePickerResult? result =
//                         await FilePicker.platform.pickFiles();

//                     if (result != null) {
//                       selectedfile = File(result.files.single.path.toString());
//                       print('file ${selectedfile.path}');

//                       setState(() {
//                         _documentController.text = '${selectedfile.path}';
//                       });
//                     } else {
//                       // User canceled the picker
//                     }
//                   },
//                   child: Row(
//                     children: [
//                       Container(
//                         height: ScreenUtil().setSp(35),
//                         width: ScreenUtil().setSp(35),
//                         child: SvgPicture.asset(
//                           'assets/svg/folder_rojo.svg',
//                         ),
//                       ),
//                       SizedBox(
//                         width: ScreenUtil().setWidth(10),
//                       ),
//                       Expanded(
//                         child: Text(
//                           '${_documentController.text}',
//                           style: TextStyle(color: Colors.black),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: ScreenUtil().setHeight(40),
//               ),
//               InkWell(
//                 onTap: () {
//                   if (tipo != 'Seleccionar tipo de documento') {
//                     if (_fechaController.text.isNotEmpty &&
//                         _fechaController.text != 'Fecha') {
//                       if (_referenciaController.text.isNotEmpty) {
//                         if (_documentController.text.isNotEmpty) {
//                           uploadFile(
//                             selectedfile,
//                             widget.siModel.idSi.toString(),
//                             tipo,
//                             _referenciaController.text,
//                             _fechaController.text,
//                             provider,
//                             context,
//                           );
//                         } else {
//                           showToast2('Seleccione un  documento', Colors.red);
//                         }
//                       } else {
//                         showToast2('Ingrese una referencia', Colors.red);
//                       }
//                     } else {
//                       showToast2('Seleccione una fecha', Colors.red);
//                     }
//                   } else {
//                     showToast2('Seleccione un tipo de documento', Colors.red);
//                   }
//                 },
//                 child: Container(
//                   padding:
//                       EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(8)),
//                   decoration: BoxDecoration(
//                     color: Colors.red,
//                     border: Border.all(color: Colors.transparent),
//                     borderRadius: BorderRadius.circular(5),
//                   ),
//                   width: double.infinity,
//                   child: Center(
//                     child: Text(
//                       'Enviar',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: ScreenUtil().setSp(20),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: ScreenUtil().setHeight(40),
//               ),
//               ValueListenableBuilder(
//                   valueListenable: provider.cargando,
//                   builder: (BuildContext context, double data, Widget? child) {
//                     print('data $data');
//                     return (data == 0.0)
//                         ? Container()
//                         : (data == 100.0)
//                             ? Container(
//                                 margin: EdgeInsets.symmetric(
//                                     horizontal: responsive.wp(5)),
//                                 padding: EdgeInsets.symmetric(
//                                     vertical: responsive.hp(.5)),
//                                 decoration: BoxDecoration(
//                                     color: Colors.green,
//                                     borderRadius: BorderRadius.circular(10)),
//                                 child: Center(
//                                   child: Text(
//                                     'Descarga  completa',
//                                     style: TextStyle(color: Colors.white),
//                                   ),
//                                 ))
//                             : Padding(
//                                 padding: EdgeInsets.symmetric(
//                                     horizontal: ScreenUtil().setWidth(10)),
//                                 child: Container(
//                                   height: ScreenUtil().setHeight(40),
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.center,
//                                     children: [
//                                       Text('$data %'),
//                                       LinearPercentIndicator(
//                                         width: responsive.wp(70),
//                                         lineHeight: 14.0,
//                                         percent: data / 100,
//                                         backgroundColor: Colors.white,
//                                         progressColor: Colors.blue,
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               );
//                   }),
//               SizedBox(
//                 height: ScreenUtil().setHeight(40),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   uploadFile(File _image, String id, String tipo, String ref, String fecha,
//       UploapBloc provider, BuildContext context) async {
//     String? token = await StorageManager.readData('token');
//     String uploadurl = "$API_BASE_URL/api/Solicitudcompra/guardar_documento";
//     //dont use http://localhost , because emulator don't get that address
//     //insted use your local IP address or use live URL
//     //hit "ipconfig" in windows or "ip a" in linux to get you local IP

//     FormData formdata = FormData.fromMap({
//       "documento_archivo": await MultipartFile.fromFile(_image.path,
//           filename: basename(_image.path)
//           //show only filename from path
//           ),
//       "app": "true",
//       "tn": "$token",
//       "id_tipo": "$id",
//       "documento_tipo": "$tipo",
//       "documento_referencia": "$ref",
//       "documento_fecha": "$fecha",
//     });

//     response = await dio.post(
//       uploadurl,
//       data: formdata,
//       onSendProgress: (int sent, int total) {
//         String percentage = (sent / total * 100).toStringAsFixed(2);

//         progress = "$sent" +
//             " Bytes of " "$total Bytes - " +
//             percentage +
//             " % uploaded";
//         print('progress $progress');
//         provider._cargando.value = double.parse(percentage);
//         //update the progress
//       },
//     );

//     if (response.statusCode == 200) {
//       print(response.toString());

//       final documentsBloc = ProviderBloc.documents(context);

//       documentsBloc.obtenerDocumentos('3', id);
//       Navigator.pop(context);
//       //print response from server
//     } else {
//       print("Error during connection to server.");
//     }
//   }
// }

// class UploapBloc with ChangeNotifier {
//   ValueNotifier<double> _cargando = ValueNotifier(0.0);
//   ValueNotifier<double> get cargando => this._cargando;

//   BuildContext? context;

//   UploapBloc({this.context}) {
//     _init();
//   }
//   void _init() {}

//   void changeInicio() {
//     _cargando.value = 0.0;
//     notifyListeners();
//   }

//   void changeFinish() {
//     _cargando.value = 100.0;
//     notifyListeners();
//   }
// }

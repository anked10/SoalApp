// import 'dart:io';

// import 'package:flowder/flowder.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:focused_menu/focused_menu.dart';
// import 'package:focused_menu/modals.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:open_file/open_file.dart';
// import 'package:percent_indicator/linear_percent_indicator.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:provider/provider.dart';
// import 'package:soal_app/core/util/constants.dart';
// import 'package:soal_app/src/bloc/provider_bloc.dart';
// import 'package:soal_app/src/models/documento_oc_model.dart';
// import 'package:soal_app/src/pages/SolCompras/nuevo_documento.dart';
// import 'package:soal_app/src/widgets/responsive.dart';

// class DocumentosOC extends StatefulWidget {
//   final String idOp;
//   const DocumentosOC({Key? key, required this.idOp}) : super(key: key);

//   @override
//   _DocumentosOCState createState() => _DocumentosOCState();
// }

// class _DocumentosOCState extends State<DocumentosOC> {
//   late DownloaderUtils options;
//   late DownloaderCore core;
//   int valor = 0;

//   @override
//   Widget build(BuildContext context) {
//     final documentosOCBloc = ProviderBloc.docOC(context);
//     final provider = Provider.of<DocumentsOCBloc>(context, listen: false);
//     print('valor $valor');
//     if (valor == 0) {
//       documentosOCBloc.obtenerDocumentos(widget.idOp.toString());
//       valor++;
//     }
//     final responsive = Responsive.of(context);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Documentos',
//           style: TextStyle(color: Colors.black),
//         ),
//         centerTitle: false,
//         elevation: 0,
//         backgroundColor: Colors.white,
//         iconTheme: IconThemeData(color: Colors.black),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.add),
//             onPressed: () {
//               final provider = Provider.of<UploapBloc>(context, listen: false);
//               provider.changeInicio();
//               /* Navigator.push(
//                 context,
//                 PageRouteBuilder(
//                   pageBuilder: (context, animation, secondaryAnimation) {
//                     return NuevoDocumento(siModel: widget.simodel);
//                   },
//                   transitionsBuilder: (context, animation, secondaryAnimation, child) {
//                     var begin = Offset(0.0, 1.0);
//                     var end = Offset.zero;
//                     var curve = Curves.ease;

//                     var tween = Tween(begin: begin, end: end).chain(
//                       CurveTween(curve: curve),
//                     );

//                     return SlideTransition(
//                       position: animation.drive(tween),
//                       child: child,
//                     );
//                   },
//                 ),
//               ); */
//             },
//           )
//         ],
//       ),
//       body: Stack(
//         fit: StackFit.expand,
//         children: [
//           StreamBuilder(
//             stream: documentosOCBloc.documentodOCStream,
//             builder: (BuildContext context, AsyncSnapshot<List<DocumentoOCModel>> snapshot) {
//               if (snapshot.hasData) {
//                 if (snapshot.data!.length > 0) {
//                   return Padding(
//                     padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(10)),
//                     child: GridView.builder(
//                       padding: EdgeInsets.all(0),
//                       shrinkWrap: true,
//                       physics: ClampingScrollPhysics(),
//                       itemCount: snapshot.data!.length,
//                       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                         childAspectRatio: 1.5,
//                         crossAxisCount: 2,
//                         crossAxisSpacing: ScreenUtil().setWidth(10),
//                         mainAxisSpacing: ScreenUtil().setHeight(20),
//                       ),
//                       itemBuilder: (context, y) {
//                         print('0tra vex');

//                         int randomNumber = 0;

//                         final fechaFormat = snapshot.data![y].pagoVoucher!.split(".");
//                         var algo = fechaFormat.length - 1;

//                         if (fechaFormat[algo] == 'xlsx') {
//                           randomNumber = 3;
//                         } else if (fechaFormat[algo] == 'pdf') {
//                           randomNumber = 2;
//                         } else if (fechaFormat[algo] == 'docx') {
//                           randomNumber = 1;
//                         }

//                         return itemDatos(snapshot.data![y], randomNumber, provider);
//                       },
//                     ),
//                   );
//                 } else {
//                   return Center(
//                     child: Text('No hay Documentos disponibles'),
//                   );
//                 }
//               } else {
//                 return Center(
//                   child: CupertinoActivityIndicator(),
//                 );
//               }
//             },
//           ),
//           ValueListenableBuilder(
//               valueListenable: provider.cargando,
//               builder: (BuildContext context, double data, Widget? child) {
//                 print(data);
//                 return Positioned(
//                   bottom: 20,
//                   left: 0,
//                   right: 0,
//                   child: (data == 0.0)
//                       ? Container()
//                       : (data == 100.0)
//                           ? Container(
//                               margin: EdgeInsets.symmetric(horizontal: responsive.wp(5)),
//                               padding: EdgeInsets.symmetric(vertical: responsive.hp(.5)),
//                               decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(10)),
//                               child: Center(
//                                 child: Text(
//                                   'Descarga  completa',
//                                   style: TextStyle(color: Colors.white),
//                                 ),
//                               ))
//                           : Padding(
//                               padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(10)),
//                               child: Container(
//                                 height: ScreenUtil().setHeight(40),
//                                 child: Column(
//                                   children: [
//                                     Text('Descargando $data%'),
//                                     LinearPercentIndicator(
//                                       width: responsive.wp(90),
//                                       lineHeight: 14.0,
//                                       percent: data / 100,
//                                       backgroundColor: Colors.white,
//                                       progressColor: Colors.blue,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                 );
//               })
//         ],
//       ),
//     );
//   }

//   Widget itemDatos(DocumentoOCModel documento, int tipo, DocumentsOCBloc provider) {
//     var svg = 'assets/svg/folder_azul.svg';
//     Color col = Color(0xffeef7fe);
//     Color colMore = Color(0xff415eb6);

//     if (tipo == 1) {
//       svg = 'assets/svg/folder_azul.svg';
//       col = Color(0xffeef7fe);
//       colMore = Color(0xff415eb6);
//     } else if (tipo == 0) {
//       svg = 'assets/svg/folder_amarillo.svg';
//       col = Color(0xfffffbec);
//       colMore = Color(0xffffb110);
//     } else if (tipo == 2) {
//       svg = 'assets/svg/folder_rojo.svg';
//       col = Color(0xfffeeeee);
//       colMore = Color(0xffac4040);
//     } else if (tipo == 3) {
//       svg = 'assets/svg/folder_cyan.svg';
//       col = Color(0xfff0ffff);
//       colMore = Color(0xff23b0b0);
//     }
//     return LayoutBuilder(
//       builder: (BuildContext context, BoxConstraints constraints) {
//         return focusGeneral(
//             Container(
//               decoration: BoxDecoration(
//                 color: col,
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               padding: EdgeInsets.symmetric(
//                 horizontal: ScreenUtil().setWidth(10),
//               ),
//               width: double.infinity,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Row(
//                     children: [
//                       Container(
//                         height: ScreenUtil().setSp(45),
//                         width: ScreenUtil().setSp(45),
//                         child: SvgPicture.asset(
//                           '$svg',
//                         ),
//                       ),
//                       Spacer(),
//                       IconButton(
//                         onPressed: () {},
//                         icon: Icon(
//                           Icons.more_vert,
//                           color: colMore,
//                         ),
//                       )
//                     ],
//                   ),
//                   SizedBox(
//                     height: ScreenUtil().setHeight(10),
//                   ),
//                   Text(
//                     '${documento.pagoReferencia} - ${documento.tipoComprobante}',
//                     style: TextStyle(
//                       color: colMore,
//                       fontWeight: FontWeight.bold,
//                       fontSize: ScreenUtil().setSp(19),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//             documento,
//             provider);
//       },
//     );
//   }

//   FocusedMenuHolder focusGeneral(Widget childs, DocumentoOCModel document, DocumentsOCBloc provider) {
//     return FocusedMenuHolder(
//         blurBackgroundColor: Colors.black.withOpacity(0.2),
//         blurSize: 0,
//         animateMenuItems: true,
//         onPressed: () {
//           provider.changeInicio();
//         },
//         openWithTap: true,
//         menuWidth: ScreenUtil().setWidth(210),
//         menuItems: [
//           FocusedMenuItem(
//             title: Expanded(
//               child: Text(
//                 "ver",
//                 style: GoogleFonts.poppins(
//                   fontWeight: FontWeight.w400,
//                   fontSize: ScreenUtil().setSp(18),
//                   letterSpacing: ScreenUtil().setSp(0.016),
//                   color: Colors.black,
//                 ),
//               ),
//             ),
//             trailingIcon: Icon(
//               Icons.edit_outlined,
//               color: Colors.grey,
//               size: ScreenUtil().setHeight(20),
//             ),
//             onPressed: () async {
//               await new Future.delayed(new Duration(seconds: 1));
//               await [
//                 Permission.location,
//                 Permission.storage,
//               ].request();
//               var checkResult = await Permission.manageExternalStorage.status;

//               if (!checkResult.isGranted) {
//                 /* var dir = await getExternalStorageDirectory();
//                 var testdir = await Directory('${dir!.path}/SOAL').create(recursive: true);  */

//                 options = DownloaderUtils(
//                   progressCallback: (current, total) {
//                     provider.cargando.value = double.parse((current / total * 100).toStringAsFixed(2));
//                   },
//                   file: File('/storage/emulated/0/Soal/${document.pagoVoucher}'),
//                   progress: ProgressImplementation(),
//                   onDone: () {
//                     print('COMPLETE /storage/emulated/0/Soal/${document.pagoVoucher}');
//                     provider.changeFinish();
//                     final _result = OpenFile.open("/storage/emulated/0/Soal/${document.pagoVoucher}");
//                     print(_result);
//                   },
//                   deleteOnCancel: true,
//                 );
//                 //core = await Flowder.download('http://ipv4.download.thinkbroadband.com/5MB.zip', options);
//                 core = await Flowder.download('$API_BASE_URL/${document.pagoVoucher}', options);

//                 print(core);
//               } else if (await Permission.storage.request().isPermanentlyDenied) {
//                 await openAppSettings();
//               } else if (await Permission.storage.request().isDenied) {
//                 Map<Permission, PermissionStatus> statuses = await [
//                   Permission.location,
//                   Permission.storage,
//                 ].request();
//                 print(statuses[Permission.location]);
//               }

//               /*  Navigator.push(
//                 context,
//                 PageRouteBuilder(
//                   transitionDuration: const Duration(milliseconds: 400),
//                   pageBuilder: (context, animation, secondaryAnimation) {
//                     return PdfViewer(
//                       url: '$API_BASE_URL/${document.documentoArchivo}',
//                     );
//                   },
//                   transitionsBuilder: (context, animation, secondaryAnimation, child) {
//                     return FadeTransition(
//                       opacity: animation,
//                       child: child,
//                     );
//                   },
//                 ),
//               ); */

//               //PdfViewer
//             },
//           ),
//           FocusedMenuItem(
//             title: Expanded(
//               child: Text(
//                 "Descargar",
//                 style: GoogleFonts.poppins(
//                   fontWeight: FontWeight.w400,
//                   fontSize: ScreenUtil().setSp(18),
//                   letterSpacing: ScreenUtil().setSp(0.016),
//                   color: Colors.black,
//                 ),
//               ),
//             ),
//             trailingIcon: Icon(
//               Icons.insert_drive_file_sharp,
//               color: Colors.grey,
//               size: ScreenUtil().setHeight(20),
//             ),
//             onPressed: () async {
//               await new Future.delayed(new Duration(seconds: 1));
//               await [
//                 Permission.location,
//                 Permission.storage,
//               ].request();
//               var checkResult = await Permission.manageExternalStorage.status;

//               if (!checkResult.isGranted) {
//                 /* var dir = await getExternalStorageDirectory();
//                 var testdir = await Directory('${dir!.path}/SOAL').create(recursive: true);  */

//                 options = DownloaderUtils(
//                   progressCallback: (current, total) {
//                     provider.cargando.value = double.parse((current / total * 100).toStringAsFixed(2));
//                   },
//                   file: File('/storage/emulated/0/Soal/${document.pagoVoucher}'),
//                   progress: ProgressImplementation(),
//                   onDone: () {
//                     print('COMPLETE /storage/emulated/0/Soal/${document.pagoVoucher}');
//                     provider.changeFinish();
//                   },
//                   deleteOnCancel: true,
//                 );
//                 //core = await Flowder.download('http://ipv4.download.thinkbroadband.com/5MB.zip', options);
//                 core = await Flowder.download('$API_BASE_URL/${document.pagoVoucher}', options);

//                 print(core);
//               } else if (await Permission.storage.request().isPermanentlyDenied) {
//                 await openAppSettings();
//               } else if (await Permission.storage.request().isDenied) {
//                 Map<Permission, PermissionStatus> statuses = await [
//                   Permission.location,
//                   Permission.storage,
//                 ].request();
//                 print(statuses[Permission.location]);
//               }
//             },
//           ),
//         ],
//         child: childs);
//   }
// }

// class DocumentsOCBloc with ChangeNotifier {
//   ValueNotifier<double> _cargando = ValueNotifier(0.0);
//   ValueNotifier<double> get cargando => this._cargando;

//   BuildContext? context;

//   DocumentsOCBloc({this.context}) {
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

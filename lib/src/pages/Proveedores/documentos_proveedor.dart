import 'dart:io';
import 'dart:math';

import 'package:flowder/flowder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:soal_app/core/util/constants.dart';
import 'package:soal_app/src/bloc/provider_bloc.dart';
import 'package:soal_app/src/models/documento_model.dart';
import 'package:soal_app/src/models/proveedores_model.dart';
import 'package:soal_app/src/pages/pdf_viewer.dart';

class DocumentosProveedor extends StatefulWidget {
  final ProveedorModel proveedor;
  const DocumentosProveedor({Key? key, required this.proveedor}) : super(key: key);

  @override
  _DocumentosProveedorState createState() => _DocumentosProveedorState();
}

class _DocumentosProveedorState extends State<DocumentosProveedor> {
  late DownloaderUtils options;
  late DownloaderCore core;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final documentsBloc = ProviderBloc.documents(context);
    documentsBloc.obtenerDocumentos('1', widget.proveedor.idProveedor.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Documentos',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: StreamBuilder(
        stream: documentsBloc.documentStream,
        builder: (BuildContext context, AsyncSnapshot<List<DocumentoModel>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.length > 0) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(10)),
                child: GridView.builder(
                  padding: EdgeInsets.all(0),
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: snapshot.data!.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 1.5,
                    crossAxisCount: 2,
                    crossAxisSpacing: ScreenUtil().setWidth(10),
                    mainAxisSpacing: ScreenUtil().setHeight(20),
                  ),
                  itemBuilder: (context, y) {
                    Random random = new Random();
                    int randomNumber = random.nextInt(4);

                    return itemDatos(snapshot.data![y], randomNumber);
                  },
                ),
              );
            } else {
              return Center(
                child: Text('No hay Documentos disponibles'),
              );
            }
          } else {
            return Center(
              child: CupertinoActivityIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget itemDatos(DocumentoModel documento, int tipo) {
    var svg = 'assets/svg/folder_azul.svg';
    Color col = Color(0xffeef7fe);
    Color colMore = Color(0xff415eb6);

    if (tipo == 0) {
      svg = 'assets/svg/folder_azul.svg';
      col = Color(0xffeef7fe);
      colMore = Color(0xff415eb6);
    } else if (tipo == 1) {
      svg = 'assets/svg/folder_amarillo.svg';
      col = Color(0xfffffbec);
      colMore = Color(0xffffb110);
    } else if (tipo == 2) {
      svg = 'assets/svg/folder_rojo.svg';
      col = Color(0xfffeeeee);
      colMore = Color(0xffac4040);
    } else if (tipo == 3) {
      svg = 'assets/svg/folder_cyan.svg';
      col = Color(0xfff0ffff);
      colMore = Color(0xff23b0b0);
    }
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        print('width ${constraints.maxWidth} --  ${ScreenUtil().setWidth(187)}');
        print('height ${constraints.maxHeight}');
        return focusGeneral(
            Container(
              decoration: BoxDecoration(
                color: col,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(10),
              ),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: [
                      Container(
                        height: ScreenUtil().setSp(45),
                        width: ScreenUtil().setSp(45),
                        child: SvgPicture.asset(
                          '$svg',
                        ),
                      ),
                      Spacer(),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.more_vert,
                          color: colMore,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(10),
                  ),
                  Text(
                    '${documento.documentoReferencia}',
                    style: TextStyle(
                      color: colMore,
                      fontWeight: FontWeight.bold,
                      fontSize: ScreenUtil().setSp(19),
                    ),
                  )
                ],
              ),
            ),
            documento);
      },
    );
  }

  FocusedMenuHolder focusGeneral(
    Widget childs,
    DocumentoModel document,
  ) {
    return FocusedMenuHolder(
        blurBackgroundColor: Colors.black.withOpacity(0.2),
        blurSize: 0,
        animateMenuItems: true,
        onPressed: () {},
        openWithTap: true,
        menuWidth: ScreenUtil().setWidth(210),
        menuItems: [
          FocusedMenuItem(
            title: Expanded(
              child: Text(
                "ver",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w400,
                  fontSize: ScreenUtil().setSp(18),
                  letterSpacing: ScreenUtil().setSp(0.016),
                  color: Colors.black,
                ),
              ),
            ),
            trailingIcon: Icon(
              Icons.edit_outlined,
              color: Colors.grey,
              size: ScreenUtil().setHeight(20),
            ),
            onPressed: () async {
              Navigator.push(
                context,
                PageRouteBuilder(
                  transitionDuration: const Duration(milliseconds: 400),
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return PdfViewer(
                      url: '$API_BASE_URL/${document.documentoArchivo}',
                    );
                  },
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                ),
              );

              //PdfViewer
            },
          ),
          FocusedMenuItem(
            title: Expanded(
              child: Text(
                "Descargar",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w400,
                  fontSize: ScreenUtil().setSp(18),
                  letterSpacing: ScreenUtil().setSp(0.016),
                  color: Colors.black,
                ),
              ),
            ),
            trailingIcon: Icon(
              Icons.insert_drive_file_sharp,
              color: Colors.grey,
              size: ScreenUtil().setHeight(20),
            ),
            onPressed: () async {
              final directory = (await getApplicationDocumentsDirectory()).path;

              options = DownloaderUtils(
                progressCallback: (current, total) {
                  final progress = (current / total) * 100;
                  print('Downloading: $progress');
                },
                file: File('$directory/${document.idDocumento}-${document.documentoArchivo}'),
                progress: ProgressImplementation(),
                onDone: () => print('COMPLETE'),
                deleteOnCancel: true,
              );
              core = await Flowder.download('$API_BASE_URL/${document.documentoArchivo}', options);

              print(core);
            },
          ),
        ],
        child: childs);
  }
}

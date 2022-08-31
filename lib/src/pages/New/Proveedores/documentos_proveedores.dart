import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:soal_app/core/util/constants.dart';
import 'package:soal_app/core/util/utils.dart';
import 'package:soal_app/src/api/pdf_api.dart';
import 'package:soal_app/src/bloc/provider_bloc.dart';
import 'package:soal_app/src/models/documento_model.dart';
import 'package:soal_app/src/models/proveedores_model.dart';
import 'package:soal_app/src/pages/New/Proveedores/upload_document.dart';
import 'package:soal_app/src/widgets/responsive.dart';

class DocumentosProveedores extends StatefulWidget {
  final ProveedorModel proveedor;
  const DocumentosProveedores({Key? key, required this.proveedor}) : super(key: key);

  @override
  _DocumentosProveedoresState createState() => _DocumentosProveedoresState();
}

class _DocumentosProveedoresState extends State<DocumentosProveedores> {
  int valor = 0;

  @override
  Widget build(BuildContext context) {
    final documentsBloc = ProviderBloc.documents(context);
    final provider = DocumentsBloc();
    if (valor == 0) {
      documentsBloc.obtenerDocumentos('1', widget.proveedor.idProveedor.toString());
      valor++;
    }
    final responsive = Responsive.of(context);
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
        actions: [
          UploadDocument(
            idProveedor: widget.proveedor.idProveedor!,
          ),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          StreamBuilder(
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

                        final fechaFormat = snapshot.data![y].documentoArchivo!.split(".");
                        var algo = fechaFormat.length - 1;

                        if (fechaFormat[algo] == 'xlsx') {
                          randomNumber = 3;
                        } else if (fechaFormat[algo] == 'pdf') {
                          randomNumber = 2;
                        }

                        return itemDatos(snapshot.data![y], randomNumber, provider);
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
          AnimatedBuilder(
            animation: provider,
            builder: (context, s) {
              return Positioned(
                bottom: 20,
                left: 0,
                right: 0,
                child: (!provider.load)
                    ? Container()
                    // : (provider.cargando == 100.0)
                    //     ? Container(
                    //         margin: EdgeInsets.symmetric(horizontal: responsive.wp(5)),
                    //         padding: EdgeInsets.symmetric(vertical: responsive.hp(.5)),
                    //         decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(10)),
                    //         child: Center(
                    //           child: Text(
                    //             'Descarga  completa',
                    //             style: TextStyle(color: Colors.white),
                    //           ),
                    //         ))
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

  Widget itemDatos(DocumentoModel documento, int tipo, DocumentsBloc provider) {
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
        return InkWell(
          onTap: () async {
            provider.changeLoad(true);
            final _apiPDF = PdfApi();
            await _apiPDF.openFile(url: '$API_BASE_URL/${documento.documentoArchivo}');

            provider.changeLoad(false);
          },
          child: Container(
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
                  '${documento.documentoTipo}',
                  style: TextStyle(
                    color: colMore,
                    fontWeight: FontWeight.w400,
                    fontSize: ScreenUtil().setSp(10),
                  ),
                ),
                Text(
                  '${documento.documentoReferencia}',
                  style: TextStyle(
                    color: colMore,
                    fontWeight: FontWeight.bold,
                    fontSize: ScreenUtil().setSp(19),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    obtenerFecha('${documento.documentoFechaSubida}'),
                    style: TextStyle(
                      color: colMore,
                      fontWeight: FontWeight.w400,
                      fontSize: ScreenUtil().setSp(10),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class DocumentsBloc extends ChangeNotifier {
  double cargando = 0.0;

  bool load = false;

  void changeLoad(bool l) {
    load = l;
    notifyListeners();
  }

  // void changeInicio() {
  //   cargando = 0.0;
  //   notifyListeners();
  // }

  // void changeFinish() {
  //   cargando = 100.0;
  //   notifyListeners();
  // }
}

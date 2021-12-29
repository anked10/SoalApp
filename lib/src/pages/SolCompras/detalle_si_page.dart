import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soal_app/core/util/utils.dart';
import 'package:soal_app/src/bloc/provider_bloc.dart';
import 'package:soal_app/src/models/detalle_si_model.dart';
import 'package:soal_app/src/models/si_model.dart';
import 'package:soal_app/src/widgets/responsive.dart';

class DetalleSiPage extends StatefulWidget {
  final SiModel simodel;
  const DetalleSiPage({Key? key, required this.simodel}) : super(key: key);

  @override
  _DetalleSiPageState createState() => _DetalleSiPageState();
}

class _DetalleSiPageState extends State<DetalleSiPage> {
  List<String> itemsCabeceraTabla = [
    'TIPO',
    'CLASE',
    'DENOMINACIÓN',
    'DESCRIPCIÓN\nPARTICULAR',
    'U.M.',
    'CANT.',
    'ESTADO',
  ];

  @override
  Widget build(BuildContext context) {
    final detalleSiBloc = ProviderBloc.detalleSi(context);
    detalleSiBloc.obtenerDetalleSi(widget.simodel.idSi.toString());

    final responsive = Responsive.of(context);
    return Scaffold(
      body: StreamBuilder(
        stream: detalleSiBloc.detalleSiStream,
        builder: (BuildContext context, AsyncSnapshot<List<DetalleSiModel>> snapshote) {
          if (snapshote.hasData) {
            if (snapshote.data!.length > 0) {
              var listOficial = snapshote.data;
              return SafeArea(
                bottom: false,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(5),
                      ),
                      child: Row(
                        children: [
                          BackButton(),
                          Expanded(
                            child: Text(
                              'Detalle',
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(22),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(width: ScreenUtil().setWidth(16)),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Solicitud N°',
                                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                              ),
                              Text('${widget.simodel.siNumero}'),
                            ],
                          ),
                        ),
                        SizedBox(width: ScreenUtil().setWidth(5)),
                        Spacer(),
                        SizedBox(width: ScreenUtil().setWidth(5)),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Fecha de aprobación',
                                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                              ),
                              Text('${widget.simodel.siDatetime}'),
                            ],
                          ),
                        ),
                        SizedBox(width: ScreenUtil().setWidth(16)),
                      ],
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(20),
                    ),
                    Row(
                      children: [
                        SizedBox(width: ScreenUtil().setWidth(16)),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Solicitante',
                                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                              ),
                              Text('${widget.simodel.personName} ${widget.simodel.personSurname}'),
                            ],
                          ),
                        ),
                        SizedBox(width: ScreenUtil().setWidth(5)),
                        Spacer(),
                        SizedBox(width: ScreenUtil().setWidth(5)),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Sede',
                                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                              ),
                              Text('${widget.simodel.sedeNombre}'),
                            ],
                          ),
                        ),
                        SizedBox(width: ScreenUtil().setWidth(16)),
                      ],
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(30),
                    ),
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: listOficial!.length + 2,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: responsive.wp(5),
                              ),
                              child: Text(
                                'Items',
                                style: TextStyle(
                                  fontSize: ScreenUtil().setSp(22),
                                  color: Colors.blue[900],
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          }

                          if (index == listOficial.length + 1) {
                            return Container(
                              child: Column(
                                children: [
                                  Text('Documentos'),
                                ],
                              ),
                            );
                          }

                          index = index - 1;
                          return CardExpandable(
                            detalleSiModel: listOficial[index],
                            index: (index + 1).toString(),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Center(
                child: Text('No hay Solicitudes de compra'),
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

  FocusedMenuHolder focusGeneral(
    Widget childs,
    List<DetalleSiModel> si,
    int index,
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
                "ver Detalles",
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
            onPressed: () async {},
          ),
        ],
        child: childs);
  }
}

class CardExpandable extends StatefulWidget {
  const CardExpandable({Key? key, required this.detalleSiModel, required this.index}) : super(key: key);

  final DetalleSiModel detalleSiModel;
  final String index;

  @override
  _CardExpandableState createState() => _CardExpandableState();
}

class _CardExpandableState extends State<CardExpandable> {
  bool expandFlag = true;
  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: responsive.hp(0),
                  horizontal: responsive.wp(2),
                ),
                child: Column(
                  children: [
                    Container(
                        padding: EdgeInsets.only(
                          top: responsive.hp(1),
                        ),
                        height: responsive.hp(7),
                        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                          Container(
                            width: responsive.wp(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Item',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: responsive.ip(1.2), color: Colors.blue[900], fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: responsive.hp(1)),
                                Text(
                                  '${widget.index}',
                                  style: TextStyle(fontSize: responsive.ip(1.5), color: Colors.black, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Text(
                              '${widget.detalleSiModel.recursoNombre}',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: ScreenUtil().setSp(19),
                                color: Colors.black,
                              ),
                            ),
                          ),
                          IconButton(
                              icon: Container(
                                height: responsive.ip(6),
                                width: responsive.ip(6),
                                decoration: BoxDecoration(
                                  color: Colors.blue[900],
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Icon(
                                    expandFlag ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  expandFlag = !expandFlag;
                                });
                              }),
                        ])),
                    ExpandableContainer(
                      expanded: expandFlag,
                      child: ListView(
                        padding: EdgeInsets.all(0),
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        children: [
                          SizedBox(
                            height: responsive.hp(2),
                          ),
                          _datosRow3(
                            responsive,
                            'Tipo:',
                            '${widget.detalleSiModel.logisticaTipoNombre}',
                            'Clase:',
                            '${widget.detalleSiModel.logisticaClaseNombre}',
                          ),
                          SizedBox(
                            height: responsive.hp(2),
                          ),
                          _datosRow3(
                            responsive,
                            'U.M.:',
                            '${widget.detalleSiModel.um}',
                            'Cantidad:',
                            '${widget.detalleSiModel.cantidad}',
                          ),
                          SizedBox(
                            height: responsive.hp(2),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Descripción particular',
                                style: TextStyle(
                                  fontSize: responsive.ip(1.8),
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFFFAA11B),
                                ),
                              ),
                              Text(
                                '${widget.detalleSiModel.descripcion}',
                                style: TextStyle(
                                  fontSize: responsive.ip(1.5),
                                  fontWeight: FontWeight.w700,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          Divider(
            color: Colors.black,
          ),
        ],
      ),
    );
  }

  Widget _datosRow3(Responsive responsive, String title, String subtitle, String title2, String subtitle2) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: responsive.wp(42.5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: responsive.ip(1.8),
                  fontWeight: FontWeight.w700,
                  color: Color(0xFFFAA11B),
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: responsive.ip(1.5),
                  fontWeight: FontWeight.w700,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: responsive.wp(5)),
        Container(
          width: responsive.wp(42.5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title2,
                style: TextStyle(
                  fontSize: responsive.ip(1.8),
                  fontWeight: FontWeight.w700,
                  color: Color(0xFFFAA11B),
                ),
              ),
              Text(
                subtitle2,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: responsive.ip(1.5),
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ExpandableContainer extends StatelessWidget {
  final bool expanded;
  final double collapsedHeight;
  final Widget? child;

  ExpandableContainer({
    @required this.child,
    this.collapsedHeight = 0.0,
    this.expanded = false,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final responsive = Responsive.of(context);
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      width: screenWidth,
      height: expanded ? responsive.hp(22) : collapsedHeight,
      child: Container(
        child: child,
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soal_app/src/bloc/provider_bloc.dart';
import 'package:soal_app/src/models/detalle_op_model.dart';
import 'package:soal_app/src/models/orden_compra_mode.dart';
import 'package:soal_app/src/pages/OrdenCompra/documentos_oc.dart';
import 'package:soal_app/src/widgets/responsive.dart';

class DetalleOpPage extends StatefulWidget {
  final OrdenCompraModel opModel;
  const DetalleOpPage({Key? key, required this.opModel}) : super(key: key);

  @override
  _DetalleOpPageState createState() => _DetalleOpPageState();
}

class _DetalleOpPageState extends State<DetalleOpPage> {
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
    final detalleOpBloc = ProviderBloc.detalleOp(context);
    detalleOpBloc.obtenerDetalleSi(widget.opModel.idOp.toString());

    final responsive = Responsive.of(context);
    return Scaffold(
      body: StreamBuilder(
        stream: detalleOpBloc.detalleOpStream,
        builder: (BuildContext context, AsyncSnapshot<List<DetalleOpModel>> snapshote) {
          if (snapshote.hasData) {
            if (snapshote.data!.length > 0) {
              var listOficial = snapshote.data;
              return SafeArea(
                bottom: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                'Proveedor',
                                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                              ),
                              Text('${widget.opModel.proveedorNombre}'),
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
                                'Ruc',
                                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                              ),
                              Text('${snapshote.data![0].proveedorRuc}'),
                            ],
                          ),
                        ),
                        SizedBox(width: ScreenUtil().setWidth(16)),
                      ],
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(20),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Dirección',
                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                          ),
                          Text('${snapshote.data![0].proveedorDireccion}'),
                        ],
                      ),
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
                                'Contacto',
                                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                              ),
                              Text('${snapshote.data![0].proveedorContacto}'),
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
                                'Teléfono',
                                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                              ),
                              Text('${snapshote.data![0].proveedorTelefono}'),
                            ],
                          ),
                        ),
                        SizedBox(width: ScreenUtil().setWidth(16)),
                      ],
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(30),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Email',
                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                          ),
                          Text('${snapshote.data![0].proveedorEmail}'),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(20),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(30),
                    ),
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: listOficial!.length + 1,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (context, animation, secondaryAnimation) {
                                          return DocumentosOC(
                                            idOp: listOficial[index].idOp.toString(),
                                          );
                                        },
                                        transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                          var begin = Offset(0.0, 1.0);
                                          var end = Offset.zero;
                                          var curve = Curves.ease;

                                          var tween = Tween(begin: begin, end: end).chain(
                                            CurveTween(curve: curve),
                                          );

                                          return SlideTransition(
                                            position: animation.drive(tween),
                                            child: child,
                                          );
                                        },
                                      ),
                                    );

                                    //DocumentosOC
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(
                                      left: ScreenUtil().setWidth(16),
                                      right: ScreenUtil().setWidth(16),
                                      bottom: ScreenUtil().setHeight(16),
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          height: ScreenUtil().setSp(35),
                                          width: ScreenUtil().setSp(35),
                                          child: SvgPicture.asset(
                                            'assets/svg/folder_amarillo.svg',
                                          ),
                                        ),
                                        Text(
                                          '  Ver documentos',
                                          style: TextStyle(
                                            fontSize: ScreenUtil().setSp(17),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
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
                                ),
                              ],
                            );
                          }

                          index = index - 1;
                          return CardExpandable(
                            detalleOpModel: listOficial[index],
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
}

class CardExpandable extends StatefulWidget {
  const CardExpandable({Key? key, required this.detalleOpModel, required this.index}) : super(key: key);

  final DetalleOpModel detalleOpModel;
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
                              '${widget.detalleOpModel.recursoNombre}',
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
                          /*  SizedBox(
                            height: responsive.hp(2),
                          ),
                          _datosRow3(
                            responsive,
                            'Tipo:',
                            '${widget.detalleOpModel.logisticaTipoNombre}',
                            'Clase:',
                            '${widget.detalleOpModel.logisticaClaseNombre}',
                          ), */
                          SizedBox(
                            height: responsive.hp(2),
                          ),
                          _datosRow3(
                            responsive,
                            'U.M.:',
                            '${widget.detalleOpModel.um}',
                            'Cantidad:',
                            '${widget.detalleOpModel.cantidad}',
                            'Precio Unit:',
                            'S/.${widget.detalleOpModel.detalleOpPrecioUnit}',
                            'Precio Total:',
                            'S/.${widget.detalleOpModel.detalleOpPrecioTotal}',
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
                                '${widget.detalleOpModel.descripcion}',
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

  Widget _datosRow3(
    Responsive responsive,
    String title,
    String subtitle,
    String title2,
    String subtitle2,
    String title3,
    String subtitle3,
    String title4,
    String subtitle4,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title3,
                style: TextStyle(
                  fontSize: responsive.ip(1.8),
                  fontWeight: FontWeight.w700,
                  color: Color(0xFFFAA11B),
                ),
              ),
              Text(
                subtitle3,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title4,
                style: TextStyle(
                  fontSize: responsive.ip(1.8),
                  fontWeight: FontWeight.w700,
                  color: Color(0xFFFAA11B),
                ),
              ),
              Text(
                subtitle4,
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
      height: expanded ? responsive.hp(15) : collapsedHeight,
      child: Container(
        child: child,
      ),
    );
  }
}

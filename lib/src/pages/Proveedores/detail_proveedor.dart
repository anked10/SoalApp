import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soal_app/src/models/proveedores_model.dart';
import 'package:soal_app/src/pages/Proveedores/editar_proveedor.dart';

class DetailProveedor extends StatefulWidget {
  final ProveedorModel proveedor;
  const DetailProveedor({Key? key, required this.proveedor}) : super(key: key);

  @override
  _DetailProveedorState createState() => _DetailProveedorState();
}

class _DetailProveedorState extends State<DetailProveedor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAF9F9),
      body: Column(
        children: [
          Container(
            child: SafeArea(
              child: Row(
                children: [
                  SizedBox(width: ScreenUtil().setWidth(10)),
                  BackButton(),
                  Expanded(
                    child: Text(
                      '${widget.proveedor.nombre}',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) {
                            return EditProvider(proveedor: widget.proveedor);
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
                    },
                    icon: Icon(Icons.edit),
                    color: Colors.black,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.delete),
                    color: Colors.black,
                  )
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: ScreenUtil().setWidth(16),
            ),
            height: ScreenUtil().setHeight(50),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.file_copy),
                  color: Colors.blue,
                ),
                Text(
                  'Ver documentos',
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(17),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Divider(),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(16),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ' Ruc',
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(19),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(6),
                    ),
                    textDato('${widget.proveedor.ruc}'),
                    SizedBox(
                      height: ScreenUtil().setHeight(20),
                    ),
                    Text(
                      ' Nombre ',
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(19),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(6),
                    ),
                    textDato('${widget.proveedor.nombre}'),
                    SizedBox(
                      height: ScreenUtil().setHeight(20),
                    ),
                    Text(
                      ' Domicilio',
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(19),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(6),
                    ),
                    textDato('${widget.proveedor.direccion}'),
                    SizedBox(
                      height: ScreenUtil().setHeight(20),
                    ),
                    Text(
                      ' Teléfono',
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(19),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(6),
                    ),
                    textDato('${widget.proveedor.telefono}'),
                    SizedBox(
                      height: ScreenUtil().setHeight(6),
                    ),
                    Text(
                      ' Estado',
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(19),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(6),
                    ),
                    ('${widget.proveedor.estado}' == '1') ? textDato('HABILITADO') : textDato('DESHABILITADO'),
                    SizedBox(
                      height: ScreenUtil().setHeight(6),
                    ),
                    Text(
                      ' Persona de contacto',
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(19),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(6),
                    ),
                    textDato('${widget.proveedor.contacto}'),
                    SizedBox(
                      height: ScreenUtil().setHeight(20),
                    ),
                    Text(
                      ' Email de contacto',
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(19),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(6),
                    ),
                    textDato('${widget.proveedor.email}'),
                    SizedBox(
                      height: ScreenUtil().setHeight(20),
                    ),
                    Text(
                      ' Clase 1',
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(19),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(6),
                    ),
                    textDato('${widget.proveedor.clase1}'),
                    SizedBox(
                      height: ScreenUtil().setHeight(20),
                    ),
                    Text(
                      ' Clase 2',
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(19),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(6),
                    ),
                    textDato('${widget.proveedor.clase2}'),
                    SizedBox(
                      height: ScreenUtil().setHeight(20),
                    ),
                    Text(
                      ' Clase 3 ',
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(19),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(6),
                    ),
                    textDato('${widget.proveedor.clase3}'),
                    SizedBox(
                      height: ScreenUtil().setHeight(20),
                    ),
                    Text(
                      ' Clase 4',
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(19),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(6),
                    ),
                    textDato('${widget.proveedor.clase4}'),
                    SizedBox(
                      height: ScreenUtil().setHeight(20),
                    ),
                    Text(
                      ' Clase 5',
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(19),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(6),
                    ),
                    textDato('${widget.proveedor.clase5}'),
                    SizedBox(
                      height: ScreenUtil().setHeight(20),
                    ),
                    Text(
                      ' Clase 6',
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(19),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(6),
                    ),
                    textDato('${widget.proveedor.clase6}'),
                    SizedBox(
                      height: ScreenUtil().setHeight(20),
                    ),
                    Text(
                      ' Banco 1',
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(19),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(6),
                    ),
                    textDato('${widget.proveedor.banco1}'),
                    SizedBox(
                      height: ScreenUtil().setHeight(20),
                    ),
                    Text(
                      ' Banco 2',
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(19),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(6),
                    ),
                    textDato('${widget.proveedor.banco2}'),
                    SizedBox(
                      height: ScreenUtil().setHeight(20),
                    ),
                    Text(
                      ' Banco 3',
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(19),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(6),
                    ),
                    textDato('${widget.proveedor.banco3}'),
                    SizedBox(
                      height: ScreenUtil().setHeight(20),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container textDato(String dato) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(10),
        vertical: ScreenUtil().setHeight(20),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              '$dato',
              style: TextStyle(
                fontSize: ScreenUtil().setSp(17),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

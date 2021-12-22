import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:soal_app/src/models/proveedores_model.dart';

class EditProvider extends StatefulWidget {
  final ProveedorModel proveedor;
  const EditProvider({Key? key, required this.proveedor}) : super(key: key);

  @override
  _EditProviderState createState() => _EditProviderState();
}

class _EditProviderState extends State<EditProvider> {
  final TextEditingController _rucController = new TextEditingController();
  final TextEditingController _nombreController = new TextEditingController();
  final TextEditingController _direccionController = new TextEditingController();
  final TextEditingController _contactoController = new TextEditingController();
  final TextEditingController _emailController = new TextEditingController();

  @override
  void dispose() {
    _rucController.dispose();
    _nombreController.dispose();
    _direccionController.dispose();
    _contactoController.dispose();
    _emailController.dispose();

    super.dispose();
  }

  initState() {
    _rucController.text = widget.proveedor.ruc.toString();
    _nombreController.text = widget.proveedor.nombre.toString();
    _direccionController.text = widget.proveedor.direccion.toString();
    _contactoController.text = widget.proveedor.contacto.toString();
    _emailController.text = widget.proveedor.email.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EditProveedorBloc>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Editar Proveedor",
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: ValueListenableBuilder(
        valueListenable: provider.page,
        builder: (BuildContext context, estadoEditProveedor data, Widget? child) {
          return Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(24)),
                height: ScreenUtil().setHeight(80),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        provider.changeToDatos();
                      },
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundColor: (data == estadoEditProveedor.datos) ? Colors.yellow.shade800 : Colors.yellow.shade800.withOpacity(0.5),
                              child: Text(
                                '1',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: ScreenUtil().setSp(19),
                                ),
                              ),
                            ),
                            Text(
                              'Datos',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: (data == estadoEditProveedor.datos) ? Colors.black : Colors.grey,
                                fontSize: ScreenUtil().setSp(16),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        provider.changeToCuenta();
                      },
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundColor:
                                  (data == estadoEditProveedor.cuenta) ? Colors.yellow.shade800 : Colors.yellow.shade800.withOpacity(0.5),
                              child: Text(
                                '2',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: ScreenUtil().setSp(19),
                                ),
                              ),
                            ),
                            Text(
                              'Cuentas',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: (data == estadoEditProveedor.cuenta) ? Colors.black : Colors.grey,
                                fontSize: ScreenUtil().setSp(16),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        provider.changeToTipos();
                      },
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundColor: (data == estadoEditProveedor.tipos) ? Colors.yellow.shade800 : Colors.yellow.shade800.withOpacity(0.5),
                              child: Text(
                                '3',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: ScreenUtil().setSp(19),
                                ),
                              ),
                            ),
                            Text(
                              'Tipos',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: (data == estadoEditProveedor.tipos) ? Colors.black : Colors.grey,
                                fontSize: ScreenUtil().setSp(16),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),

              //contenedor del medio
              (data == estadoEditProveedor.datos)
                  ? Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: ScreenUtil().setWidth(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: ScreenUtil().setHeight(10),
                              ),
                              Text(
                                ' Ruc',
                                style: TextStyle(
                                  fontSize: ScreenUtil().setSp(15),
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey[800],
                                ),
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(6),
                              ),
                              TextField(
                                controller: _rucController,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: 'RUC',
                                  hintStyle: TextStyle(
                                    fontSize: ScreenUtil().setSp(14),
                                    color: Colors.grey[600],
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.grey.shade300,
                                      width: 1.0,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.grey.shade300,
                                      width: 2.0,
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey.shade300,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                      ScreenUtil().setWidth(10),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(20),
                              ),
                              Text(
                                ' Razón Social',
                                style: TextStyle(
                                  fontSize: ScreenUtil().setSp(15),
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey[800],
                                ),
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(6),
                              ),
                              TextField(
                                controller: _nombreController,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: 'RUC',
                                  hintStyle: TextStyle(
                                    fontSize: ScreenUtil().setSp(14),
                                    color: Colors.grey[600],
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.grey.shade300,
                                      width: 1.0,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.grey.shade300,
                                      width: 2.0,
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey.shade300,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                      ScreenUtil().setWidth(10),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(20),
                              ),
                              Text(
                                ' Domicilio fiscal',
                                style: TextStyle(
                                  fontSize: ScreenUtil().setSp(15),
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey[800],
                                ),
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(6),
                              ),
                              TextField(
                                maxLines: 2,
                                controller: _direccionController,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: 'RUC',
                                  hintStyle: TextStyle(
                                    fontSize: ScreenUtil().setSp(14),
                                    color: Colors.grey[600],
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.grey.shade300,
                                      width: 1.0,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.grey.shade300,
                                      width: 2.0,
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey.shade300,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                      ScreenUtil().setWidth(10),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(20),
                              ),
                              Text(
                                ' Persona de contacto',
                                style: TextStyle(
                                  fontSize: ScreenUtil().setSp(15),
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey[800],
                                ),
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(6),
                              ),
                              TextField(
                                maxLines: 1,
                                controller: _contactoController,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: 'Persona de contacto',
                                  hintStyle: TextStyle(
                                    fontSize: ScreenUtil().setSp(14),
                                    color: Colors.grey[600],
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.grey.shade300,
                                      width: 1.0,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.grey.shade300,
                                      width: 2.0,
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey.shade300,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                      ScreenUtil().setWidth(10),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(20),
                              ),
                              Text(
                                ' Email de contacto',
                                style: TextStyle(
                                  fontSize: ScreenUtil().setSp(15),
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey[800],
                                ),
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(6),
                              ),
                              TextField(
                                maxLines: 1,
                                controller: _emailController,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: 'Persona de contacto',
                                  hintStyle: TextStyle(
                                    fontSize: ScreenUtil().setSp(14),
                                    color: Colors.grey[600],
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.grey.shade300,
                                      width: 1.0,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.grey.shade300,
                                      width: 2.0,
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey.shade300,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                      ScreenUtil().setWidth(10),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(20),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : (data == estadoEditProveedor.cuenta)
                      ? Expanded(
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: ScreenUtil().setWidth(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                   SizedBox(
                                    height: ScreenUtil().setHeight(20),
                                  ),
                                  
                                  Text(
                                    ' Entidad bancaria ',
                                    style: TextStyle(
                                      fontSize: ScreenUtil().setSp(15),
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey[800],
                                    ),
                                  ),
                                  SizedBox(
                                    height: ScreenUtil().setHeight(6),
                                  ),
                                  TextField(
                                    controller: _rucController,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText: 'RUC',
                                      hintStyle: TextStyle(
                                        fontSize: ScreenUtil().setSp(14),
                                        color: Colors.grey[600],
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Colors.grey.shade300,
                                          width: 1.0,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Colors.grey.shade300,
                                          width: 2.0,
                                        ),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.grey.shade300,
                                          width: 1.0,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                          ScreenUtil().setWidth(10),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: ScreenUtil().setHeight(20),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      : Expanded(
                          child: Container(),
                        ),

              //boton en la parte baja
              (data == estadoEditProveedor.datos)
                  ? InkWell(
                      onTap: () {
                        provider.changeToCuenta();
                      },
                      child: Container(
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(20),
                          vertical: ScreenUtil().setHeight(10),
                        ),
                        height: ScreenUtil().setHeight(50),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.purple.withOpacity(0.8),
                              spreadRadius: 0,
                              blurRadius: 24,
                              offset: Offset(0, 4), // changes position of shadow
                            ),
                          ],
                          color: Colors.purple,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            'Siguiente',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: ScreenUtil().setSp(20),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    )
                  : (data == estadoEditProveedor.cuenta)
                      ? InkWell(
                          onTap: () {
                            provider.changeToTipos();
                          },
                          child: Container(
                            width: double.infinity,
                            margin: EdgeInsets.symmetric(
                              horizontal: ScreenUtil().setWidth(20),
                              vertical: ScreenUtil().setHeight(10),
                            ),
                            height: ScreenUtil().setHeight(50),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.purple.withOpacity(0.8),
                                  spreadRadius: 0,
                                  blurRadius: 24,
                                  offset: Offset(0, 4), // changes position of shadow
                                ),
                              ],
                              color: Colors.purple,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                'Siguiente',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: ScreenUtil().setSp(20),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        )
                      : Container(
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(
                            horizontal: ScreenUtil().setWidth(20),
                            vertical: ScreenUtil().setHeight(10),
                          ),
                          height: ScreenUtil().setHeight(50),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.purple.withOpacity(0.8),
                                spreadRadius: 0,
                                blurRadius: 24,
                                offset: Offset(0, 4), // changes position of shadow
                              ),
                            ],
                            color: Colors.purple,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              'Guardar',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: ScreenUtil().setSp(20),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        )
            ],
          );
        },
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

enum estadoEditProveedor { datos, cuenta, tipos }

class EditProveedorBloc with ChangeNotifier {
  ValueNotifier<estadoEditProveedor> _page = ValueNotifier(estadoEditProveedor.datos);
  ValueNotifier<estadoEditProveedor> get page => this._page;

  BuildContext? context;

  EditProveedorBloc({this.context}) {
    _init();
  }
  void _init() {}

  void changeToDatos() {
    _page.value = estadoEditProveedor.datos;
    notifyListeners();
  }

  void changeToCuenta() {
    _page.value = estadoEditProveedor.cuenta;
    notifyListeners();
  }

  void changeToTipos() {
    _page.value = estadoEditProveedor.tipos;
    notifyListeners();
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:soal_app/src/bloc/clases_bloc.dart';
import 'package:soal_app/src/bloc/provider_bloc.dart';
import 'package:soal_app/src/models/clases_model.dart';
import 'package:soal_app/src/models/proveedores_model.dart';
import 'package:soal_app/src/pages/Proveedores/bloc_editar_proveedor.dart';

class EditProvider extends StatefulWidget {
  final ProveedorModel proveedor;
  const EditProvider({Key? key, required this.proveedor}) : super(key: key);

  @override
  _EditProviderState createState() => _EditProviderState();
}

class _EditProviderState extends State<EditProvider> {
  final TextEditingController _rucController = new TextEditingController();
  final TextEditingController _nombreController = new TextEditingController();
  final TextEditingController _telefonoController = new TextEditingController();
  final TextEditingController _direccionController = new TextEditingController();
  final TextEditingController _contactoController = new TextEditingController();
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _nroCuenta1 = new TextEditingController();
  final TextEditingController _nroCuenta2 = new TextEditingController();
  final TextEditingController _nroCuenta3 = new TextEditingController();
  final TextEditingController _cci1 = new TextEditingController();
  final TextEditingController _cci2 = new TextEditingController();
  final TextEditingController _cci3 = new TextEditingController();

  int claseInt1 = 0;
  String dropBien1 = '';
  List<String> bien1List = [];

  int claseInt2 = 0;
  String dropBien2 = '';
  List<String> bien2List = [];

  int claseInt3 = 0;
  String dropBien3 = '';
  List<String> bien3List = [];

  int claseSerInt1 = 0;
  String dropServicio1 = '';
  List<String> servicio1List = [];

  int claseSerInt2 = 0;
  String dropServicio2 = '';
  List<String> servicio2List = [];

  int claseSerInt3 = 0;
  String dropServicio3 = '';
  List<String> servicio3List = [];

  @override
  void dispose() {
    _rucController.dispose();
    _nombreController.dispose();
    _telefonoController.dispose();
    _direccionController.dispose();
    _contactoController.dispose();
    _emailController.dispose();
    _nroCuenta1.dispose();
    _nroCuenta2.dispose();
    _nroCuenta3.dispose();
    _cci1.dispose();
    _cci2.dispose();
    _cci3.dispose();

    super.dispose();
  }

  initState() {
    _rucController.text = widget.proveedor.ruc.toString();
    _nombreController.text = widget.proveedor.nombre.toString();
    _telefonoController.text = widget.proveedor.telefono.toString();
    _direccionController.text = widget.proveedor.direccion.toString();
    _contactoController.text = widget.proveedor.contacto.toString();
    dropBien1 = widget.proveedor.clase1.toString();
    dropBien2 = widget.proveedor.clase2.toString();
    dropBien3 = widget.proveedor.clase3.toString();
    dropServicio1 = widget.proveedor.clase4.toString();
    dropServicio2 = widget.proveedor.clase5.toString();
    dropServicio3 = widget.proveedor.clase6.toString();
    estadoPro = ('${widget.proveedor.estado.toString()}' == '1') ? 'HABILITADO' : 'DESHABILITADO';

    var banco1Datos = widget.proveedor.banco1.toString().split('/../');
    entidad1 = (banco1Datos.length > 0)
        ? (banco1Datos[0].trim() == '')
            ? 'Seleccione'
            : '${banco1Datos[0].trim()}'
        : '';

    moneda1 = (banco1Datos.length > 1)
        ? (banco1Datos[1].trim() == '')
            ? 'Seleccione'
            : '${banco1Datos[1].trim()}'
        : '';
    _nroCuenta1.text = (banco1Datos.length > 2) ? banco1Datos[2].trim() : '';
    _cci1.text = (banco1Datos.length > 3) ? banco1Datos[3].trim() : '';

    var banco2Datos = widget.proveedor.banco2.toString().split('/../');
    entidad2 = (banco2Datos.length > 0)
        ? (banco2Datos[0].trim() == '')
            ? 'Seleccione'
            : '${banco2Datos[0].trim()}'
        : '';
    moneda2 = (banco2Datos.length > 1)
        ? (banco2Datos[1].trim() == '')
            ? 'Seleccione'
            : '${banco2Datos[1].trim()}'
        : '';
    _nroCuenta2.text = (banco2Datos.length > 2) ? banco2Datos[2].trim() : '';
    _cci2.text = (banco2Datos.length > 3) ? banco2Datos[3].trim() : '';

    var banco3Datos = widget.proveedor.banco3.toString().split('/../');
    entidad3 = (banco3Datos.length > 0)
        ? (banco2Datos[0].trim() == '')
            ? 'Seleccione'
            : '${banco3Datos[0].trim()}'
        : '';
    moneda3 = (banco3Datos.length > 1)
        ? (banco2Datos[1].trim() == '')
            ? 'Seleccione'
            : '${banco3Datos[1].trim()}'
        : '';
    _nroCuenta3.text = (banco3Datos.length > 2) ? '${banco3Datos[2].trim()}' : '';
    _cci3.text = (banco3Datos.length > 3) ? '${banco3Datos[3].trim()}' : '';

    _emailController.text = widget.proveedor.email.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EditProveedorBloc>(context, listen: false);
    final clasesBloc = ProviderBloc.cla(context);

    clasesBloc.getClaseBien1();
    clasesBloc.getClaseBien2();
    clasesBloc.getClaseBien3();
    clasesBloc.getClaseServicio1();
    clasesBloc.getClaseServicio2();
    clasesBloc.getClaseServicio3();

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
                  ? pageDatos()
                  : (data == estadoEditProveedor.cuenta)
                      ? pageCuentas()
                      : pageTipo(clasesBloc),

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

  Widget pageTipo(ClasesBloc clase) {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ScreenUtil().setWidth(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ' Bien ',
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(22),
                  fontWeight: FontWeight.w600,
                  color: Colors.blue.shade900,
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(20),
              ),
              Text(
                ' Clase ',
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(16),
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(10),
              ),
              StreamBuilder(
                stream: clase.claseBien1,
                builder: (BuildContext context, AsyncSnapshot<List<ClasesModel>> snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.length > 0) {
                      if (claseInt1 == 0) {
                        bien1List.clear();

                        bien1List.add('Seleccionar');
                        for (int i = 0; i < snapshot.data!.length; i++) {
                          String nombreCanchas = snapshot.data![i].logisticaClaseNombre.toString();
                          bien1List.add(nombreCanchas);
                        }
                        //dropBien1 = "Seleccionar";
                      }
                      final algo = bien1List.toSet().toList();

                      return dropBien1Custom(algo, snapshot.data!);
                    } else {
                      return Container();
                    }
                  } else {
                    return Container();
                  }
                },
              ),
              SizedBox(
                height: ScreenUtil().setHeight(20),
              ),
              Text(
                ' Clase ',
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(16),
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(10),
              ),
              StreamBuilder(
                stream: clase.claseBien2,
                builder: (BuildContext context, AsyncSnapshot<List<ClasesModel>> snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.length > 0) {
                      if (claseInt2 == 0) {
                        bien2List.clear();

                        bien2List.add('Seleccionar');
                        for (int i = 0; i < snapshot.data!.length; i++) {
                          String nombreCanchas = snapshot.data![i].logisticaClaseNombre.toString();
                          bien2List.add(nombreCanchas);
                        }
                      }
                      final algo = bien2List.toSet().toList();

                      return dropBien2Custom(algo, snapshot.data!);
                    } else {
                      return Container();
                    }
                  } else {
                    return Container();
                  }
                },
              ),
              SizedBox(
                height: ScreenUtil().setHeight(20),
              ),
              Text(
                ' Clase ',
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(16),
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(10),
              ),
              StreamBuilder(
                stream: clase.claseBien3,
                builder: (BuildContext context, AsyncSnapshot<List<ClasesModel>> snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.length > 0) {
                      if (claseInt3 == 0) {
                        bien3List.clear();

                        bien3List.add('Seleccionar');
                        for (int i = 0; i < snapshot.data!.length; i++) {
                          String nombreCanchas = snapshot.data![i].logisticaClaseNombre.toString();
                          bien3List.add(nombreCanchas);
                        }
                      }
                      final algo = bien3List.toSet().toList();

                      return dropBien3Custom(algo, snapshot.data!);
                    } else {
                      return Container();
                    }
                  } else {
                    return Container();
                  }
                },
              ),
              SizedBox(
                height: ScreenUtil().setHeight(20),
              ),
              Text(
                ' Servicio ',
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(22),
                  fontWeight: FontWeight.w600,
                  color: Colors.blue.shade900,
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(20),
              ),
              Text(
                ' Clase ',
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(16),
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(10),
              ),
              StreamBuilder(
                stream: clase.claseServicio1,
                builder: (BuildContext context, AsyncSnapshot<List<ClasesModel>> snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.length > 0) {
                      if (claseSerInt1 == 0) {
                        servicio1List.clear();

                        servicio1List.add('Seleccionar');
                        for (int i = 0; i < snapshot.data!.length; i++) {
                          String nombreCanchas = snapshot.data![i].logisticaClaseNombre.toString();
                          servicio1List.add(nombreCanchas);
                        }
                      }

                      final algo = servicio1List.toSet().toList();

                      return dropService1Custom(algo, snapshot.data!);
                    } else {
                      return Container();
                    }
                  } else {
                    return Container();
                  }
                },
              ),
              SizedBox(
                height: ScreenUtil().setHeight(20),
              ),
              Text(
                ' Clase ',
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(16),
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(10),
              ),
              StreamBuilder(
                stream: clase.claseServicio2,
                builder: (BuildContext context, AsyncSnapshot<List<ClasesModel>> snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.length > 0) {
                      if (claseSerInt2 == 0) {
                        servicio2List.clear();

                        servicio2List.add('Seleccionar');
                        for (int i = 0; i < snapshot.data!.length; i++) {
                          String nombreCanchas = snapshot.data![i].logisticaClaseNombre.toString();
                          servicio2List.add(nombreCanchas);
                        }
                      }

                      final algo = servicio2List.toSet().toList();
                      return dropService2Custom(algo, snapshot.data!);
                    } else {
                      return Container();
                    }
                  } else {
                    return Container();
                  }
                },
              ),
              SizedBox(
                height: ScreenUtil().setHeight(20),
              ),
              Text(
                ' Clase ',
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(16),
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(10),
              ),
              StreamBuilder(
                stream: clase.claseServicio3,
                builder: (BuildContext context, AsyncSnapshot<List<ClasesModel>> snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.length > 0) {
                      if (claseSerInt3 == 0) {
                        servicio3List.clear();

                        servicio3List.add('Seleccionar');
                        for (int i = 0; i < snapshot.data!.length; i++) {
                          String nombreCanchas = snapshot.data![i].logisticaClaseNombre.toString();
                          servicio3List.add(nombreCanchas);
                        }
                      }

                      final algo = servicio3List.toSet().toList();
                      return dropService3Custom(algo, snapshot.data!);
                    } else {
                      return Container();
                    }
                  } else {
                    return Container();
                  }
                },
              ),
              SizedBox(
                height: ScreenUtil().setHeight(20),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget pageDatos() {
    return Expanded(
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
                  fontSize: ScreenUtil().setSp(16),
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
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
                  fontSize: ScreenUtil().setSp(16),
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
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
                ' Teléfono',
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(16),
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(6),
              ),
              TextField(
                controller: _telefonoController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Teléfono',
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
                ' ESTADO ',
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(16),
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(6),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(10),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: DropdownButton(
                    underline: Container(),
                    isExpanded: true,
                    value: estadoPro,
                    onChanged: (String? newValue) {
                      setState(() {
                        estadoPro = newValue!;
                      });
                    },
                    items: dropDownestado),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(20),
              ),
              Text(
                ' Domicilio fiscal',
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(16),
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
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
                  fontSize: ScreenUtil().setSp(16),
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
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
                  fontSize: ScreenUtil().setSp(16),
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
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
    );
  }

  Widget pageCuentas() {
    return Expanded(
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
                ' Banco 1 ',
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(22),
                  fontWeight: FontWeight.w600,
                  color: Colors.blue.shade900,
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(10),
              ),
              Text(
                ' Entidad bancaria ',
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(16),
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(6),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(10),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: DropdownButton(
                    underline: Container(),
                    isExpanded: true,
                    value: entidad1,
                    onChanged: (String? newValue) {
                      setState(() {
                        entidad1 = newValue!;
                      });
                    },
                    items: dropdownItems),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(20),
              ),
              Text(
                ' Moneda ',
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(16),
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(6),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(10),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: DropdownButton(
                    underline: Container(),
                    isExpanded: true,
                    value: moneda1,
                    onChanged: (String? newValue) {
                      setState(() {
                        moneda1 = newValue!;
                      });
                    },
                    items: dropdownMoneda1),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(20),
              ),
              Text(
                ' Nro de cuenta ',
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(16),
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(6),
              ),
              TextField(
                controller: _nroCuenta1,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: ' Nro de cuenta ',
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
                ' CCI ',
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(16),
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(10),
              ),
              TextField(
                controller: _cci1,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'CCI',
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
              Divider(),
              SizedBox(
                height: ScreenUtil().setHeight(20),
              ),
              Text(
                ' Banco 2 ',
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(22),
                  fontWeight: FontWeight.w600,
                  color: Colors.blue.shade900,
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(10),
              ),
              Text(
                ' Entidad bancaria ',
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(16),
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(6),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(10),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: DropdownButton(
                    underline: Container(),
                    isExpanded: true,
                    value: entidad2,
                    onChanged: (String? newValue) {
                      setState(() {
                        entidad2 = newValue!;
                      });
                    },
                    items: dropdownItems),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(20),
              ),
              Text(
                ' Moneda ',
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(16),
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(6),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(10),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: DropdownButton(
                    underline: Container(),
                    isExpanded: true,
                    value: moneda2,
                    onChanged: (String? newValue) {
                      setState(() {
                        moneda2 = newValue!;
                      });
                    },
                    items: dropdownMoneda1),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(20),
              ),
              Text(
                ' Nro de cuenta ',
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(16),
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(6),
              ),
              TextField(
                controller: _nroCuenta2,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: ' Nro de cuenta ',
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
                ' CCI ',
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(16),
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(6),
              ),
              TextField(
                controller: _cci2,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'CCI',
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
              Divider(),
              SizedBox(
                height: ScreenUtil().setHeight(20),
              ),
              Text(
                ' Banco 3 ',
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(22),
                  fontWeight: FontWeight.w600,
                  color: Colors.blue.shade900,
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(10),
              ),
              Text(
                ' Entidad bancaria ',
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(16),
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(6),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(10),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: DropdownButton(
                    underline: Container(),
                    isExpanded: true,
                    value: entidad3,
                    onChanged: (String? newValue) {
                      setState(() {
                        entidad3 = newValue!;
                      });
                    },
                    items: dropdownItems),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(20),
              ),
              Text(
                ' Moneda ',
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(16),
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(6),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(10),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: DropdownButton(
                    underline: Container(),
                    isExpanded: true,
                    value: moneda3,
                    onChanged: (String? newValue) {
                      setState(() {
                        moneda3 = newValue!;
                      });
                    },
                    items: dropdownItems),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(20),
              ),
              Text(
                ' Nro de cuenta ',
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(16),
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(6),
              ),
              TextField(
                controller: _nroCuenta3,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: ' Nro de cuenta ',
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
                ' CCI ',
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(16),
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(6),
              ),
              TextField(
                controller: _cci3,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'CCI',
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

  Widget dropBien1Custom(List<String> lista, List<ClasesModel> ciudades) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(5),
      ),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          border: Border.all(
            color: Colors.grey.shade300,
          )),
      child: DropdownButton<String>(
        dropdownColor: Colors.white,
        value: dropBien1,
        icon: Icon(Icons.arrow_drop_down),
        iconSize: ScreenUtil().setSp(20),
        elevation: 16,
        isExpanded: true,
        style: TextStyle(
          color: Colors.black,
          fontSize: ScreenUtil().setSp(16),
        ),
        underline: Container(),
        onChanged: (String? data) {
          setState(() {
            dropBien1 = data.toString();
            claseInt1++;

            //obtenerIdNegocios(data, ciudades);
          });
        },
        items: lista.map((value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              maxLines: 3,
              style: TextStyle(color: Colors.black),
              overflow: TextOverflow.ellipsis,
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget dropBien2Custom(List<String> lista, List<ClasesModel> ciudades) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(5),
      ),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          border: Border.all(
            color: Colors.grey.shade300,
          )),
      child: DropdownButton<String>(
        dropdownColor: Colors.white,
        value: dropBien2,
        icon: Icon(Icons.arrow_drop_down),
        iconSize: ScreenUtil().setSp(20),
        elevation: 16,
        isExpanded: true,
        style: TextStyle(
          color: Colors.black,
          fontSize: ScreenUtil().setSp(16),
        ),
        underline: Container(),
        onChanged: (String? data) {
          setState(() {
            dropBien2 = data.toString();
            claseInt2++;

            //obtenerIdNegocios(data, ciudades);
          });
        },
        items: lista.map((value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              maxLines: 3,
              style: TextStyle(color: Colors.black),
              overflow: TextOverflow.ellipsis,
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget dropBien3Custom(List<String> lista, List<ClasesModel> ciudades) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(5),
      ),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          border: Border.all(
            color: Colors.grey.shade300,
          )),
      child: DropdownButton<String>(
        dropdownColor: Colors.white,
        value: dropBien3,
        icon: Icon(Icons.arrow_drop_down),
        iconSize: ScreenUtil().setSp(20),
        elevation: 16,
        isExpanded: true,
        style: TextStyle(
          color: Colors.black,
          fontSize: ScreenUtil().setSp(16),
        ),
        underline: Container(),
        onChanged: (String? data) {
          setState(() {
            dropBien3 = data.toString();
            claseInt3++;

            //obtenerIdNegocios(data, ciudades);
          });
        },
        items: lista.map((value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              maxLines: 3,
              style: TextStyle(color: Colors.black),
              overflow: TextOverflow.ellipsis,
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget dropService1Custom(List<String> lista, List<ClasesModel> ciudades) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(5),
      ),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          border: Border.all(
            color: Colors.grey.shade300,
          )),
      child: DropdownButton<String>(
        dropdownColor: Colors.white,
        value: dropServicio1,
        icon: Icon(Icons.arrow_drop_down),
        iconSize: ScreenUtil().setSp(20),
        elevation: 16,
        isExpanded: true,
        style: TextStyle(
          color: Colors.black,
          fontSize: ScreenUtil().setSp(16),
        ),
        underline: Container(),
        onChanged: (String? data) {
          setState(() {
            dropServicio1 = data.toString();
            claseSerInt1++;

            //obtenerIdNegocios(data, ciudades);
          });
        },
        items: lista.map((value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              maxLines: 3,
              style: TextStyle(color: Colors.black),
              overflow: TextOverflow.ellipsis,
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget dropService2Custom(List<String> lista, List<ClasesModel> ciudades) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(5),
      ),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          border: Border.all(
            color: Colors.grey.shade300,
          )),
      child: DropdownButton<String>(
        dropdownColor: Colors.white,
        value: dropServicio2,
        icon: Icon(Icons.arrow_drop_down),
        iconSize: ScreenUtil().setSp(20),
        elevation: 16,
        isExpanded: true,
        style: TextStyle(
          color: Colors.black,
          fontSize: ScreenUtil().setSp(16),
        ),
        underline: Container(),
        onChanged: (String? data) {
          setState(() {
            dropServicio2 = data.toString();
            claseSerInt2++;

            //obtenerIdNegocios(data, ciudades);
          });
        },
        items: lista.map((value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              maxLines: 3,
              style: TextStyle(color: Colors.black),
              overflow: TextOverflow.ellipsis,
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget dropService3Custom(List<String> lista, List<ClasesModel> ciudades) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(5),
      ),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          border: Border.all(
            color: Colors.grey.shade300,
          )),
      child: DropdownButton<String>(
        dropdownColor: Colors.white,
        value: dropServicio3,
        icon: Icon(Icons.arrow_drop_down),
        iconSize: ScreenUtil().setSp(20),
        elevation: 16,
        isExpanded: true,
        style: TextStyle(
          color: Colors.black,
          fontSize: ScreenUtil().setSp(16),
        ),
        underline: Container(),
        onChanged: (String? data) {
          setState(() {
            dropServicio3 = data.toString();
            claseSerInt3++;

            //obtenerIdNegocios(data, ciudades);
          });
        },
        items: lista.map((value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              maxLines: 3,
              style: TextStyle(color: Colors.black),
              overflow: TextOverflow.ellipsis,
            ),
          );
        }).toList(),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:soal_app/core/database/clases_database.dart';
import 'package:soal_app/core/util/utils.dart';
import 'package:soal_app/src/api/proveedores_api.dart';
import 'package:soal_app/src/bloc/clases_bloc.dart';
import 'package:soal_app/src/bloc/provider_bloc.dart';
import 'package:soal_app/src/models/clases_model.dart';
import 'package:soal_app/src/models/proveedores_model.dart';
import 'package:soal_app/src/pages/Proveedores/bloc_editar_proveedor.dart';

class AddProvider extends StatefulWidget {
  const AddProvider({
    Key? key,
  }) : super(key: key);

  @override
  _AddProviderState createState() => _AddProviderState();
}

class _AddProviderState extends State<AddProvider> {
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
  String dropBien1 = 'Seleccionar';
  List<String> bien1List = [];

  int claseInt2 = 0;
  String dropBien2 = 'Seleccionar';
  List<String> bien2List = [];

  int claseInt3 = 0;
  String dropBien3 = 'Seleccionar';
  List<String> bien3List = [];

  int claseSerInt1 = 0;
  String dropServicio1 = 'Seleccionar';
  List<String> servicio1List = [];

  int claseSerInt2 = 0;
  String dropServicio2 = 'Seleccionar';
  List<String> servicio2List = [];

  int claseSerInt3 = 0;
  String dropServicio3 = 'Seleccionar';
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
        centerTitle: false,
        title: Text(
          "Nuevo Proveedor",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: ScreenUtil().setSp(28),
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: ValueListenableBuilder(
        valueListenable: provider.page,
        builder: (BuildContext context, estadoEditProveedor data, Widget? child) {
          return Stack(
            children: [
              Column(
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
                            padding: EdgeInsets.symmetric(
                              horizontal: ScreenUtil().setWidth(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  backgroundColor:
                                      (data == estadoEditProveedor.datos) ? Colors.yellow.shade800 : Colors.yellow.shade800.withOpacity(0.5),
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
                        Expanded(
                          child: Container(
                            height: ScreenUtil().setHeight(80),
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.yellow.shade800,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  margin: EdgeInsets.only(
                                    top: ScreenUtil().setHeight(30),
                                  ),
                                  height: ScreenUtil().setHeight(10),
                                ),
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
                        Expanded(
                          child: Container(
                            height: ScreenUtil().setHeight(80),
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.yellow.shade800,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  margin: EdgeInsets.only(
                                    top: ScreenUtil().setHeight(30),
                                  ),
                                  height: ScreenUtil().setHeight(10),
                                ),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            provider.changeToTipos();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: ScreenUtil().setWidth(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  backgroundColor:
                                      (data == estadoEditProveedor.tipos) ? Colors.yellow.shade800 : Colors.yellow.shade800.withOpacity(0.5),
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
                          : InkWell(
                              onTap: () async {
                                provider.cargando.value = true;
                                String clase1Dato = '0';
                                String clase2Dato = '0';
                                String clase3Dato = '0';
                                String clase4Dato = '0';
                                String clase5Dato = '0';
                                String clase6Dato = '0';

                                final proveedorApi = ProveedoresApi();

                                final clasesDatabase = ClasesDatabase();
                                if (dropBien1 != 'Seleccione') {
                                  var clase1 = await clasesDatabase.getClasesForName(dropBien1);
                                  if (clase1.length > 0) {
                                    clase1Dato = clase1[0].idLogisticaClase.toString();
                                  }
                                }

                                if (dropBien2 != 'Seleccione') {
                                  var clase2 = await clasesDatabase.getClasesForName(dropBien2);
                                  if (clase2.length > 0) {
                                    clase2Dato = clase2[0].idLogisticaClase.toString();
                                  }
                                }

                                if (dropBien3 != 'Seleccione') {
                                  var clase3 = await clasesDatabase.getClasesForName(dropBien3);
                                  if (clase3.length > 0) {
                                    clase3Dato = clase3[0].idLogisticaClase.toString();
                                  }
                                }

                                if (dropServicio1 != 'Seleccione') {
                                  var claseServicio1 = await clasesDatabase.getClasesForName(dropServicio1);
                                  if (claseServicio1.length > 0) {
                                    clase4Dato = claseServicio1[0].idLogisticaClase.toString();
                                  }
                                }

                                if (dropServicio2 != 'Seleccione') {
                                  var claseServicio2 = await clasesDatabase.getClasesForName(dropServicio2);
                                  if (claseServicio2.length > 0) {
                                    clase5Dato = claseServicio2[0].idLogisticaClase.toString();
                                  }
                                }

                                if (dropServicio3 != 'Seleccione') {
                                  var claseServicio3 = await clasesDatabase.getClasesForName(dropServicio3);
                                  if (claseServicio3.length > 0) {
                                    clase6Dato = claseServicio3[0].idLogisticaClase.toString();
                                  }
                                }

                                ProveedorModel proveedor = ProveedorModel();

                                proveedor.nombre = _nombreController.text;
                                proveedor.ruc = _rucController.text;
                                proveedor.estado = (estadoPro == 'HABILITADO') ? '1' : '0';
                                proveedor.telefono = _telefonoController.text;
                                proveedor.contacto = _contactoController.text;
                                proveedor.email = _emailController.text;
                                proveedor.direccion = _direccionController.text;
                                proveedor.banco1 = '$entidad1/../$moneda1/../${_nroCuenta1.text}/../${_cci1.text}';
                                proveedor.banco2 = '$entidad2/../$moneda2/../${_nroCuenta2.text}/../${_cci2.text}';
                                proveedor.banco3 = '$entidad3/../$moneda3/../${_nroCuenta3.text}/../${_cci3.text}';

                                proveedor.clase1 = '$clase1Dato';
                                proveedor.clase2 = '$clase2Dato';
                                proveedor.clase3 = '$clase3Dato';
                                proveedor.clase4 = '$clase4Dato';
                                proveedor.clase5 = '$clase5Dato';
                                proveedor.clase6 = '$clase6Dato';

                                final res = await proveedorApi.addProvider(proveedor);

                                if (res.code == 1) {
                                  showToast2('${res.message}', Colors.green);
                                  final proveedoresBloc = ProviderBloc.provee(context);
                                  proveedoresBloc.obtenerProveedores();
                                } else {
                                  showToast2('${res.message}', Colors.red);
                                }

                                provider.cargando.value = false;
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
                                    'Guardar',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: ScreenUtil().setSp(20),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            )
                ],
              ),
              ValueListenableBuilder(
                valueListenable: provider.cargando,
                builder: (BuildContext context, bool data, Widget? child) {
                  return (data) ? _mostrarAlert() : Container();
                },
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _mostrarAlert() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Color.fromRGBO(0, 0, 0, 0.5),
      child: Center(
        child: CupertinoActivityIndicator(),
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
                  hintText: 'Razón Social',
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
                  hintText: 'Domicilio',
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
                  hintText: 'Email de contacto',
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

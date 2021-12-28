import 'package:flutter/material.dart';

String entidad1 = "Seleccione";

List<DropdownMenuItem<String>> get dropdownItems {
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(child: Text("Seleccione"), value: "Seleccione"),
    DropdownMenuItem(child: Text("BANBIF"), value: "BANBIF"),
    DropdownMenuItem(child: Text("BANCO DE COMERCIO"), value: "BANCO DE COMERCIO"),
    DropdownMenuItem(child: Text("BANCO DE LA NACION"), value: "BANCO DE LA NACION"),
    DropdownMenuItem(child: Text("BANCO FALABELLA"), value: "BANCO FALABELLA"),
    DropdownMenuItem(child: Text("BANCO PICHINCHA"), value: "BANCO PICHINCHA"),
    DropdownMenuItem(child: Text("BANCO GNB"), value: "ANCO GNB"),
    DropdownMenuItem(child: Text("BANCO CONTINENTAL"), value: "BANCO CONTINENTAL"),
    DropdownMenuItem(child: Text("BANCO DE CREDITO"), value: "BANCO DE CREDITO"),
    DropdownMenuItem(child: Text("CAJA AREQUIPA"), value: "CAJA AREQUIPA"),
    DropdownMenuItem(child: Text("CAJA CUSCO"), value: "CAJA CUSCO"),
    DropdownMenuItem(child: Text("CAJA PIURA"), value: "CAJA PIURA"),
    DropdownMenuItem(child: Text("CAJA SULLANA"), value: "CAJA SULLANA"),
    DropdownMenuItem(child: Text("CAJA TRUJILLO"), value: "CAJA TRUJILLO"),
    DropdownMenuItem(child: Text("CITIBANK"), value: "CITIBANK"),
    DropdownMenuItem(child: Text("CREDISCOTIA"), value: "CREDISCOTIA"),
    DropdownMenuItem(child: Text("INTERBANK"), value: "INTERBANK"),
    DropdownMenuItem(child: Text("MIBANCO"), value: "MIBANCO"),
    DropdownMenuItem(child: Text("SCOTIABANK"), value: "SCOTIABANK"),
    DropdownMenuItem(child: Text("EFECTIVO"), value: "EFECTIVO"),
  ];
  return menuItems;
}

String entidad2 = "Seleccione";
String entidad3 = "Seleccione";
String moneda1 = "Seleccione";
List<DropdownMenuItem<String>> get dropdownMoneda1 {
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(child: Text("Seleccione"), value: "Seleccione"),
    DropdownMenuItem(child: Text("SOLES"), value: "SOLES"),
    DropdownMenuItem(child: Text("DOLARES"), value: "DOLARES"),
  ];
  return menuItems;
}

String moneda2 = "Seleccione";
String moneda3 = "Seleccione";


String estadoPro = "Seleccione";
List<DropdownMenuItem<String>> get dropDownestado {
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(child: Text("HABILITADO"), value: "HABILITADO"),
    DropdownMenuItem(child: Text("DESHABILITADO"), value: "DESHABILITADO"),
    DropdownMenuItem(child: Text("Seleccione"), value: "Seleccione"),
  ];
  return menuItems;
}

enum estadoEditProveedor { datos, cuenta, tipos }

class EditProveedorBloc with ChangeNotifier {
  ValueNotifier<estadoEditProveedor> _page = ValueNotifier(estadoEditProveedor.datos);
  ValueNotifier<estadoEditProveedor> get page => this._page;


   ValueNotifier<bool> _cargando = ValueNotifier(false);
  ValueNotifier<bool> get cargando => this._cargando;

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
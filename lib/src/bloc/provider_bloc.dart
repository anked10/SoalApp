
import 'package:flutter/material.dart';
import 'package:soal_app/src/bloc/busqueda_proveedor_bloc.dart';
import 'package:soal_app/src/bloc/clases_bloc.dart';
import 'package:soal_app/src/bloc/proveedoresBloc.dart';

//singleton para obtner una unica instancia del Bloc
class ProviderBloc extends InheritedWidget {
  

  final proveedoresBloc = ProveedoresBloc();
  final busquedaProveedorBloc = BusquedaProveedorBloc();
  final clasesBloc = ClasesBloc();

 
  ProviderBloc({required Widget child}) : super(child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static ProveedoresBloc provee(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<ProviderBloc>())!.proveedoresBloc;
  }

  static BusquedaProveedorBloc busPro(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<ProviderBloc>())!.busquedaProveedorBloc;
  }

  static ClasesBloc cla(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<ProviderBloc>())!.clasesBloc;
  }
}
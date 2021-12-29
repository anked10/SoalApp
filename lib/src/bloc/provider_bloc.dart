
import 'package:flutter/material.dart';
import 'package:soal_app/src/bloc/almacen_bloc.dart';
import 'package:soal_app/src/bloc/busqueda_proveedor_bloc.dart';
import 'package:soal_app/src/bloc/clases_bloc.dart';
import 'package:soal_app/src/bloc/detalle_si_bloc.dart';
import 'package:soal_app/src/bloc/documentos_bloc.dart';
import 'package:soal_app/src/bloc/proveedoresBloc.dart';
import 'package:soal_app/src/bloc/si_bloc.dart';

//singleton para obtner una unica instancia del Bloc
class ProviderBloc extends InheritedWidget {
  

  final proveedoresBloc = ProveedoresBloc();
  final busquedaProveedorBloc = BusquedaProveedorBloc();
  final clasesBloc = ClasesBloc();
  final siBloc = SiBloc();
  final detalleSiBloc = DetalleSiBloc();
  final almacenBloc = AlmacenBloc();
  final documentosBloc = DocumentosBloc();

 
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

  static SiBloc si(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<ProviderBloc>())!.siBloc;
  }

  static DetalleSiBloc detalleSi(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<ProviderBloc>())!.detalleSiBloc;
  }

  static AlmacenBloc almacen(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<ProviderBloc>())!.almacenBloc;
  }

  static DocumentosBloc documents(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<ProviderBloc>())!.documentosBloc;
  }
}
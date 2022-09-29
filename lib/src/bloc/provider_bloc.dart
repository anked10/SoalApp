import 'package:flutter/material.dart';
import 'package:soal_app/src/bloc/almacen_bloc.dart';
import 'package:soal_app/src/bloc/busqueda_proveedor_bloc.dart';
import 'package:soal_app/src/bloc/clases_bloc.dart';
import 'package:soal_app/src/bloc/data_user.dart';
import 'package:soal_app/src/bloc/detalle_op_bloc.dart';
import 'package:soal_app/src/bloc/detalle_si_bloc.dart';
import 'package:soal_app/src/bloc/documento_oc_bloc.dart';
import 'package:soal_app/src/bloc/documentos_bloc.dart';
import 'package:soal_app/src/bloc/gestion_pagos_bloc.dart';
import 'package:soal_app/src/bloc/modulos_bloc.dart';
import 'package:soal_app/src/bloc/orden_compra_bloc.dart';
import 'package:soal_app/src/bloc/ot_bloc.dart';
import 'package:soal_app/src/bloc/proveedoresBloc.dart';
import 'package:soal_app/src/bloc/qhse_bloc.dart';
import 'package:soal_app/src/bloc/request_bloc.dart';
import 'package:soal_app/src/bloc/si_bloc.dart';

//singleton para obtner una unica instancia del Bloc
class ProviderBloc extends InheritedWidget {
  final modulosBloc = ModulosBloc();
  final proveedoresBloc = ProveedoresBloc();
  final busquedaProveedorBloc = BusquedaProveedorBloc();
  final clasesBloc = ClasesBloc();
  final siBloc = SiBloc();
  final detalleSiBloc = DetalleSiBloc();
  final almacenBloc = AlmacenBloc();
  final documentosBloc = DocumentosBloc();
  final dataUserBloc = DataUserBloc();
  final ordenCompraBloc = OrdenCompraBloc();
  final detalleOpBloc = DetalleOpBloc();
  final documentoOCBloc = DocumentoOCBloc();
  final otBloc = OTBloc();
  final gestionPagosBloc = GestionPagosBloc();
  final requestBloc = RequestBloc();
  final incidenciasBloc = QHSEBloc();

  ProviderBloc({required Widget child}) : super(child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static ProveedoresBloc provee(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<ProviderBloc>())!.proveedoresBloc;
  }

  static ModulosBloc modulo(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<ProviderBloc>())!.modulosBloc;
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

  static DataUserBloc data(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<ProviderBloc>())!.dataUserBloc;
  }

  static OrdenCompraBloc op(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<ProviderBloc>())!.ordenCompraBloc;
  }

  static DetalleOpBloc detalleOp(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<ProviderBloc>())!.detalleOpBloc;
  }

  static DocumentoOCBloc docOC(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<ProviderBloc>())!.documentoOCBloc;
  }

  static OTBloc ot(BuildContext context) {
    return (context.findAncestorWidgetOfExactType<ProviderBloc>())!.otBloc;
  }

  static GestionPagosBloc gestionPagos(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<ProviderBloc>())!.gestionPagosBloc;
  }

  static RequestBloc requerimets(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<ProviderBloc>())!.requestBloc;
  }

  static QHSEBloc incidencias(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<ProviderBloc>())!.incidenciasBloc;
  }
}

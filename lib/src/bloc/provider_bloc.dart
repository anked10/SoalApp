
import 'package:flutter/material.dart';
import 'package:soal_app/src/bloc/proveedoresBloc.dart';

//singleton para obtner una unica instancia del Bloc
class ProviderBloc extends InheritedWidget {
  

  final proveedoresBloc = ProveedoresBloc();

 
  ProviderBloc({required Widget child}) : super(child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static ProveedoresBloc provee(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<ProviderBloc>())!.proveedoresBloc;
  }
}
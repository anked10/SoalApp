import 'package:flutter/material.dart';
import 'package:soal_app/src/bloc/provider_bloc.dart';
import 'package:soal_app/src/models/proveedores_model.dart';

class ProveedoresPage extends StatelessWidget {
  const ProveedoresPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final proveedoresBloc = ProviderBloc.provee(context);
    proveedoresBloc.obtenerProveedores();

    return Scaffold(
      body: StreamBuilder(
        stream: proveedoresBloc.proveedoresStream,
        builder: (BuildContext context, AsyncSnapshot<List<ProveedorModel>> snapshot) {
          return Container();
        },
      ),
    );
  }
}

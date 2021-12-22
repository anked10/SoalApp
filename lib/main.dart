import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:soal_app/core/util/constants.dart';
import 'package:soal_app/core/util/router.dart';
import 'package:soal_app/src/bloc/provider_bloc.dart';
import 'package:soal_app/src/pages/Proveedores/busqueda_proveedores.dart';
import 'package:soal_app/src/pages/Proveedores/editar_proveedor.dart';
import 'package:soal_app/src/pages/home_page.dart';
import 'injection_container.dart' as di;

void main() async {
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ProviderBloc(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<ChangeBottomExplorer>(
            create: (_) => ChangeBottomExplorer(),
          ),
          ChangeNotifierProvider<EstadoListener>(
            create: (_) => EstadoListener(),
          ),
          ChangeNotifierProvider<EditProveedorBloc>(
            create: (_) => EditProveedorBloc(),
          ),
        ],
        child: ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: () => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Bufi',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            onGenerateRoute: Routers.generateRoute,
            initialRoute: SPLASH_ROUTE,
          ),
        ),
      ),
    );
  }
}

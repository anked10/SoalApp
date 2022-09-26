import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:soal_app/core/util/constants.dart';
import 'package:soal_app/core/util/router.dart';
import 'package:soal_app/src/bloc/provider_bloc.dart';
import 'package:soal_app/src/pages/Almacen/busqueda_almacen.dart';
import 'package:soal_app/src/pages/Inicio%20Menu%20Roles/home_gerencia.dart';
// import 'package:soal_app/src/pages/OrdenCompra/documentos_oc.dart';
import 'package:soal_app/src/pages/Proveedores/bloc_editar_proveedor.dart';
import 'package:soal_app/src/pages/Proveedores/busqueda_proveedores.dart';
import 'package:soal_app/src/pages/Proveedores/documentos_proveedor.dart';
// import 'package:soal_app/src/pages/SolCompras/documentos_solicitud.dart';
// import 'package:soal_app/src/pages/SolCompras/nuevo_documento.dart';
// import 'package:soal_app/src/pages/home_page.dart';
// import 'core/config/colors.dart';
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
          // ChangeNotifierProvider<ChangeBottomExplorer>(
          //   create: (_) => ChangeBottomExplorer(),
          // ),
          ChangeNotifierProvider<ChangeBottom>(
            create: (_) => ChangeBottom(),
          ),
          ChangeNotifierProvider<EstadoListener>(
            create: (_) => EstadoListener(),
          ),
          ChangeNotifierProvider<EstadoListenerAlmacen>(
            create: (_) => EstadoListenerAlmacen(),
          ),
          ChangeNotifierProvider<DocumentsBloc>(
            create: (_) => DocumentsBloc(),
          ),
          // ChangeNotifierProvider<UploapBloc>(
          //   create: (_) => UploapBloc(),
          // ),
          // ChangeNotifierProvider<DocumentsSolicitudBloc>(
          //   create: (_) => DocumentsSolicitudBloc(),
          // ),
          // ChangeNotifierProvider<DocumentsOCBloc>(
          //   create: (_) => DocumentsOCBloc(),
          // ),
          ChangeNotifierProvider<EditProveedorBloc>(
            create: (_) => EditProveedorBloc(),
          ),
        ],
        child: ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: (_, w) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Soal',
            theme: ThemeData(
              primarySwatch: Colors.indigo,
              unselectedWidgetColor: Colors.indigo,
            ),
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('es'),
              Locale('es', 'ES'), // Spanish, no country code
              //const Locale('en', 'EN'), // English, no country code
            ],
            onGenerateRoute: Routers.generateRoute,
            initialRoute: SPLASH_ROUTE,
          ),
        ),
      ),
    );
  }
}

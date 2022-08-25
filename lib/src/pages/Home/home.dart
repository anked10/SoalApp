import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:soal_app/src/pages/Home/menu.dart';
import 'package:soal_app/src/pages/New/Almacen/stock_almacen.dart';
import 'package:soal_app/src/pages/New/Proveedores/proveedores.dart';
import 'package:soal_app/src/pages/default_page.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String itemSeleccionado = '';
  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      borderRadius: 24,
      slideWidth: MediaQuery.of(context).size.width * 0.85,
      showShadow: true,
      angle: 0.0,
      drawerShadowsBackgroundColor: Colors.indigo[300]!,
      menuBackgroundColor: Colors.white,
      mainScreenTapClose: true,
      //style: DrawerStyle.style1,
      menuScreen: Builder(
        builder: (context) => Menu(
          itemSeleccionado: itemSeleccionado,
          onSelectItem: (item) {
            setState(
              () {
                itemSeleccionado = item;
                ZoomDrawer.of(context)!.close();
              },
            );
          },
        ),
      ),
      mainScreen: obtenerPage(),
    );
  }

  Widget obtenerPage() {
    switch (itemSeleccionado) {
      case '23':
        return const Proveedores();
      case '44':
        return const StockAlmacen();
      default:
        return const DefaultPage();
    }
  }
}

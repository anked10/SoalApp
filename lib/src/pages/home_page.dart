import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:soal_app/core/config/colors.dart';
import 'package:soal_app/src/pages/Almacen/almacen_page.dart';
import 'package:soal_app/src/pages/Cuenta/cuenta_page.dart';
import 'package:soal_app/src/pages/OrdenCompra/orden_compra.dart';
import 'package:soal_app/src/pages/Proveedores/proveedores_page.dart';
import 'package:soal_app/src/pages/SolCompras/solCompras_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> pageList = [];

  @override
  void initState() {
    pageList.add(ProveedoresPage());
    pageList.add(AlmacenPage());
    pageList.add(SolComprasPage());
    pageList.add(OrdenCompraPage());
    pageList.add(CuentaPage());
    //pageList.add(UserPage());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ChangeBottomExplorer>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      body: ValueListenableBuilder<int>(
        valueListenable: provider._pagina,
        builder: (_, value, __) {
          return Stack(
            children: [
              Container(
                padding: EdgeInsets.only(
                  bottom:
                      kBottomNavigationBarHeight + ScreenUtil().setHeight(25),
                ),
                child: IndexedStack(
                  index: value,
                  children: pageList,
                ),
              ),
              Positioned(
                bottom: 00,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.only(
                    left: ScreenUtil().setWidth(10),
                    right: ScreenUtil().setWidth(10),
                    bottom: ScreenUtil().setHeight(20),
                  ),
                  height:
                      kBottomNavigationBarHeight + ScreenUtil().setHeight(25),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.transparent.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: Offset(0, 1), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          provider.changePage(0);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: ScreenUtil().setHeight(25),
                              width: ScreenUtil().setHeight(25),
                              child: SvgPicture.asset(
                                'assets/svg/proveedores.svg',
                                color:
                                    (value == 0) ? tabSelected : tabNoSelected,
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Proveedores',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: (value == 0)
                                        ? tabSelected
                                        : tabNoSelected,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          provider.changePage(1);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: ScreenUtil().setHeight(25),
                              width: ScreenUtil().setHeight(25),
                              child: SvgPicture.asset(
                                'assets/svg/almacen.svg',
                                color:
                                    (value == 1) ? tabSelected : tabNoSelected,
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Almacén',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: (value == 1)
                                        ? tabSelected
                                        : tabNoSelected,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      // InkWell(
                      //   onTap: () {
                      //     provider.changePage(2);
                      //   },
                      //   child: Column(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     children: [
                      //       Container(
                      //         height: ScreenUtil().setSp(30),
                      //         width: ScreenUtil().setSp(30),
                      //         child: SvgPicture.asset(
                      //           'assets/svg/solCompras.svg',
                      //           color: (value == 2) ? tabSelected : tabNoSelected,
                      //         ),
                      //       ),
                      //       Text(
                      //         'Solicitud\ncompras',
                      //         textAlign: TextAlign.center,
                      //         style: TextStyle(
                      //           fontSize: ScreenUtil().setSp(14),
                      //           color: (value == 2) ? tabSelected : tabNoSelected,
                      //         ),
                      //       )
                      //     ],
                      //   ),
                      // ),
                      InkWell(
                        onTap: () {
                          provider.changePage(3);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: ScreenUtil().setHeight(25),
                              width: ScreenUtil().setHeight(25),
                              child: SvgPicture.asset(
                                'assets/svg/solCompras.svg',
                                color:
                                    (value == 3) ? tabSelected : tabNoSelected,
                              ),
                            ),
                            Text(
                              'Orden\ncompras',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 13,
                                color:
                                    (value == 3) ? tabSelected : tabNoSelected,
                              ),
                            )
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          provider.changePage(4);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: ScreenUtil().setHeight(25),
                              width: ScreenUtil().setHeight(25),
                              child: SvgPicture.asset(
                                'assets/svg/cuenta.svg',
                                color:
                                    (value == 4) ? tabSelected : tabNoSelected,
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Cuenta',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: (value == 4)
                                        ? tabSelected
                                        : tabNoSelected,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class ChangeBottomExplorer extends ChangeNotifier {
  ValueNotifier<int> page = ValueNotifier(0);
  ValueNotifier<int> get _pagina => this.page;

  void changePage(int index) {
    print('index $index');
    page.value = index;
    notifyListeners();
  }
}

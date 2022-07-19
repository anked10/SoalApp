import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:soal_app/core/config/colors.dart';
import 'package:soal_app/src/pages/Contabilidad/contabilidad.dart';
import 'package:soal_app/src/pages/Cuenta/cuenta_page.dart';
import 'package:soal_app/src/pages/OrdenCompra/oc_pendientes.dart';

class HomeGerencia extends StatefulWidget {
  const HomeGerencia({Key? key}) : super(key: key);

  @override
  _HomeGerenciaState createState() => _HomeGerenciaState();
}

class _HomeGerenciaState extends State<HomeGerencia> {
  List<Widget> pageList = [];

  @override
  void initState() {
    pageList.add(OCPendientes());
    pageList.add(Contabilidad());
    pageList.add(CuentaPage());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ChangeBottom>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      body: ValueListenableBuilder<int>(
        valueListenable: provider._pagina,
        builder: (_, value, __) {
          return Stack(
            children: [
              Container(
                padding: EdgeInsets.only(
                  bottom: kBottomNavigationBarHeight + ScreenUtil().setHeight(20),
                ),
                child: IndexedStack(
                  index: value,
                  children: pageList,
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.only(
                    left: ScreenUtil().setWidth(10),
                    right: ScreenUtil().setWidth(10),
                    bottom: ScreenUtil().setHeight(10),
                  ),
                  height: kBottomNavigationBarHeight + ScreenUtil().setHeight(20),
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
                              height: ScreenUtil().setSp(30),
                              width: ScreenUtil().setSp(30),
                              child: SvgPicture.asset(
                                'assets/svg/solCompras.svg',
                                color: (value == 0) ? tabSelected : tabNoSelected,
                              ),
                            ),
                            Text(
                              'Orden\ncompras',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(14),
                                color: (value == 0) ? tabSelected : tabNoSelected,
                              ),
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
                              height: ScreenUtil().setSp(30),
                              width: ScreenUtil().setSp(30),
                              child: SvgPicture.asset(
                                'assets/svg/almacen.svg',
                                color: (value == 1) ? tabSelected : tabNoSelected,
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Contabilidad\ny Finanzas',
                                  style: TextStyle(
                                    fontSize: ScreenUtil().setSp(14),
                                    color: (value == 1) ? tabSelected : tabNoSelected,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          provider.changePage(2);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: ScreenUtil().setSp(30),
                              width: ScreenUtil().setSp(30),
                              child: SvgPicture.asset(
                                'assets/svg/cuenta.svg',
                                color: (value == 2) ? tabSelected : tabNoSelected,
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Cuenta',
                                  style: TextStyle(
                                    fontSize: ScreenUtil().setSp(14),
                                    color: (value == 2) ? tabSelected : tabNoSelected,
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

class ChangeBottom extends ChangeNotifier {
  ValueNotifier<int> page = ValueNotifier(0);
  ValueNotifier<int> get _pagina => this.page;

  void changePage(int index) {
    print('index $index');
    page.value = index;
    notifyListeners();
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soal_app/core/util/utils.dart';
import 'package:soal_app/src/api/orden_compra_api.dart';
import 'package:soal_app/src/widgets/show_loading.dart';

class AprobarOC extends StatefulWidget {
  const AprobarOC({Key? key, required this.id, required this.onChanged}) : super(key: key);

  final String id;
  final ValueChanged<int>? onChanged;

  @override
  _AprobarOCState createState() => _AprobarOCState();
}

class _AprobarOCState extends State<AprobarOC> {
  final _controller = ControllerAction();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withOpacity(.3),
      child: Stack(
        fit: StackFit.expand,
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              height: double.infinity,
              width: double.infinity,
              color: const Color.fromRGBO(0, 0, 0, 0.3),
            ),
          ),
          Container(
            height: double.infinity,
            width: double.infinity,
            margin: EdgeInsets.symmetric(
              vertical: ScreenUtil().setHeight(326),
              horizontal: ScreenUtil().setWidth(40),
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(24),
                vertical: ScreenUtil().setHeight(10),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    color: Colors.green,
                    size: ScreenUtil().setHeight(40),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(10),
                  ),
                  Text(
                    '¿Está seguro que desea Aprobar esta Orden de Compra?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: ScreenUtil().setSp(15),
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(20),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Cancelar',
                          style: TextStyle(
                            color: const Color(0XFFFF0F00),
                            fontWeight: FontWeight.w600,
                            fontSize: ScreenUtil().setSp(14),
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: ScreenUtil().setWidth(32),
                      ),
                      InkWell(
                        onTap: () async {
                          _controller.changeCargando(true);
                          final _api = OrdenCompraApi();
                          final res = await _api.aprobarOrdenCompra(widget.id);
                          if (res == 1) {
                            widget.onChanged!(1);
                            Navigator.pop(context);
                            showToast2('Orden de Compra Aprobada', Colors.green);
                          } else {
                            showToast2('Ocurrió un error, inténtelo nuevamente', Colors.redAccent);
                          }
                          _controller.changeCargando(false);
                        },
                        child: Text(
                          'AprobarOC',
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.w600,
                            fontSize: ScreenUtil().setSp(14),
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          AnimatedBuilder(
            animation: _controller,
            builder: (_, p) {
              return ShowLoadding(
                active: _controller.cargando,
                color: Colors.black.withOpacity(0.6),
              );
            },
          ),
        ],
      ),
    );
  }
}

class ControllerAction extends ChangeNotifier {
  bool cargando = false;

  void changeCargando(bool c) {
    cargando = c;
    notifyListeners();
  }
}

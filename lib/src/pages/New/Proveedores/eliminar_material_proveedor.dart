import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soal_app/core/util/utils.dart';
import 'package:soal_app/src/api/proveedores_api.dart';
import 'package:soal_app/src/widgets/show_loading.dart';

class EliminarMaterial extends StatefulWidget {
  const EliminarMaterial({Key? key, required this.id, required this.onChanged}) : super(key: key);
  final String id;
  final ValueChanged<int>? onChanged;

  @override
  _EliminarMaterialState createState() => _EliminarMaterialState();
}

class _EliminarMaterialState extends State<EliminarMaterial> {
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
                    Icons.cancel,
                    color: Colors.redAccent,
                    size: ScreenUtil().setHeight(40),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(10),
                  ),
                  Text(
                    '¿Está seguro que desea eliminar este material asignado al proveedor?',
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
                            color: Colors.green,
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
                          final _api = ProveedoresApi();
                          _controller.changeCargando(true);
                          final res = await _api.deleteProveedorMaterial(widget.id);
                          _controller.changeCargando(false);

                          if (res.code != 1) return showToast2('Ocurrió un error, inténtelo nuevamente', Colors.redAccent);

                          widget.onChanged!(res.code!);
                          showToast2('Material eliminado correctamente', Colors.black);
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Eliminar',
                          style: TextStyle(
                            color: const Color(0XFFFF0F00),
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

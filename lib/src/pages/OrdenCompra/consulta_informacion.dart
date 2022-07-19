import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConsultaInformacion extends StatelessWidget {
  const ConsultaInformacion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Orden de compras',
          style: TextStyle(
            fontSize: ScreenUtil().setSp(27),
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _button(titulo: 'Pendientes de\nAprobación', color: Colors.orangeAccent, icon: Icons.check_box_outlined),
        ],
      ),
    );
  }

  Widget _button({required String titulo, Function()? ontap, required Color color, required IconData icon}) {
    return Center(
      child: InkWell(
        onTap: ontap,
        child: Container(
          height: ScreenUtil().setHeight(180),
          width: ScreenUtil().setWidth(180),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.grey[500]!,
                offset: Offset(4, 4),
                blurRadius: 15,
                spreadRadius: 1,
              ),
              BoxShadow(
                color: Colors.white,
                offset: Offset(-4, -4),
                blurRadius: 15,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: Colors.white,
                size: ScreenUtil().setHeight(30),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(10),
              ),
              Text(
                titulo,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: ScreenUtil().setSp(16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

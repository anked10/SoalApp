import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PendientesVerificacion extends StatelessWidget {
  const PendientesVerificacion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(10), horizontal: ScreenUtil().setWidth(16)),
      child: Column(
        children: [
          Text(
            'Pendientes de Verificación',
            style: TextStyle(fontSize: ScreenUtil().setSp(16), fontWeight: FontWeight.w500, color: Colors.indigo),
          ),
          SizedBox(height: ScreenUtil().setHeight(10)),
        ],
      ),
    );
  }
}

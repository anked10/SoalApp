import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soal_app/src/pages/Home/menu_widget.dart';
import 'package:soal_app/src/pages/New/QHSE/generate_reporte_incidencias.dart';

class QHSE extends StatelessWidget {
  const QHSE({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const MenuWidget(),
        title: Text(
          'Reporte de Incidencias',
          style: TextStyle(
            fontSize: ScreenUtil().setSp(18),
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        elevation: 0,
      ),
      body: GenerateReport(),
    );
  }
}

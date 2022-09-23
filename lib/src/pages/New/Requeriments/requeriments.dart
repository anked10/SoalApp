import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soal_app/src/pages/Home/menu_widget.dart';
import 'package:soal_app/src/pages/New/Requeriments/approved_requeriments.dart';

class Requeriments extends StatelessWidget {
  const Requeriments({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const MenuWidget(),
        title: Text(
          'Requerimientos Aprobados',
          style: TextStyle(
            fontSize: ScreenUtil().setSp(18),
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              switch (value) {
                case 1:
                  break;
                case 2:
                  break;

                default:
                  break;
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Row(
                  children: [
                    Icon(
                      Icons.check_circle_outline,
                      color: Colors.indigo,
                    ),
                    SizedBox(
                      width: ScreenUtil().setWidth(8),
                    ),
                    Text(
                      'Generar Solicitud',
                      style: TextStyle(
                        color: Colors.indigo,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                value: 1,
              ),
              PopupMenuItem(
                child: Row(
                  children: [
                    Icon(
                      Icons.circle_outlined,
                      color: Colors.orangeAccent,
                    ),
                    SizedBox(
                      width: ScreenUtil().setWidth(8),
                    ),
                    Text(
                      'Pendientes de Aprobación',
                      style: TextStyle(color: Colors.orangeAccent),
                    ),
                  ],
                ),
                value: 2,
              ),
            ],
            child: Icon(Icons.keyboard_arrow_down, color: Colors.blueGrey),
          ),
          SizedBox(width: ScreenUtil().setWidth(16)),
        ],
        elevation: 0,
      ),
      body: ApprovedRequeriments(),
    );
  }
}

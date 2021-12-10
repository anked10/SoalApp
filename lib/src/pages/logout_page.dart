

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soal_app/core/sharedpreferences/storage_manager.dart';
import 'package:soal_app/core/util/constants.dart';


class LogoutPage extends StatefulWidget {
  const LogoutPage({Key? key}) : super(key: key);

  @override
  _LogoutPageState createState() => _LogoutPageState();
}

class _LogoutPageState extends State<LogoutPage> {
  String nombre = '';
  @override
  void initState() {
    firstName();
    super.initState();
  }

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
              color: Color.fromRGBO(0, 0, 0, 0.3),
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
              color: Color(0XFF17314C),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(24)),
              child: Column(
                children: [
                  SizedBox(
                    height: ScreenUtil().setHeight(32),
                  ),
                  Text(
                    '¿$nombre, estás seguro de cerrar sesión?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: ScreenUtil().setSp(18),
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(40),
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
                            color: Color(0XFF2684FE),
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
                        onTap: () {
                          StorageManager.deleteAllData();
                          Navigator.pushNamedAndRemoveUntil(context, LOGIN_ROUTE, (r) => false);
                        },
                        child: Text(
                          'Salir',
                          style: TextStyle(
                            color: Color(0XFFFF0F00),
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
          )
        ],
      ),
    );
  }

  void firstName() async {
    String? nomb = await StorageManager.readData('personName');
    if (nomb!.length > 0) {
      var nombres = nomb.split(' ');
      print(nombres[0]);
      nombre = nombres[0];
      setState(() {});
    }
  }
}

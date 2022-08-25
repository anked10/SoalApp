import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soal_app/core/sharedpreferences/storage_manager.dart';
import 'package:soal_app/core/util/constants.dart';
import 'package:soal_app/src/api/clases_api.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        final clasesApi = ClasesApi();
        await clasesApi.getClases();

        String? token = await StorageManager.readData('token');

        String? idRol = await StorageManager.readData('idRoleUser');
        if (token == null || token.isEmpty) {
          Navigator.pushNamedAndRemoveUntil(context, LOGIN_ROUTE, (route) => false);
        } else {
          //Navigator.pushNamedAndRemoveUntil(context, PAGE_MENU, (route) => false);

          //ROL GERENCIAS id=3
          if (idRol == '3') {
            Navigator.pushNamedAndRemoveUntil(context, HOME_GERENCIA, (route) => false);
          } else {
            Navigator.pushNamedAndRemoveUntil(context, PAGE_MENU, (route) => false);
          }
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              width: ScreenUtil().setWidth(200),
              height: ScreenUtil().setHeight(200),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.transparent.withOpacity(0.3),
                    spreadRadius: 6,
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Image(
                image: AssetImage('assets/images/soal.png'),
              ),
            ),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(20),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: ScreenUtil().setWidth(200),
              height: ScreenUtil().setHeight(200),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.transparent.withOpacity(0.3),
                    spreadRadius: 6,
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Image(
                image: AssetImage('assets/images/proonix.png'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

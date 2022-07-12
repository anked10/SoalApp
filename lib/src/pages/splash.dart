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
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final clasesApi = ClasesApi();
      await clasesApi.getClases();

      String? token = await StorageManager.readData('token');
      if (token == null || token.isEmpty) {
        Navigator.pushNamedAndRemoveUntil(context, LOGIN_ROUTE, (route) => false);
      } else {
        Navigator.pushNamedAndRemoveUntil(context, HOME_ROUTE, (route) => false);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        height: ScreenUtil().setHeight(200),
        width: double.infinity,
        child: Image(
          image: AssetImage('assets/images/logo.png'),
        ),
      ),
    ));
  }
}

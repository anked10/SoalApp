import 'package:flutter/material.dart';
import 'package:soal_app/src/pages/Inicio%20Menu%20Roles/home_gerencia.dart';
import 'package:soal_app/src/pages/home_page.dart';
import 'package:soal_app/src/pages/loginPage.dart';
import 'package:soal_app/src/pages/splash.dart';
import 'constants.dart';

class Routers {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LOGIN_ROUTE:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case HOME_ROUTE:
        return MaterialPageRoute(builder: (_) => HomePage());
      case SPLASH_ROUTE:
        return MaterialPageRoute(builder: (_) => Splash());
      case HOME_GERENCIA:
        return MaterialPageRoute(builder: (_) => HomeGerencia());

      default:
        return MaterialPageRoute(builder: (_) => LoginPage());
    }
  }
}

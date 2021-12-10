

import 'package:flutter/material.dart';
import 'package:soal_app/main.dart';
import 'package:soal_app/src/pages/loginPage.dart';
import 'package:soal_app/src/pages/splash.dart';
import 'constants.dart';

class Routers {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LOGIN_ROUTE:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case HOME_ROUTE:
        return MaterialPageRoute(builder: (_) => MyHomePage());
      case SPLASH_ROUTE:
        return MaterialPageRoute(builder: (_) => Splash());

      default:
        return MaterialPageRoute(builder: (_) => LoginPage());
    }
  }
}

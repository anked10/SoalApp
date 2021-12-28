import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soal_app/core/util/constants.dart';

class EdicionCompleta extends StatelessWidget {
  const EdicionCompleta({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: ScreenUtil().setSp(300),
            width: ScreenUtil().setSp(300),
            child: SvgPicture.asset(
              'assets/svg/provider_add.svg',
            ),
          ),
          Text(
            'Proveedor agregado exitosamente',
            textAlign: TextAlign.center,
            style: TextStyle(
              letterSpacing: -0.17,
              color: Color(0xfffbb03f),
              fontSize: ScreenUtil().setSp(40),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(50),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamedAndRemoveUntil(HOME_ROUTE, (Route<dynamic> route) => false);
            },
            child: SizedBox(
              width: ScreenUtil().setWidth(120),
              child: Column(
                children: [
                  Text(
                    'Volver al inicio',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      letterSpacing: -0.17,
                      color: Color(0xff403e93),
                      fontSize: ScreenUtil().setSp(20),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Divider(
                    color: Color(0xff403e93),
                    thickness: 2,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

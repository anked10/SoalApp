import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soal_app/src/pages/Home/menu_widget.dart';

class DefaultPage extends StatelessWidget {
  const DefaultPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const MenuWidget(),
        elevation: 0,
      ),
      body: Center(
        child: SizedBox(
          width: ScreenUtil().setWidth(350),
          height: ScreenUtil().setHeight(350),
          child: const Image(
            image: AssetImage('assets/images/logo.png'),
          ),
        ),
      ),
    );
  }
}

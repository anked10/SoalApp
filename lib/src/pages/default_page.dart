import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class DefaultPage extends StatelessWidget {
  const DefaultPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        leading: InkWell(
          onTap: () {
            ZoomDrawer.of(context)!.toggle();
          },
          child: Container(
            padding: EdgeInsets.only(
              left: ScreenUtil().setWidth(24),
            ),
            height: ScreenUtil().setHeight(45),
            width: ScreenUtil().setWidth(45),
            child: const Icon(
              Icons.menu,
              color: Colors.white,
            ),
          ),
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(16)),
            height: ScreenUtil().setHeight(400),
            decoration: BoxDecoration(
              color: Colors.indigo,
              borderRadius: BorderRadius.only(
                // bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(60),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: ScreenUtil().setWidth(180),
                    height: ScreenUtil().setHeight(180),
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
                Align(
                  alignment: Alignment.centerRight,
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
                SizedBox(
                  height: ScreenUtil().setHeight(16),
                )
              ],
            ),
          ),
          Spacer(),
          Text(
            '¡Bienvenido!',
            style: TextStyle(
              fontSize: ScreenUtil().setSp(30),
              color: Colors.blueGrey,
              fontWeight: FontWeight.w300,
            ),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(30),
          ),
          ElevatedButton(
            onPressed: () {
              ZoomDrawer.of(context)!.toggle();
            },
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
              ),
              padding: MaterialStateProperty.all<EdgeInsets>(
                EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(15),
                  vertical: ScreenUtil().setHeight(4),
                ),
              ),
            ),
            child: Text(
              'Continuar',
              style: TextStyle(fontSize: ScreenUtil().setSp(18)),
            ),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(100),
          ),
        ],
      ),
    );
  }
}

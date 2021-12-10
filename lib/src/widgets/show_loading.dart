import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShowLoadding extends StatelessWidget {
  const ShowLoadding({Key? key, required this.active}) : super(key: key);
  final bool active;

  @override
  Widget build(BuildContext context) {
    return (active)
        ? Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.black.withOpacity(0.3),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(
                  height: ScreenUtil().setHeight(10),
                ),
                Text(
                  'Cargando...',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: ScreenUtil().setSp(14),
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ],
            ),
          )
        : Container();
  }
}

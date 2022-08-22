import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget cards({required Widget child, required Color color, required num height, required num mtop, required Color fondo}) {
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      color: fondo,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: Colors.transparent.withOpacity(0.2),
          spreadRadius: 2,
          blurRadius: 5,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: ScreenUtil().setHeight(mtop)),
          width: ScreenUtil().setWidth(6),
          height: ScreenUtil().setHeight(height),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(5),
              bottomRight: Radius.circular(5),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: child,
          ),
        ),
      ],
    ),
  );
}

Widget rows(
    {required String titulo,
    required String data,
    required num st,
    required num sd,
    String? active,
    required CrossAxisAlignment crossAxisAlignment}) {
  return Row(
    crossAxisAlignment: crossAxisAlignment,
    children: [
      Text(
        titulo,
        style: TextStyle(
          fontSize: ScreenUtil().setSp(st),
          fontWeight: FontWeight.w400,
          color: (active == null) ? Colors.grey : Colors.black,
        ),
      ),
      SizedBox(
        width: ScreenUtil().setWidth(4),
      ),
      Expanded(
        child: Text(
          data,
          style: TextStyle(
            fontSize: ScreenUtil().setSp(sd),
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
      ),
    ],
  );
}

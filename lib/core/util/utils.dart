import 'dart:math';

import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class Utils {
  double screenSafeAreaHeight(BuildContext context) {
    return MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
  }

  double screenSafeAreaWidth(BuildContext context) {
    return MediaQuery.of(context).size.width - MediaQuery.of(context).padding.left - MediaQuery.of(context).padding.right;
  }

  Color randomColor() => Color(Random().nextInt(0xffffffff)).withAlpha(0xff);

  BorderRadius buildBorderRadius() {
    return BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20));
  }

  String prepareLists(List<String> list) {
    String result = "";
    if (list.isNotEmpty) {
      for (var person in list) {
        result = result + person.toString().split("/")[person.toString().split("/").length - 2] + ",";
      }
      result = result.substring(0, (result.length) - 1).replaceAll(",", "\n");
    } else {
      result = " - ";
    }
    return result;
  }
}

void showToast2(String? texto, Color color) {
  Fluttertoast.showToast(msg: "$texto", toastLength: Toast.LENGTH_LONG, timeInSecForIosWeb: 3, backgroundColor: color, textColor: Colors.white);
}

maxLines(String text, double ancho, TextStyle style) {
  final span = TextSpan(
    text: text,
    style: style,
  );
  final tp = TextPainter(text: span, textDirection: ui.TextDirection.ltr);
  tp.layout(maxWidth: ancho);
  //print('${tp.width.toInt()} $text');
  return tp.computeLineMetrics().length;
}

maxAncho(String text, double ancho, TextStyle style) {
  final span = TextSpan(
    text: text,
    style: style,
  );
  final tp = TextPainter(text: span, textDirection: ui.TextDirection.ltr);
  tp.layout(maxWidth: ancho);
  return tp.width * 1.7;
}

obtenerFecha(String date) {
  if (date == 'null' || date == '') {
    return '';
  }

  var fecha = DateTime.parse(date);

  final DateFormat fech = DateFormat('dd MMM yyyy', 'es');

  return fech.format(fecha);
}

selectdate(BuildContext context, TextEditingController date) async {
  DateTime? picked = await showDatePicker(
    context: context,
    firstDate: DateTime(DateTime.now().month - 1),
    initialDate: DateTime.now(),
    lastDate: DateTime(DateTime.now().year + 2),
  );

  date.text = "${picked!.year.toString().padLeft(2, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
}

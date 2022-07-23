import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFieldSearch extends StatelessWidget {
  const TextFieldSearch({Key? key, required this.label, required this.controller, required this.onChanged}) : super(key: key);
  final String label;
  final TextEditingController controller;
  final Function(String value)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(16),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(8),
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.deepPurple),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        textAlign: TextAlign.left,
        style: TextStyle(
          fontSize: ScreenUtil().setSp(16),
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          suffixIcon: const Icon(Icons.search),
          label: Text(
            label,
            style: TextStyle(
              fontSize: ScreenUtil().setSp(12),
              fontWeight: FontWeight.w400,
            ),
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}

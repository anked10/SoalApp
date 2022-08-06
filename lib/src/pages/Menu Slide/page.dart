import 'package:flutter/material.dart';
import 'package:soal_app/src/pages/Menu%20Slide/menu_slide.dart';

class PageInicio extends StatelessWidget {
  const PageInicio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
      ),
      drawer: Drawers(),
    );
  }
}

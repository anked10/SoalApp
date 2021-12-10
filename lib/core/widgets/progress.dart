import 'package:bufi_remake/core/util/utils.dart';
import 'package:flutter/material.dart';

class Progress extends StatelessWidget {

  const Progress({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
        height: Utils().screenSafeAreaHeight(context) - 24,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  'Loading ...',
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
        ), 
    );
  }
}

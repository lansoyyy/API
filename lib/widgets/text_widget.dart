import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  late String text;

  late FontWeight fontWeight;
  late double fontSize;

  late Color color;

  TextWidget(
      {required this.text,
      required this.color,
      required this.fontSize,
      required this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style:
          TextStyle(fontWeight: fontWeight, fontSize: fontSize, color: color),
    );
  }
}

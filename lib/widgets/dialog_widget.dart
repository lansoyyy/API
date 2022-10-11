import 'package:flutter/material.dart';
import 'package:sample_app/widgets/text_widget.dart';

class DialogWidget extends StatelessWidget {
  late String content;

  List<Widget>? widgets = [];

  DialogWidget({
    required this.content,
    this.widgets,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: TextWidget(
          text: 'Cannot Proceed',
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.bold),
      content: TextWidget(
          text: content,
          color: Colors.black,
          fontSize: 12,
          fontWeight: FontWeight.normal),
      actions: widgets,
    );
  }
}

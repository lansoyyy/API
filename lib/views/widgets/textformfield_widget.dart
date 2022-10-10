import 'package:flutter/material.dart';
import 'package:sample_app/views/widgets/text_widget.dart';

class TextFormFieldWidget extends StatelessWidget {
  late TextEditingController inputController;

  TextFormFieldWidget({required this.inputController});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: inputController,
      decoration: InputDecoration(
        label: TextWidget(
            text: 'Input',
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}

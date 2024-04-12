import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  String? hintText;
  TextEditingController? controllerTextField;

  MyTextFormField({
    this.hintText,
    this.controllerTextField,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controllerTextField,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

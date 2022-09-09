import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.textInputAction,
  });

  final TextEditingController controller;
  final TextInputAction textInputAction;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textInputAction: textInputAction,
      keyboardType: TextInputType.multiline,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.start,
      expands: true,
      maxLines: null,
      validator: (value) {
        if (value!.isEmpty) {
          return 'write something';
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: hintText,
      ),
    );
  }
}

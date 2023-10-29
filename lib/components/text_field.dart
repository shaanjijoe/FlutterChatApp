import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final bool hideText;
  final TextEditingController controller;
  const MyTextField({
    super.key,
    required this.controller,
    required this.hideText,
    required this.hintText
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15)
        ),
        hintText: hintText,
      ),
      obscureText: hideText,
    );
  }
}

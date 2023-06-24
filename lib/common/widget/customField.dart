import 'package:flutter/material.dart';

class CustomField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  const CustomField(
      {super.key, required this.hintText, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "$hintText can not be empty";
        }
      },
      decoration: InputDecoration(
        hintText: hintText,
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black)),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
    );
  }
}

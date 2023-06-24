import 'package:amazon_app/constants.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  const CustomButton({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      
      style: ElevatedButton.styleFrom(
        // foregroundColor: GlobalVariables.secondaryColor,
          minimumSize: const Size(double.infinity, 50)),
      onPressed: onTap,
      child: Text(text),
    );
  }
}

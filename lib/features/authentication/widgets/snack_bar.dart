import 'package:flutter/material.dart';

class CustomSnackBar {
  static showCustomSnackBar({
    required BuildContext context,
    required String content,
    Color color = Colors.white,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color,
        content: Center(
          child: Text(
            content,
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}

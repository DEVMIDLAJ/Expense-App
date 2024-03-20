import 'package:expence_app/const/colors.dart';
import 'package:flutter/material.dart';

class CustomSnackBar {
  static void show(BuildContext context, String content) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          content,
          style:const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        duration: const Duration(seconds: 5),
        behavior: SnackBarBehavior.fixed,
        backgroundColor: ksecondColor,
      ),
    );
  }
}

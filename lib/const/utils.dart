import 'package:flutter/material.dart';

// Function to build a custom SnackBar with specified content
SnackBar buildSnackBar(String content) {
  return SnackBar(
    content: Text(
      content,
      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
    ),
    // Set SnackBar display duration
    duration: const Duration(seconds: 2),
    behavior: SnackBarBehavior.fixed,
    // Set SnackBar background color
    backgroundColor: Colors.grey.shade200,
  );
}



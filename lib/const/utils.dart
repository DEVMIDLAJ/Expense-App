// ignore_for_file: non_constant_identifier_names

import 'package:expence_app/Model/transaction_datails_model.dart';
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

// List to store transaction details models (assuming it's a global list)
 List<TransactionDetailsModel> TransactionDetailsList = [];

// Comments:
// - The buildSnackBar function creates a custom SnackBar with specified content,
//   text style, duration, behavior, and background color.
// - The TransactionDetailsList is a global list to store instances of
//   TransactionDetailsModel, presumably representing financial transactions.
//   This list is intended to be shared across different parts of the application.

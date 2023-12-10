// ignore_for_file: non_constant_identifier_names

import 'package:expence_app/Model/transaction_datails_model.dart';
import 'package:expence_app/const/utils.dart'; // Importing necessary dependencies
import 'package:flutter/material.dart';

// Class to manage and provide transaction-related data
class TransactionProvider extends ChangeNotifier {
  // Variable to store total income
  int income = 0;
  // Variable to store total expenses
  int expense = 0;
  // Variable to store the balance (income - expenses)

  int balance = 0;

  // Calculate total income from TransactionDetailsList
  int calculateIncome() {
    // Reset the income variable
    income = 0;
    for (TransactionDetailsModel transaction in TransactionDetailsList) {
      if (transaction.Status == 'Income') {
        income = transaction.Amount!;
      }
    }
    return income;
  }

  // Calculate total expense from TransactionDetailsList
  int calculateExpense() {
    // Reset the expense variable
    expense = 0;
    for (TransactionDetailsModel transaction in TransactionDetailsList) {
      if (transaction.Status == 'Expense') {
        expense = transaction.Amount!;
      }
    }
    return expense;
  }

  // Calculate total income, total expense, and update the balance
  int calculateIncomeExpenseBalance() {
    income = 0;
    expense = 0;

    for (TransactionDetailsModel transaction in TransactionDetailsList) {
      if (transaction.Status == 'Income') {
        income += transaction.Amount!;
      } else if (transaction.Status == 'Expense') {
        expense += transaction.Amount!;
      }
    }

    // Calculate the balance (income - expenses)
    return balance = income - expense;
  }

  // Example method to add a new transaction
  void addTransaction(TransactionDetailsModel newTransaction) {
    // Add the new transaction to the global TransactionDetailsList
    TransactionDetailsList.add(newTransaction);
    // Recalculate income, expenses, and balance after adding a new transaction
    calculateIncomeExpenseBalance();
  }
}

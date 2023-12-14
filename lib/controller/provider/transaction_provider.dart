// ignore_for_file: constant_identifier_names

// Import necessary packages and modules
import 'dart:convert';
import 'package:expence_app/Model/transaction_datails_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Define a Provider class for managing transaction-related state
class TransactionProvider with ChangeNotifier {
  // Initialize variables to store income, expense, and main balance
  int finalIncome = 0;
  int finalExpense = 0;
  int mainBalance = 0;

  // List to store transaction details models (assuming it's a global list)
  List<TransactionDetailsModel> transactionDetailsList = [];

  // Constructor to load stored values when the provider is initialized
  TransactionProvider() {
    loadStoredValues();
  }

  // Load stored values from SharedPreferences
  Future<void> loadStoredValues() async {
    final prefs = await SharedPreferences.getInstance();
    finalIncome = prefs.getInt('finalincome') ?? 0;
    finalExpense = prefs.getInt('finalexpense') ?? 0;
    mainBalance = prefs.getInt('mainbalance') ?? 0;

    // Load transactionDetailsList from shared preferences
    final storedList = prefs.getStringList('transactionDetailsList');
    if (storedList != null) {
      transactionDetailsList = storedList
          .map((item) => TransactionDetailsModel.fromMap(
              json.decode(item) as Map<String, dynamic>))
          .toList();
    }
    // Notify listeners of the change in state
    notifyListeners();
  }

  // Save current values to SharedPreferences
  Future<void> saveValuesToStorage() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('finalincome', finalIncome);
    prefs.setInt('finalexpense', finalExpense);
    prefs.setInt('mainbalance', mainBalance);

    // Save transactionDetailsList to shared preferences
    final List<String> stringList = transactionDetailsList
        .map((transaction) => json.encode(transaction.toMap()))
        .toList();
    prefs.setStringList('transactionDetailsList', stringList);
  }

  // Method to handle income updates
  void incomeCarrier(int incomeCarrierValue) async {
    finalIncome = (finalIncome = incomeCarrierValue);
    mainBalance = (mainBalance) + incomeCarrierValue;

    await saveValuesToStorage();
    notifyListeners();
  }

  // Method to handle expense updates
  void expenseCarrier(int expenseCarrierValue) async {
    finalExpense = (finalExpense = expenseCarrierValue);
    mainBalance = (mainBalance) - expenseCarrierValue;

    await saveValuesToStorage();
    notifyListeners();
  }

  // Method to add a new transaction
  void addTransaction(TransactionDetailsModel newTransaction) {
    transactionDetailsList.add(newTransaction);
    calculateIncomeExpenseBalance();
  }

  // Methods to calculate income, expense, and overall balance
  int calculateIncome() {
    finalIncome = 0;
    for (TransactionDetailsModel transaction in transactionDetailsList) {
      if (transaction.Status == 'Income') {
        finalIncome += transaction.Amount ?? 0;
      }
    }
    saveValuesToStorage();
    return finalIncome;
  }

  // Methods to calculate income, expense, and overall balance
  int calculateExpense() {
    finalExpense = 0;
    for (TransactionDetailsModel transaction in transactionDetailsList) {
      if (transaction.Status == 'Expense') {
        finalExpense += transaction.Amount ?? 0;
      }
    }
    saveValuesToStorage();
    return finalExpense;
  }

  int calculateIncomeExpenseBalance() {
    finalIncome = 0;
    finalExpense = 0;

    for (TransactionDetailsModel transaction in transactionDetailsList) {
      if (transaction.Status == 'Income') {
        finalIncome += transaction.Amount ?? 0;
      } else if (transaction.Status == 'Expense') {
        finalExpense += transaction.Amount ?? 0;
      }
    }
    mainBalance = finalIncome - finalExpense;
    saveValuesToStorage();
    return mainBalance;
  }

  // Helper function to group transactions by date
  Map<String, List<TransactionDetailsModel>> groupTransactionsByDate(
      List<TransactionDetailsModel> transactions) {
    Map<String, List<TransactionDetailsModel>> groupedTransactions = {};

    for (TransactionDetailsModel transaction in transactions) {
      String dateCategory = getDateCategory(transaction.Date);
      groupedTransactions.putIfAbsent(dateCategory, () => []);
      groupedTransactions[dateCategory]!.add(transaction);
    }
    return groupedTransactions;
  }

  // Helper function to categorize dates into groups (Today, Yesterday, etc.)
  String getDateCategory(String? date) {
    // If the date is null, consider it as 'Older'
    if (date == null) {
      return 'Older';
    }
    // Parse the transaction date and get the current date
    DateTime transactionDate = DateTime.parse(date);
    DateTime today = DateTime.now();
    // Check if the transaction date is the same as the current date
    if (transactionDate.year == today.year &&
        transactionDate.month == today.month &&
        transactionDate.day == today.day) {
      return 'Today';
    }
    // Calculate the difference in days between the transaction date and today
    Duration difference = today.difference(transactionDate);
    // If the difference is 1 day, it's 'Yesterday'
    if (difference.inDays == 1) {
      return 'Yesterday';
      // If the difference is less than or equal to 7 days, it's 'This Week'
    } else if (difference.inDays <= 7) {
      return 'This Week';
      // If the transaction date is in the same month as today, it's 'This Month'
    } else if (transactionDate.year == today.year &&
        transactionDate.month == today.month) {
      return 'This Month';
      // If the transaction date is in the same year as today, it's 'This Year'
    } else if (transactionDate.year == today.year) {
      return 'This Year';
      // If none of the above conditions are met, it's 'Older'
    } else {
      return 'Older';
    }
  }
}

// Enum to represent different date categories
enum DateCategory {
  Today,
  Yesterday,
  ThisWeek,
  ThisMonth,
  ThisYear,
  Older,
}

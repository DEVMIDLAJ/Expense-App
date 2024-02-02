// ignore_for_file: constant_identifier_names, unrelated_type_equality_checks

// Import necessary packages and modules
import 'dart:convert';
import 'package:expence_app/Model/transaction_datails_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Define a Provider class for managing transaction-related state
class TransactionProvider with ChangeNotifier {
  // Initialize variables to store income, expense, and main balance
  int finalIncome = 0;
  int finalExpense = 0;
  int mainBalance = 0;

  // List to store transaction details models (assuming it's a global list)
  List<TransactionDetailsModel> transactionDetailsList = [];

  // List to store filtered transactions based on search query
  List<TransactionDetailsModel> filteredTransactionsList = [];

        String formattedMonthDay = DateFormat('MMMM d').format(DateTime.now());


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
      if (transaction.status == 'Income') {
        finalIncome += transaction.amount ?? 0;
      }
    }
    saveValuesToStorage();
    return finalIncome;
  }

  // Methods to calculate income, expense, and overall balance
  int calculateExpense() {
    finalExpense = 0;
    for (TransactionDetailsModel transaction in transactionDetailsList) {
      if (transaction.status == 'Expense') {
        finalExpense += transaction.amount ?? 0;
      }
    }
    saveValuesToStorage();
    return finalExpense;
  }

  int calculateIncomeExpenseBalance() {
    finalIncome = 0;
    finalExpense = 0;

    for (TransactionDetailsModel transaction in transactionDetailsList) {
      if (transaction.status == 'Income') {
        finalIncome += transaction.amount ?? 0;
      } else if (transaction.status == 'Expense') {
        finalExpense += transaction.amount ?? 0;
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
      String dateCategory = getDateCategory(transaction.date);
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

//Inside the getTransactionByDateCategory method of TransactionProvider class
  List<TransactionDetailsModel> getTransactionByDateCategory(
      DateCategory dateCategory) {
    DateTime now = DateTime.now();
    DateTime startDate;
    DateTime endDate;

    switch (dateCategory) {
      case DateCategory.Today:
        startDate = DateTime(now.year, now.month, now.day, 0, 0, 0);
        endDate = DateTime(now.year, now.month, now.day, 23, 59, 59);
        break;
      case DateCategory.ThisWeek:
        startDate = DateTime(now.year, now.month, now.day, 0, 0, 0)
            .subtract(const Duration(days: 1));
        endDate = DateTime(now.year, now.month, now.day, 23, 59, 59);
        break;
      case DateCategory.ThisMonth:
        startDate = DateTime(now.year, now.month, 1, 0, 0, 0)
            .subtract(const Duration(days: 7));
        endDate = DateTime(now.year, now.month + 1, 0, 23, 59, 59);
        break;
      case DateCategory.ThisYear:
        startDate = DateTime(now.year, 1, 1, 0, 0, 0);
        endDate = DateTime(now.year, 12, 31, 23, 59, 59);
        break;
      default:
        startDate = DateTime(now.year, now.month, now.day, 0, 0, 0);
        endDate = DateTime(now.year, now.month, now.day, 23, 59, 59);
    }

    // Ensure transactions have valid dates before filtering
    List<TransactionDetailsModel> validTransactions = transactionDetailsList
        .where((transaction) => transaction.date != null)
        .toList();

    filteredTransactionsList = validTransactions.where((transaction) {
      DateTime transactionDate = DateTime.parse(transaction.date!);
      return transactionDate.isAtSameMomentAs(startDate) &&
          transactionDate.isBefore(endDate);
    }).toList();

    return filteredTransactionsList.reversed.toList();
  }

  void searchTransactions(String query) {
    filteredTransactionsList = transactionDetailsList
        .where((transaction) =>
            transaction.category!.toLowerCase().contains(query.toLowerCase()) ||
            transaction.discription!
                .toLowerCase()
                .contains(query.toLowerCase()))
        .toList();
    notifyListeners();
  }

  void deleteTransaction(int id) {
    // Find the index of the transaction in the main list
    int index = transactionDetailsList
        .indexWhere((transaction) => transaction.id == id);
    if (index != -1) {
      // Remove the transaction from the main list
      transactionDetailsList.removeAt(index);
      // Find the index of the transaction in the filtered list
      index = filteredTransactionsList
          .indexWhere((transaction) => transaction.id == id);
      if (index != -1) {
        // Remove the transaction from the filtered list if it exists
        filteredTransactionsList.removeAt(index);
      }
      // Notify listeners to update the UI
      notifyListeners();
    }
  }

  void updateTransaction(
      int transactionId,
      String updatedAmount,
      String title,
      String updatedSubtitle,
      String status,
      String date,
      String time,
      String amoutType) {
    // Create an updated TransactionDetailsModel
    TransactionDetailsModel updatedTransaction = TransactionDetailsModel(
      id: transactionId,
      category: title,
      discription: updatedSubtitle,
      amount: double.parse(updatedAmount).toInt(),
      date: date,
      time: time,
      status: status,
      amountType: amoutType,
    );

    // Find the index of the transaction in the main list
    int index = transactionDetailsList
        .indexWhere((transaction) => transaction.id == transactionId);
    if (index != -1) {
      // Update the transaction in the main list
      transactionDetailsList[index] = updatedTransaction;
    }
    // Find the index of the transaction in the filtered list
    index = filteredTransactionsList
        .indexWhere((transaction) => transaction.id == transactionId);
    if (index != -1) {
      // Update the transaction in the filtered list if it exists
      filteredTransactionsList[index] = updatedTransaction;
    }
    // Notify listeners to update the UI
    notifyListeners();
  }

  // Method to get total expenses for a given category
  int getTotalExpensesForCategory(
    String category,
    String month,
  ) {
    List<TransactionDetailsModel> expensesForCategory = transactionDetailsList
        .where((transaction) =>
            transaction.status == 'Expense' &&
            transaction.category == category &&
            getMonthFromDate(transaction.date!) == month)
        .toList();

    int totalExpenseForCategory =
        expensesForCategory.fold(0, (sum, transaction) {

      return sum + (transaction.amount ?? 0);
    });
    return totalExpenseForCategory;
  }

  // Method to get transactions for a given category
  List<TransactionDetailsModel> getTransactionByCategory(String category, String month) {
    List<TransactionDetailsModel> transactionsForCategory =
        transactionDetailsList
            .where((transaction) => transaction.category == category  &&
            getMonthFromDate(transaction.date!) == month)
            .toList();
  
    return transactionsForCategory;
  }

  String getMonthFromDate(String date) {
    // Parse the date string into a DateTime object
    DateTime dateTime = DateTime.parse(date);
    // Use the intl package to format the DateTime object to a month
    String month = DateFormat.LLLL().format(dateTime);
    return month;
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

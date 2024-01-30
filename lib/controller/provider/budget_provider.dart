// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:expence_app/Model/budget_section_model.dart';
import 'package:expence_app/Model/transaction_datails_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'transaction_provider.dart'; // Import your TransactionProvider class

class BudgetProvider with ChangeNotifier {
  bool isLoading = false;
  String? updateDropdownValue;
  int? categoryAmount;
  String currentMonth = DateFormat('MMMM').format(DateTime.now());
  int currentMonthIndex = DateTime.now().month - 1;

  List<String> month = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];
  List<BudgetSectionModel> BudgetList = [];

  void monthChanger(int monthsToAdd) {
    currentMonthIndex = (currentMonthIndex + monthsToAdd) % 12;
    currentMonth = month[currentMonthIndex];
    notifyListeners();
  }

  void boolLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  String? updateDropdown(String? newValue) {
    updateDropdownValue = newValue;
    notifyListeners();
    return updateDropdownValue;
  }

  BudgetProvider() {
    initialize();
  }

  void initialize() async {
    if (BudgetList.isEmpty) {
      await loadData();
    }
  }

  Future<void> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? serializedList = prefs.getStringList('budgetList');
    if (serializedList != null) {
      BudgetList = serializedList
          .map((jsonString) =>
              BudgetSectionModel.fromMap(json.decode(jsonString)))
          .toList();
      notifyListeners();
    }
  }

  Future<void> _saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> serializedList =
        BudgetList.map((budget) => json.encode(budget.toMap())).toList();
    prefs.setStringList('budgetList', serializedList);
  }

  void addBudget(BudgetSectionModel newBudget) {
    BudgetList.add(newBudget);
    _saveData();
    notifyListeners();
  }

  int getExpenseDifferenceForCategory(
      BuildContext context, String category)  {
    print("budget section grtExpenseDiffrenceForCategory oprned");
    TransactionProvider transactionProvider =
        Provider.of<TransactionProvider>(context, listen: false);
    int totalExpenseForCategory = 
        transactionProvider.getTotalExpensesForCategory(category);
    print("${totalExpenseForCategory = transactionProvider.getTotalExpensesForCategory(category) as int} ");
    BudgetSectionModel budget = getBudgetForCategory(category);
    print("$budget");
    int difference = budget.Amount! - totalExpenseForCategory;
    print('${budget.Amount}');
    print('${totalExpenseForCategory}');
    print("${difference}....diffrence");
    print('toTalExpenseForCategory is closed');
    return difference;
  }

  int getTotalExpensesForCategory(
      BuildContext context, String category)  {
    print("budget section getTotalExpenceForCategory opened");
    TransactionProvider transactionProvider =
        Provider.of<TransactionProvider>(context, listen: false);

    List<TransactionDetailsModel> expensesForCategory =
         transactionProvider.getTransactionByCategory(category);
    print("$expensesForCategory");
    int totalExpenseForCategory =
        expensesForCategory.fold(0, (sum, transaction) {
      return sum + (transaction.Amount ?? 0);
    });
    print("$totalExpenseForCategory");
    print("totalExpenseForCategory is closed");
    return totalExpenseForCategory;
  }

  BudgetSectionModel getBudgetForCategory(String category) {
    print("getBudgetForCategory is opened");
    BudgetSectionModel budget = BudgetList.firstWhere(
      (budget) => budget.Category == category,
      orElse: () => BudgetSectionModel(
          Amount: 0, Category: category, Month: '', Id: null),
    );
    print("$budget");

    return budget;
  }
  
}

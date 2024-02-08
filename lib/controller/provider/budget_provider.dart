import 'dart:convert';
import 'package:expence_app/Model/budget_section_model.dart';
import 'package:expence_app/Model/transaction_datails_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'transaction_provider.dart';

class BudgetProvider with ChangeNotifier {
  bool isLoading = false;
  String? updateDropdownValue;
  int? categoryAmount;
  String currentMonth = DateFormat('MMMM').format(DateTime.now());
  int currentMonthIndex = DateTime.now().month - 1;
  List<BudgetSectionModel> budgetList = [];

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

  List<String> getCategoriesForMonth() {
    List<String> categoriesForMonth = budgetList
        .where((budget) => budget.month == currentMonth)
        .map((budget) => budget.category!)
        .toSet()
        .toList();

    return categoriesForMonth;
  }

  void monthChanger(int monthsToAdd) {
    currentMonthIndex = (currentMonthIndex + monthsToAdd) % 12;
    currentMonth = month[currentMonthIndex];
    notifyListeners();
  }

  void removeCategoryForCurrentMonth(String category) {
    budgetList.removeWhere((budget) =>
        budget.month == currentMonth && budget.category == category);
    _saveData();
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
    if (budgetList.isEmpty) {
      await loadData();
    }
  }

  Future<void> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? serializedList = prefs.getStringList('budgetList');
    if (serializedList != null) {
      budgetList = serializedList
          .map((jsonString) =>
              BudgetSectionModel.fromMap(json.decode(jsonString)))
          .toList();
      notifyListeners();
    }
  }

  Future<void> _saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> serializedList =
        budgetList.map((budget) => json.encode(budget.toMap())).toList();
    prefs.setStringList('budgetList', serializedList);
    
  }

  void addBudget(BudgetSectionModel newBudget) {
    budgetList.add(newBudget);
    _saveData();
    notifyListeners();
  }

  int getExpenseDifferenceForCategory(
      BuildContext context, String category, String month) {
    TransactionProvider transactionProvider =
        Provider.of<TransactionProvider>(context, listen: false);
    int totalExpenseForCategory =
        transactionProvider.getTotalExpensesForCategory(category, month);
    BudgetSectionModel budget = getBudgetForCategory(category, month);
    int difference = budget.amount! - totalExpenseForCategory;
    return difference;
  }

  int getTotalExpensesForCategory(
      BuildContext context, String category, String month) {
    TransactionProvider transactionProvider =
        Provider.of<TransactionProvider>(context, listen: false);

    List<TransactionDetailsModel> expensesForCategory =
        transactionProvider.getTransactionByCategory(category, month);
    int totalExpenseForCategory =
        expensesForCategory.fold(0, (sum, transaction) {
      return sum + (transaction.amount ?? 0);
    });
    return totalExpenseForCategory;
  }

  BudgetSectionModel getBudgetForCategory(String category, String month) {
    BudgetSectionModel budget = budgetList.firstWhere(
      (budget) => budget.category == category && budget.month == currentMonth,
      orElse: () => BudgetSectionModel(
          amount: 0, category: category, month: month, id: null),
    );
    return budget;
  }

  // Method to update the budget amount
  void updateBudgetAmount(
      {required int id,
      required int newAmount,
      required String category,
      required String month}) async {
    BudgetSectionModel updateBudgetList = BudgetSectionModel(
        amount: newAmount, category: category, month: month, id: id);
    // Find the budget with the given id and update its amount
    int index = budgetList.indexWhere((budget) => budget.id == id);
    if (index != -1) {
      budgetList[index] = updateBudgetList;

      index = budgetList.indexWhere((budget) => budget.id == id);
      if (index != -1) {
        budgetList[index] = updateBudgetList;
        await _saveData();
      }
      notifyListeners();
    }
  }

  Future<void> deleteBudget(int id) async {
    // Find the index of the budget in the main list
    int index = budgetList.indexWhere((budget) => budget.id == id);
    if (index != -1) {
      // Remove the budget from the main list
      budgetList.removeAt(index);
      // Save the updated budget list
      await _saveData();
      // Notify listeners to update the UI
      notifyListeners();
    }
  }
}

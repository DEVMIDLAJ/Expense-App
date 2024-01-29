// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:expence_app/Model/budget_section_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BudgetProvider with ChangeNotifier {
  bool isLoading = false;
  String? updateDropdownValue;
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

  void incrementMonths(int monthsToAdd) {
    currentMonthIndex = (currentMonthIndex + monthsToAdd) % 12;
    currentMonth = month[currentMonthIndex];
    notifyListeners();
  }

  void decrementMonths(int monthsToAdd) {
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

}

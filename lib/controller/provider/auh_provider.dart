import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  // Flag to control whether a password field is obscured or not
  bool isObscure = false;

  // Flag to represent whether a checkbox is checked or not
  bool isChecked = false;

  // Flag to control whether to show a number or not (assuming a PIN or similar)
  bool isNumberShow = false;

  // Flag to represent the loading state of some asynchronous operation
  bool isLoading = false;

  // Index representing the currently selected item, e.g., in a bottom navigation bar
  int selectedIndex = 0;

  // Variable to hold the current value of a dropdown; initially set to null
  String? updateDropdownValue;

  // Toggles the visibility of the password in a text field
  void boolObscure() {
    isObscure = !isObscure;
    notifyListeners();
  }

  // Sets the visibility of a number (e.g., PIN digits)
  void boolNumberShow(bool value) {
    isNumberShow = value;
    notifyListeners();
  }

  // Toggles the checked state of a checkbox
  void boolChecked() {
    isChecked = !isChecked;
    notifyListeners();
  }

  // Toggles the loading state for an asynchronous operation
  void boolLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  // Sets the index representing the selected item (e.g., in a bottom navigation bar)
  void setIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  // Method to update the dropdown value and notify listeners of the change
  String? updateDropdown(String? newValue) {
    updateDropdownValue = newValue;
    notifyListeners();
    return updateDropdownValue;
  }
}

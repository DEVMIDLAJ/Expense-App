import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  
  bool isObscure = false;

  bool isChecked = false;

  bool isNumberShow = false;

  bool isLoading = false;

  void boolObscure() {
    isObscure = !isObscure;
    notifyListeners();
  }

  void boolNumberShow(bool value) {
    isNumberShow = value;
    notifyListeners();
  }


  void boolChecked() {
    isChecked = !isChecked;
    notifyListeners();
  }

  void boolLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }

}

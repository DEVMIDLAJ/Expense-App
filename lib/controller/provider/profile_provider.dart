// ignore_for_file: unused_element
import 'package:flutter/foundation.dart';

class ProfileProvider extends ChangeNotifier {
  bool isChecked = false;

  String selectedIndex = '0';

  bool isLoading = false;

  bool isLoading1 = false;

  bool isLoading2 = false;

  String get _selectedIndex => selectedIndex;

  set _selectedIndex(String newIndex) {
    selectedIndex = newIndex;
    notifyListeners();
  }

  setCurrentIndex(context, {String index = ''}) {
    selectedIndex = index;
    notifyListeners();
  }

  void boolLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  void boolLoading1() {
    isLoading1 = !isLoading1;
    notifyListeners();
  }

  void boolLoading2() {
    isLoading2 = !isLoading2;
    notifyListeners();
  }
}

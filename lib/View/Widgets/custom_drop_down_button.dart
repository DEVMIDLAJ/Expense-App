// ignore_for_file: must_be_immutable

import 'package:expence_app/View/Widgets/display_text.dart';
import 'package:expence_app/controller/provider/auh_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomDropDownButton extends StatelessWidget {
  final List<String> categories;
  final String hintText;
  final void Function(String?) onValueChanged;
  String? currentMonth;
  double? buttonWidth;
  bool? hasBorder;
  Color? itemColor;

  CustomDropDownButton({
    Key? key,
    required this.categories,
    required this.hintText,
    required this.onValueChanged,
    this.currentMonth,
    this.buttonWidth,
    this.itemColor,
    this.hasBorder = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthProvider dropdownButtonProvider = Provider.of<AuthProvider>(context);
    String? currentValue = categories.isEmpty
        ? hintText
        : dropdownButtonProvider.updateDropdownValue;

    return SizedBox(
      width: buttonWidth,
      child: DropdownButtonFormField(
        hint: DisplayText(title: hintText),
        decoration: InputDecoration(
          border: hasBorder == true
              ? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                )
              : InputBorder.none,
        ),
        value: currentValue,
        items: categories.map((String value) {
          return DropdownMenuItem(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: onValueChanged,
      ),
    );
  }
}

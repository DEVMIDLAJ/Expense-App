// ignore_for_file: must_be_immutable, unused_local_variable

import 'package:expence_app/View/Widgets/display_text.dart';
import 'package:expence_app/controller/provider/auh_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomDropDownButton extends StatelessWidget {
  final List<String> listype;
  final void Function(String?) onValueChanged;
  final String hintText;
  double? buttonWidth;
  bool? hasBorder;

  CustomDropDownButton({
    Key? key,
    required this.listype,
    required this.onValueChanged,
    required this.hintText,
    this.buttonWidth,
    this.hasBorder = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthProvider dropdownProvider = Provider.of<AuthProvider>(context);
    String? currentValue = dropdownProvider.updateDropdownValue;

    return SizedBox(
      width: buttonWidth,
      child: DropdownButtonFormField(
        hint: DispalyText(title: hintText),
        decoration: InputDecoration(
          border: hasBorder == true
              ? OutlineInputBorder(borderRadius: BorderRadius.circular(15))
              : InputBorder.none,
        ),
        value: currentValue,
        items: listype.map((String listype) {
          return DropdownMenuItem(
            value: listype,
            child: Text(listype),
          );
        }).toList(),
        onChanged: onValueChanged,
      ),
    );
  }
}

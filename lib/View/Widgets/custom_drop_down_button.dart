import 'package:flutter/material.dart';

class CustomDropDownButton extends StatelessWidget {
  final List<String> listype;
  final void Function(String? value) buttonAction;

  const CustomDropDownButton({
    Key? key,
    required this.listype,
    required this.buttonAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? dropdownvalue = listype.isNotEmpty ? listype[0] : 'select option';

    return DropdownButtonFormField(
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
      ),
      value: dropdownvalue,
      items: listype.map((String listype) {
        return DropdownMenuItem(
          value: listype,
          child: Text(listype),
        );
      }).toList(),
      onChanged: (value) {
        buttonAction(value);
      },
    );
  }
}

// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final void Function()? onpressed;
  final String? buttonText;
  Color? buttonColor;
  Color? textColor;
  CustomElevatedButton({
    super.key,
    this.buttonColor,
    this.textColor,
    required this.onpressed,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 350,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(buttonColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
          ),
        ),
        onPressed: onpressed,
        child: Text(
          buttonText!,
          style: TextStyle(
            fontSize: 20,
            color: textColor,
          ),
        ),
      ),
    );
  }
}

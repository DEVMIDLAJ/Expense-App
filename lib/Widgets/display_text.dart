import 'package:flutter/material.dart';

class DispalyText extends StatelessWidget {
  final String title;
  final Color? textColor;
  final double? textSize;
  final FontWeight? textFont;

  const DispalyText({super.key, required this.title,this.textColor,this.textSize,this.textFont});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: textColor,
        fontSize: textSize,
        fontWeight: textFont,
      ),
    );
  }
}

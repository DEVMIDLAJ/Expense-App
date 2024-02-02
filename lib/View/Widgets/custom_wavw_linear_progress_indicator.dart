import 'package:expence_app/const/colors.dart';
import 'package:flutter/material.dart';

class CustomLinearProgressIndicator extends StatelessWidget {
  final double value;
  final Color backgroundColor;
  final Color waveColor;

  const CustomLinearProgressIndicator({
    super.key,
    required this.value,
    required this.backgroundColor,
    required this.waveColor,
  });

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      backgroundColor: backgroundColor,
      borderRadius: BorderRadius.circular(15),
      value: value,
      minHeight: 9.0,
      valueColor: const AlwaysStoppedAnimation<Color>(kfirstColor),
    );
  }
}

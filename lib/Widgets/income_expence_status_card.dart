import 'package:expence_app/Widgets/display_text.dart';
import 'package:flutter/material.dart';

class IncomeAndExpenseStatusCard extends StatelessWidget {
  const IncomeAndExpenseStatusCard({
    super.key,
    required this.statusIcon,
    required this.statusCardColor,
    required this.statusName,
    required this.statusAmount,
  });
  final IconData statusIcon;
  final Color statusCardColor;
  final String statusName;
  final String statusAmount;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      width: 170,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: statusCardColor),
      child: Center(
        child: ListTile(
          leading: Container(
            height: 65,
            width: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(
              statusIcon,
              color: statusCardColor,
            ),
          ),
          title: DispalyText(
            title: statusName,
            textColor: Colors.white,
            textSize: 16,
            textFont: FontWeight.w500,
          ),
          subtitle: DispalyText(
            title: statusAmount,
            textColor: Colors.white,
            textSize: 25,
            textFont: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

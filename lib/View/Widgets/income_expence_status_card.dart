import 'package:expence_app/View/Widgets/display_text.dart';
import 'package:expence_app/const/colors.dart';
import 'package:flutter/material.dart';

class IncomeAndExpenseStatusCard extends StatelessWidget {
  final String statusName;
  final String statusAmount;
  final String statusImage;
  final Color statusCardColor;

  const IncomeAndExpenseStatusCard({
    super.key,
    required this.statusName,
    required this.statusAmount,
    required this.statusImage,
    required this.statusCardColor,
  });

  @override
  Widget build(BuildContext context) {
        Size size = MediaQuery.of(context).size;

    return Flexible(
      child: Container(
        height: size.height * 0.1,
        width: size.width * 0.45,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: statusCardColor),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Container(
                height: size.height * 0.07,
                width: size.width * 0.14,
                decoration: BoxDecoration(
                  color: kWhite,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Image.asset(
                  statusImage,
                  color: statusCardColor,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DispalyText(
                  title: statusName,
                  textColor: Colors.white,
                  textSize: 16,
                  textFont: FontWeight.w500,
                ),
                DispalyText(
                  title: statusAmount,
                  textColor: Colors.white,
                  textSize: 25,
                  textFont: FontWeight.w500,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

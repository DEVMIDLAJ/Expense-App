import 'package:expence_app/View/expence_add_page.dart';
import 'package:expence_app/View/income_add_page.dart';
import 'package:expence_app/View/transaction_page.dart';
import 'package:expence_app/const/colors.dart';

import 'package:fab_circular_menu_plus/fab_circular_menu_plus.dart';
import 'package:flutter/material.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FabCircularMenuPlus(
      fabColor: kfirstColor,
      ringDiameter: 220,
      ringWidth: size.width * 0.01,
      ringColor: Colors.transparent,
      fabOpenIcon: const Icon(
        Icons.add,
        size: 45,
        color: kWhite,
      ),
      fabCloseIcon: const Icon(
        Icons.close,
        size: 45,
        color: kWhite,
      ),
      alignment: Alignment.bottomCenter,
      children: [
        FabIconWidget(
          buttonColor: incomeColor,
          buttonImage: 'assets/income.png',
          buttonAction: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => IncomePage(),
              ),
            );
          },
        ),
        FabIconWidget(
          buttonColor: transactionColor,
          buttonImage: 'assets/currency-exchange.png',
          buttonAction: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => TransactionPage(),
              ),
            );
          },
        ),
        FabIconWidget(
          buttonColor: expenseColor,
          buttonImage: 'assets/expense.png',
          buttonAction: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ExpensePage(),
              ),
            );
          },
        ),
      ],
    );
  }
}

class FabIconWidget extends StatelessWidget {
  final void Function()? buttonAction;
  final Color buttonColor;
  final String buttonImage;

  const FabIconWidget({
    super.key,
    this.buttonAction,
    required this.buttonColor,
    required this.buttonImage,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonAction,
      child: CircleAvatar(
        radius: 25,
        backgroundColor: buttonColor,
        child: Image(
          image: AssetImage(buttonImage),
        ),
      ),
    );
  }
}

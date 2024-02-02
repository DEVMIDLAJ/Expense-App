// ignore_for_file: unused_local_variable

import 'package:expence_app/View/Widgets/custom_wavw_linear_progress_indicator.dart';
import 'package:expence_app/View/Widgets/custome_elevated_button.dart';
import 'package:expence_app/View/Widgets/display_text.dart';
import 'package:expence_app/View/budget_page.dart';
import 'package:expence_app/View/edit_budget_page.dart';
import 'package:expence_app/const/colors.dart';
import 'package:expence_app/controller/provider/budget_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BudgetDetailsPage extends StatelessWidget {
  final int? amount;
  final String? category;
  final int? remaining;
  final int? totalExpence;
  final String? month;
  final int? id;
  const BudgetDetailsPage({
    required this.amount,
    required this.category,
    required this.remaining,
    required this.totalExpence,
    required this.month,
    required this.id,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    BudgetProvider budgetDetailsPageProvider =
        Provider.of<BudgetProvider>(context);

    return Consumer(
      builder: (context, data, child) {
        bool exceededLimit = amount! > totalExpence!;

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(
                Icons.arrow_back_ios,
                color: kfirstColor,
              ),
            ),
            title: const DisplayText(
              title: 'Detail Budget',
              textFont: FontWeight.w600,
            ),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.delete,
                  color: exceededLimit ? kblack : expenseColor,
                ),
                onPressed: () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (context) {
                      return Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Padding(
                          padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                          ),
                          child: SizedBox(
                            height: size.height * 0.23,
                            width: size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const DisplayText(
                                  title: "Remove this budget?",
                                  textSize: 18,
                                  textFont: FontWeight.w600,
                                ),
                                const DisplayText(
                                  title:
                                      "Are you sure do you wanna remove this\n                              budget?",
                                  textColor: kgrey,
                                  textSize: 16,
                                  textFont: FontWeight.w500,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Flexible(
                                      child: CustomElevatedButton(
                                        onpressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        buttonText: 'No',
                                      ),
                                    ),
                                    SizedBox(
                                      width: size.width * 0.02,
                                    ),
                                    Flexible(
                                      child: CustomElevatedButton(
                                        onpressed: () {
                                          budgetDetailsPageProvider
                                              .deleteBudget(id!);
                                          Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                            builder: (context) =>
                                                const BudgetPage(),
                                          ));
                                        },
                                        buttonText: 'Yes',
                                        textColor: kWhite,
                                        buttonColor: kfirstColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: size.height * 0.1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: kWhite,
                      child: Image(
                        image: AssetImage("assets/${category!}.png"),
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.03,
                    ),
                    DisplayText(
                      title: category!.toUpperCase(),
                      textColor: kblack,
                      textSize: 18,
                      textFont: FontWeight.w700,
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                const DisplayText(
                  title: "Remaining",
                  textSize: 24,
                  textFont: FontWeight.w600,
                ),
                DisplayText(
                  title: "\$${remaining!}",
                  textSize: 64,
                  textFont: FontWeight.w600,
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                CustomLinearProgressIndicator(
                  value: totalExpence! / amount!,
                  backgroundColor: Colors.grey.shade300,
                  waveColor: expenseColor,
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                exceededLimit
                    ? const SizedBox.shrink()
                    : Container(
                        height: size.height * 0.05,
                        width: size.width * 0.6,
                        decoration: BoxDecoration(
                          color: expenseColor,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.error,
                              color: kWhite,
                            ),
                            DisplayText(
                              title: 'You ve exceed the limit',
                              textColor: kWhite,
                            ),
                          ],
                        ),
                      ),
                const Spacer(),
                CustomElevatedButton(
                  onpressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => EditBudgetPage(
                          amount: amount.toString(),
                          category: category!,
                          month: month!,
                          id: id!,
                        ),
                      ),
                    );
                  },
                  buttonText: 'Edit',
                  buttonColor: kfirstColor,
                  textColor: kWhite,
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

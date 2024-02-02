// ignore_for_file: unused_local_variable

import 'package:expence_app/Model/budget_section_model.dart';
import 'package:expence_app/View/Widgets/custom_wavw_linear_progress_indicator.dart';
import 'package:expence_app/View/Widgets/custome_elevated_button.dart';
import 'package:expence_app/View/Widgets/display_text.dart';
import 'package:expence_app/View/budget_details_page.dart';
import 'package:expence_app/View/create_budget_page.dart';
import 'package:expence_app/const/colors.dart';
import 'package:expence_app/controller/provider/budget_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BudgetPage extends StatelessWidget {
  const BudgetPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Consumer<BudgetProvider>(
      builder: (BuildContext context, BudgetProvider data, Widget? _) {
        return Scaffold(
          backgroundColor: kfirstColor,
          body: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: size.height * 0.12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          data.monthChanger(-1);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          color: kWhite,
                        ),
                      ),
                      DisplayText(
                        title: data.currentMonth,
                        textSize: 20,
                        textColor: kWhite,
                      ),
                      IconButton(
                        onPressed: () {
                          data.monthChanger(1);
                        },
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                          color: kWhite,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.028,
                  ),
                  Expanded(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.04),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                        color: kWhite,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (data.budgetList.isEmpty)
                            const Center(
                              child: DisplayText(
                                title:
                                    "       You don't have any budgets.\n Let's create one so you're in control",
                              ),
                            )
                          else
                            Expanded(
                              child: ListView.builder(
                                itemCount: data.budgetList.length,
                                itemBuilder: (context, index) {
                                  BudgetSectionModel budget =
                                      data.budgetList[index];
                                  int totalExpenseForCategory =
                                      data.getTotalExpensesForCategory(context,
                                          budget.category!, data.currentMonth);
                                  int difference =
                                      data.getExpenseDifferenceForCategory(
                                          context,
                                          budget.category!,
                                          data.currentMonth);
                                  bool exceededLimit =
                                      budget.amount! > totalExpenseForCategory;

                                  if (budget.month == data.currentMonth) {
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                BudgetDetailsPage(
                                              amount: budget.amount,
                                              category: budget.category,
                                              month: budget.month,
                                              id: budget.id,
                                              totalExpence:
                                                  totalExpenseForCategory,
                                              remaining: difference,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: size.height * 0.03,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              OutlinedButton.icon(
                                                onPressed: () {},
                                                icon: const CircleAvatar(
                                                  radius: 10,
                                                  backgroundColor: kfirstColor,
                                                ),
                                                style: ButtonStyle(
                                                  side:
                                                      MaterialStateProperty.all(
                                                    BorderSide(
                                                      color:
                                                          Colors.grey.shade300,
                                                    ),
                                                  ),
                                                ),
                                                label: Text(
                                                  '${budget.category?.toUpperCase()}',
                                                  style: const TextStyle(
                                                    color: kblack,
                                                  ),
                                                ),
                                              ),
                                              exceededLimit
                                                  ? const SizedBox.shrink()
                                                  : const Icon(
                                                      Icons.error,
                                                      color: expenseColor,
                                                    ),
                                            ],
                                          ),
                                          DisplayText(
                                            title: 'Remaining \$$difference',
                                            textColor: kblack,
                                            textSize: 29,
                                            textFont: FontWeight.bold,
                                          ),
                                          CustomLinearProgressIndicator(
                                            value: totalExpenseForCategory /
                                                budget.amount!,
                                            backgroundColor:
                                                Colors.grey.shade300,
                                            waveColor: expenseColor,
                                          ),
                                          DisplayText(
                                            title:
                                                '\$$totalExpenseForCategory of \$${budget.amount}',
                                            textColor: kgrey,
                                            textSize: 19,
                                            textFont: FontWeight.bold,
                                          ),
                                          exceededLimit
                                              ? const SizedBox.shrink()
                                              : const DisplayText(
                                                  title:
                                                      'youve exceed the limit',
                                                  textColor: expenseColor,
                                                  textSize: 14,
                                                  textFont: FontWeight.bold,
                                                ),
                                          SizedBox(
                                            height: size.height * 0.1,
                                          )
                                        ],
                                      ),
                                    );
                                  } else {
                                    return const SizedBox.shrink();
                                  }
                                },
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 20,
                left: 15,
                right: 15,
                child: CustomElevatedButton(
                  onpressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(
                      builder: (context) => CreateBudgetPage(),
                    ))
                        .then(
                      (result) {
                        if (result != null &&
                            result.containsKey('newBudget') &&
                            result['newBudget'] is BudgetSectionModel) {
                          BudgetSectionModel newBudget = result['newBudget'];
                          data.addBudget(newBudget);
                        }
                      },
                    );
                  },
                  buttonText: 'Create a budget',
                  buttonColor: kfirstColor,
                  textColor: kWhite,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

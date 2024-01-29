// ignore_for_file: unused_local_variable, non_constant_identifier_names

import 'package:expence_app/View/Widgets/custome_elevated_button.dart';
import 'package:expence_app/View/Widgets/display_text.dart';
import 'package:expence_app/View/create_budget_page.dart';
import 'package:expence_app/const/colors.dart';
import 'package:expence_app/controller/provider/budget_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wave_linear_progress_indicator/wave_linear_progress_indicator.dart';

class BudgetDetailsPage extends StatelessWidget {
  const BudgetDetailsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    BudgetProvider BudgetDetailsPageProvider =
        Provider.of<BudgetProvider>(context);

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
                          height: size.height * 0.3,
                          width: size.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
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
                                  CustomElevatedButton(
                                    buttonWidth: size.width * 0.4,
                                    onpressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    buttonText: 'No',
                                  ),
                                  CustomElevatedButton(
                                    buttonWidth: size.width * 0.4,
                                    onpressed: () {},
                                    buttonText: 'Yes',
                                    textColor: kWhite,
                                    buttonColor: kfirstColor,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ));
                },
              );
            },
            icon: const Icon(
              Icons.delete,
              color: kblack,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: size.height * 0.03,
            ),
            Center(
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: Container(
                  height: size.height * 0.04,
                  width: size.width * 0.1,
                  color: Colors.grey.shade300,
                  margin: const EdgeInsets.all(10),
                ),
                style: ButtonStyle(
                  side: MaterialStateProperty.all(
                    BorderSide(
                      color: Colors.grey.shade200,
                    ),
                  ),
                ),
                label: const DisplayText(
                  title: "Shopping",
                  textColor: kblack,
                  textSize: 18,
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            const DisplayText(
              title: "Remaining",
              textSize: 24,
              textFont: FontWeight.w600,
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            const DisplayText(
              title: "\$0",
              textSize: 64,
              textFont: FontWeight.w600,
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            const WaveLinearProgressIndicator(
              value: 0.1,
              waveBackgroundColor: expenseColor,
              enableBounceAnimation: true,
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            Container(
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
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => CreateBudgetPage(),
                ));
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
  }
}

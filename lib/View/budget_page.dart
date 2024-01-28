// ignore_for_file: must_be_immutable, unused_local_variable
import 'package:expence_app/View/Widgets/custome_elevated_button.dart';
import 'package:expence_app/View/Widgets/display_text.dart';
import 'package:expence_app/View/create_budget_page.dart';
import 'package:expence_app/const/colors.dart';
import 'package:flutter/material.dart';

class BudgetPage extends StatelessWidget {
  const BudgetPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: kfirstColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: size.height * 0.12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    color: kWhite,
                  ),
                ),
                const DispalyText(
                  title: 'January',
                  textSize: 20,
                  textColor: kWhite,
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.arrow_forward_ios,
                    color: kWhite,
                  ),
                ),
              ],
            ),
            Container(
              height: size.height * 0.69,
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                color: kWhite,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: size.height * 0.15,
                  ),
                  const Center(
                    child: DispalyText(
                        title:
                            "     You don't have a budget. \n Let's make one so you in control"),
                  ),
                  SizedBox(
                    height: size.height * 0.15,
                  ),
                  CustomElevatedButton(
                    onpressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>  CreateBudgetPage()));
                    },
                    buttonText: 'Create a budget',
                    buttonColor: kfirstColor,
                    textColor: kWhite,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

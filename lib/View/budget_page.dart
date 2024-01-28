// ignore_for_file: must_be_immutable, unused_local_variable
import 'package:expence_app/Model/budget_section_model.dart';
import 'package:expence_app/View/Widgets/custome_elevated_button.dart';
import 'package:expence_app/View/Widgets/display_text.dart';
import 'package:expence_app/View/create_budget_page.dart';
import 'package:expence_app/const/colors.dart';
import 'package:flutter/material.dart';

// BudgetPage
class BudgetPage extends StatelessWidget {
  const BudgetPage({Key? key, required this.displayedBudget}) : super(key: key);

  final List<BudgetSectionModel> displayedBudget;

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
                const DisplayText(
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
                  Expanded(
                    child: displayedBudget.isEmpty
                        ? const Center(
                            child: DisplayText(
                                title:
                                    "You don't have a budget. Let's make one so you're in control"))
                        : ListView.separated(
                            shrinkWrap: true,
                            itemCount: displayedBudget.length,
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                height: size.height * 0.01,
                              );
                            },
                            itemBuilder: (context, index) {
                              final budget = displayedBudget[index];
                              return Column(
                                children: [
                                  ListTile(
                                    title: DisplayText(title: '${budget.Amount}'),
                                    subtitle: DisplayText(
                                        title: '${budget.Category}'),
                                  ),
                                ],
                              );
                            },
                          ),
                  ),
                  SizedBox(
                    height: size.height * 0.15,
                  ),
                  CustomElevatedButton(
                    onpressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CreateBudgetPage()));
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
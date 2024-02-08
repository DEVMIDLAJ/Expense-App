// ignore_for_file: must_be_immutable, unused_local_variable

import 'package:expence_app/Model/budget_section_model.dart';
import 'package:expence_app/View/Widgets/build_toggle_switch_section.dart';
import 'package:expence_app/View/Widgets/custom_snackbar.dart';
import 'package:expence_app/controller/provider/budget_provider.dart';
import 'package:flutter/material.dart';
import 'package:expence_app/View/Widgets/custom_drop_down_button.dart';
import 'package:expence_app/View/Widgets/custom_textform_feild.dart';
import 'package:expence_app/View/Widgets/custome_elevated_button.dart';
import 'package:expence_app/View/Widgets/display_text.dart';
import 'package:expence_app/const/colors.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:wave_linear_progress_indicator/wave_linear_progress_indicator.dart';

class CreateBudgetPage extends StatelessWidget {
  int? amount;
  String? category;
  CreateBudgetPage({
    super.key,
    this.amount,
    this.category,
  });

  final TextEditingController budgetController = TextEditingController();

  String? budgetDropdownValue;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    BudgetProvider createBudgetPageProvider =
        Provider.of<BudgetProvider>(context);

    return Consumer<BudgetProvider>(
        builder: (BuildContext context, data, Widget? _) {
      return Scaffold(
        appBar: AppBar(
          title: const DisplayText(
            title: 'Create Budget',
            textSize: 20,
            textColor: kWhite,
          ),
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: kWhite,
            ),
          ),
          centerTitle: true,
          backgroundColor: kfirstColor,
        ),
        backgroundColor: kfirstColor,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: size.height * 0.33,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: size.width * 0.08,
                ),
                child: const Text(
                  'How Much do you want to spend ?',
                  style: TextStyle(
                    color: kgrey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
                child: CustomTextFormField(
                  textfieldHight: 82,
                  controller: budgetController,
                  keybordType: TextInputType.number,
                  textFontSize: 64,
                  textFontColor: kWhite,
                  prefixIcon: const DisplayText(
                    title: '\$',
                    textSize: 64,
                    textFont: FontWeight.w600,
                    textColor: kWhite,
                  ),
                  hintFontsize: 64,
                  hintColor: kWhite,
                  hasBorder: false,
                  textValidator: (p0) {
                    return null;
                  },
                  cursorColor: kWhite,
                  obscureText: false,
                ),
              ),
              Container(
                height: size.height * 0.4,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: size.height * 0.02),
                    CustomDropDownButton(
                      categories: const [
                        'transaction',
                        'shopping',
                        'substription',
                        'transpotation',
                        'food',
                        'fuel',
                        'rent',
                        'Groceries',
                        'gifts',
                        "pharmacy",
                        "Kids",
                        "Education",
                        "Bills"
                      ],
                      hintText: "Select Category",
                      currentMonth: data.currentMonth,
                      onValueChanged: (newvalue) {
                        budgetDropdownValue = data.updateDropdown(newvalue);
                        data.removeCategoryForCurrentMonth(newvalue!);
                      },
                    ),
                    SizedBox(height: size.height * 0.03),
                    BuildToggleSwitch(
                      title: "Receive Alert",
                      subTitle: "Receive alert when it reaches some point.",
                      value: data.isLoading,
                      toggleChanged: (bool value) {
                        data.boolLoading();
                      },
                    ),
                    SizedBox(height: size.height * 0.05),
                    data.isLoading
                        ? StreamBuilder<double>(
                            stream: _getDownloadProgress(),
                            builder: (context, snapshot) {
                              double progress = 0.05;
                              if (snapshot.hasData) {
                                progress = snapshot.data!;
                              }
                              return WaveLinearProgressIndicator(
                                value: progress,
                                waveWidth: 8,
                                color: kfirstColor,
                                waveColor: kfirstColor,
                                waveBackgroundColor: kfirstColor,
                              );
                            },
                          )
                        : const SizedBox.shrink(),
                    const SizedBox(height: 20),
                    CustomElevatedButton(
                      onpressed: () {
                        if (budgetController.text.isEmpty ||
                            budgetDropdownValue == null) {
                          CustomSnackBar.show(
                            context,
                            'Please fill all the details',
                          );
                          return;
                        }
                        try {
                          int amount = int.parse(budgetController.text);
                          String currentMonth =
                              DateFormat('MMMM').format(DateTime.now());
                          BudgetSectionModel newBudget = BudgetSectionModel(
                            amount: amount,
                            category: budgetDropdownValue,
                            month: currentMonth,
                            id: DateTime.now().microsecondsSinceEpoch,
                          );
                          Navigator.of(context).pop({'newBudget': newBudget});
                        } catch (e) {
                          CustomSnackBar.show(
                            context,
                            'Invalid input. Please enter a valid number.',
                          );
                        }
                      },
                      buttonText: 'Continue',
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
    });
  }

  Stream<double> _getDownloadProgress() async* {
    final values = <double>[
      0,
      0.1,
      0.2,
      0.3,
      0.4,
      0.5,
      0.6,
      0.7,
      0.8,
      0.9,
      0.99,
      1.0
    ];
    for (final p in values) {
      yield p;
      await Future.delayed(
        const Duration(milliseconds: 500),
      );
    }
  }
}

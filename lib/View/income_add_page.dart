// ignore_for_file: must_be_immutable,
import 'package:expence_app/Model/transaction_datails_model.dart';
import 'package:expence_app/View/Widgets/build_toggle_switch_section.dart';
import 'package:expence_app/View/Widgets/display_text.dart';
import 'package:expence_app/View/main_page.dart';
import 'package:expence_app/View/Widgets/attachment.dart';
import 'package:expence_app/View/Widgets/custom_drop_down_button.dart';
import 'package:expence_app/View/Widgets/custom_snackbar.dart';
import 'package:expence_app/View/Widgets/custom_textform_feild.dart';
import 'package:expence_app/View/Widgets/custome_elevated_button.dart';
import 'package:expence_app/const/colors.dart';
import 'package:expence_app/controller/provider/auh_provider.dart';
import 'package:expence_app/controller/provider/transaction_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class IncomePage extends StatelessWidget {
  IncomePage({super.key});

  final TextEditingController incomeController = TextEditingController();

  final TextEditingController discriptionController = TextEditingController();

  String? categoryDropdownValue;

  String? amountTypeDropdownValue;


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    AuthProvider incomeProvider = Provider.of<AuthProvider>(context);
    TransactionProvider incomeTransactionProvider =
        Provider.of<TransactionProvider>(context);
    return Scaffold(
      backgroundColor: incomeColor,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: incomeColor,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: kWhite,
          ),
        ),
        title: const DisplayText(
          title: 'Income',
          textColor: kWhite,
          textSize: 18,
          textFont: FontWeight.w600,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: size.height * 0.07,
            ),
            Padding(
              padding: EdgeInsets.only(
                left: size.width * 0.08,
              ),
              child: const Text(
                'How Much?',
                style: TextStyle(
                  color: kWhite,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
              child: CustomTextFormField(
                textfieldHight: 80,
                controller: incomeController,
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
              height: size.height * 0.66,
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                color: kWhite,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomDropDownButton(
                    categories: const [
                      'salary',
                      'freelance Work',
                    ],
                    hintText: "Select Category",
                    onValueChanged: (newvalue) {
                      categoryDropdownValue =
                          incomeProvider.updateDropdown(newvalue);
                    },
                  ),
                  CustomTextFormField(
                    controller: discriptionController,
                    keybordType: TextInputType.text,
                    hintText: 'Description',
                    textValidator: (p0) {
                      return null;
                    },
                    obscureText: false,
                  ),
                  CustomDropDownButton(
                    categories: const [
                      'Wallet',
                      'Gpay',
                    ],
                    hintText: "Select Payment",
                    onValueChanged: (newvalue) {
                      amountTypeDropdownValue =
                          incomeProvider.updateDropdown(newvalue);
                    },
                  ),
                  const Attachment(),
                   Consumer<AuthProvider>(
                    builder: (context, data, _) {
                      return BuildToggleSwitch(
                        title: "Repeat",
                        subTitle: "Repeat Transaction",
                        value: data.isLoading,
                        toggleChanged: (bool value) {
                          data.boolLoading();
                        },
                      );
                    },
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  CustomElevatedButton(
                    onpressed: () {
                      if (incomeController.text.isEmpty ||
                          discriptionController.text.isEmpty ||
                          categoryDropdownValue == null ||
                          amountTypeDropdownValue == null) {
                        // Show a snackbar if any required field is empty
                        CustomSnackBar.show(
                          context,
                          'Please fill all the details',
                        );
                      } else {
                        // Create a new transaction based on the entered details
                        TransactionDetailsModel newTransaction =
                            TransactionDetailsModel(
                          amount: int.parse(incomeController.text),
                          category: categoryDropdownValue,
                          discription: discriptionController.text,
                          amountType: amountTypeDropdownValue,
                          time: DateFormat.jm().format(DateTime.now()),
                          status: 'Income',
                          date: DateFormat('yyyy-MM-dd').format(DateTime.now()),
                          id: DateTime.now().microsecondsSinceEpoch,
                        );

                        // Add the new transaction to the listR
                        incomeTransactionProvider.transactionDetailsList
                            .add(newTransaction);
                        incomeTransactionProvider
                            .incomeCarrier(newTransaction.amount!);
                        // Clear the input fields
                        incomeController.clear();
                        discriptionController.clear();
                        // Navigate to the main page
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MainPage(),
                          ),
                        );
                      }
                    },
                    buttonText: 'Continue',
                    buttonColor: kfirstColor,
                    textColor: kWhite,
                  ),
                  SizedBox(
                    height: size.height * 0.02,
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

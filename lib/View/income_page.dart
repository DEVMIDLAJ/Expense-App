// ignore_for_file: must_be_immutable

import 'package:expence_app/Model/transaction_datails_model.dart';
import 'package:expence_app/View/main_page.dart';
import 'package:expence_app/View/Widgets/attachment.dart';
import 'package:expence_app/View/Widgets/custom_drop_down_button.dart';
import 'package:expence_app/View/Widgets/custom_snackbar.dart';
import 'package:expence_app/View/Widgets/custom_textform_feild.dart';
import 'package:expence_app/View/Widgets/custome_elevated_button.dart';
import 'package:expence_app/const/colors.dart';
import 'package:expence_app/const/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// StatefulWidget for handling the Income page
class IncomePage extends StatefulWidget {
  const IncomePage({super.key});

  @override
  State<IncomePage> createState() => _IncomePageState();
}

// State class for the IncomePage widget
class _IncomePageState extends State<IncomePage> {
  final TextEditingController incomeController = TextEditingController();
  final TextEditingController discriptionController = TextEditingController();
  String? dropdownValue1;
  String? dropdownValue2;
  bool status = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: incomeColor,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: incomeColor,
        title: const Text(
          'Income',
          style: TextStyle(
            color: kWhite,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 35,
            ),
            const Padding(
              padding: EdgeInsets.only(
                left: 20,
              ),
              child: Text(
                'How Much?',
                style: TextStyle(
                  color: kWhite,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: CustomTextFormField(
                controller: incomeController,
                keybordType: TextInputType.number,
                textFontSize: 64,
                textFontColor: kWhite,
                prefixIcon: const Icon(
                  Icons.currency_rupee,
                  size: 64,
                  color: kWhite,
                ),
                hintText: '${0}',
                hintFontsize: 64,
                hintColor: kWhite,
                hasBorder: false,
                textValidator: (p0) {
                  return null;
                },
                obscureText: false,
              ),
            ),
            Container(
              height: 500,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 15),
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
                    listype: const [
                      'salary',
                      'freelance Work',
                    ],
                    buttonAction: (String? value) {
                      setState(() {
                        dropdownValue1 = value;
                      });
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
                    listype: const [
                      'Wallet',
                      'Gpay',
                    ],
                    buttonAction: (value) {
                      setState(() {
                        dropdownValue2 = value;
                      });
                    },
                  ),
                  const Attachment(),
                  SizedBox(
                    height: 45,
                    width: 400,
                    child: ListTile(
                      title: const Text('Repeat'),
                      subtitle: const Text('Repeat Transaction'),
                      trailing: CupertinoSwitch(
                        thumbColor: kWhite,
                        trackColor: Colors.black38,
                        activeColor: kfirstColor,
                        value: status,
                        onChanged: (value) {
                          setState(() {
                            status = value;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomElevatedButton(
                    onpressed: () {
                      if (incomeController.text.isEmpty ||
                          discriptionController.text.isEmpty ||
                          dropdownValue1 == null ||
                          dropdownValue2 == null) {
                        // Show a snackbar if any required field is empty
                        CustomSnackBar.show(
                          context,
                          'Please fill all the details',
                        );
                      } else {
                        // Create a new transaction based on the entered details
                        TransactionDetailsModel newTransaction =
                            TransactionDetailsModel(
                          Amount: int.parse(incomeController.text),
                          Category: dropdownValue1.toString(),
                          Discription: discriptionController.text,
                          AmountType: dropdownValue2.toString(),
                          Time: DateFormat.jm().format(DateTime.now()),
                          Status: 'Income',
                        );

                        // Add the new transaction to the list
                        TransactionDetailsList.add(newTransaction);

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
                  const SizedBox(
                    height: 10,
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

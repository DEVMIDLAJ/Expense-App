// ignore_for_file: non_constant_identifier_names, unnecessary_null_comparison

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

class ExpensePage extends StatefulWidget {
  const ExpensePage({
    super.key,
  });
  @override
  State<ExpensePage> createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage> {
  final TextEditingController ExpenseController = TextEditingController();
  final TextEditingController discriptionController = TextEditingController();
  String? dropdownvalue1;
  String? dropdownvalue2;
  bool status = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: expenseColor,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: expenseColor,
        title: const Text(
          'Expense',
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
                controller: ExpenseController,
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
                  color: kWhite),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomDropDownButton(
                    listype: const [
                      'transaction',
                      'shopping',
                      'substription',
                      'transpotation',
                      'food',
                      'fuel',
                      'rent'
                    ],
                    buttonAction: (String? value) {
                      setState(() {
                        dropdownvalue1 = value;
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
                    buttonAction: (String? value) {
                      setState(() {
                        dropdownvalue2 = value;
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
                      if (ExpenseController.text.isEmpty ||
                          discriptionController.text.isEmpty ||
                          dropdownvalue1 == null ||
                          dropdownvalue2 == null) {
                        CustomSnackBar.show(
                            context, 'Please fill all the details');
                      } else {
                        TransactionDetailsModel newTransaction =
                            TransactionDetailsModel(
                                Amount: int.parse(ExpenseController.text),
                                Category: dropdownvalue1.toString(),
                                Discription: discriptionController.text,
                                AmountType: dropdownvalue2.toString(),
                                Time: DateFormat.jm().format(DateTime.now()),
                                Status: 'Expense');
                        TransactionDetailsList.add(newTransaction);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return const MainPage();
                          }),
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

// ignore_for_file: non_constant_identifier_names, unnecessary_null_comparison, unused_local_variable

import 'package:expence_app/Model/transaction_datails_model.dart';
import 'package:expence_app/View/main_page.dart';
import 'package:expence_app/View/Widgets/attachment.dart';
import 'package:expence_app/View/Widgets/custom_drop_down_button.dart';
import 'package:expence_app/View/Widgets/custom_snackbar.dart';
import 'package:expence_app/View/Widgets/custom_textform_feild.dart';
import 'package:expence_app/View/Widgets/custome_elevated_button.dart';
import 'package:expence_app/Utils/colors.dart';
import 'package:expence_app/controller/provider/auh_provider.dart';
import 'package:expence_app/controller/provider/transaction_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ExpensePage extends StatelessWidget {
   ExpensePage({
    super.key,
  });
  final TextEditingController ExpenseController = TextEditingController();

  final TextEditingController discriptionController = TextEditingController();

  String? categoryDropdownValue;

  String? amountTypeDropdownValue;

  @override
  Widget build(BuildContext context) {
    AuthProvider expenseProvider = Provider.of<AuthProvider>(context);
    TransactionProvider expenseTransactionProvider =
        Provider.of<TransactionProvider>(context);

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
                color: kWhite,
              ),
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
                    onValueChanged: (newvalue) {
                      categoryDropdownValue =
                          expenseProvider.updateDropdown(newvalue);
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
                    onValueChanged: (newvalue) {
                      amountTypeDropdownValue =
                          expenseProvider.updateDropdown(newvalue);
                    },
                  ),
                  const Attachment(),
                  Consumer<AuthProvider>(
                    builder: (context,data,_) {
                      return SizedBox(
                        height: 45,
                        width: 400,
                        child: ListTile(
                          title: const Text('Repeat'),
                          subtitle: const Text('Repeat Transaction'),
                          trailing: CupertinoSwitch(
                            thumbColor: kWhite,
                            trackColor: Colors.black38,
                            activeColor: kfirstColor,
                            value: data.isChecked,
                            onChanged: (value) {
                             data.boolChecked();
                            },
                          ),
                        ),
                      );
                    }
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomElevatedButton(
                    onpressed: () {
                      if (ExpenseController.text.isEmpty ||
                          discriptionController.text.isEmpty ||
                          categoryDropdownValue == null ||
                          amountTypeDropdownValue == null) {
                        CustomSnackBar.show(
                            context, 'Please fill all the details');
                      } else {
                        TransactionDetailsModel newTransaction =
                            TransactionDetailsModel(
                          Amount: int.parse(ExpenseController.text),
                          Category: categoryDropdownValue.toString(),
                          Discription: discriptionController.text,
                          AmountType: amountTypeDropdownValue.toString(),
                          Time: DateFormat.jm().format(DateTime.now()),
                          Status: 'Expense',
                          Date: DateFormat('yyyy-MM-dd').format(DateTime.now()),
                        );

                        expenseTransactionProvider.transactionDetailsList
                            .add(newTransaction);
                        expenseTransactionProvider
                            .expenseCarrier(newTransaction.Amount!);

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

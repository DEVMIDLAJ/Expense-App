// ignore_for_file: unused_field, unused_local_variable, no_leading_underscores_for_local_identifiers, avoid_print

import 'package:expence_app/Model/transaction_datails_model.dart';
import 'package:expence_app/View/Widgets/custom_textform_feild.dart';
import 'package:expence_app/View/Widgets/display_text.dart';
import 'package:expence_app/const/colors.dart';
import 'package:expence_app/controller/provider/transaction_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransactionHistoryPage extends StatelessWidget {
  TransactionHistoryPage({super.key});

  final TextEditingController transactionController = TextEditingController();
  final TextEditingController _titleEditController = TextEditingController();
  final TextEditingController _subTitleEditController = TextEditingController();
  final TextEditingController _amountEditController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    TransactionProvider transactionHistoryProvider =
        Provider.of<TransactionProvider>(context);

    List<TransactionDetailsModel> displayedTransactions =
        transactionHistoryProvider.filteredTransactionsList.isNotEmpty
            ? transactionHistoryProvider.filteredTransactionsList
            : transactionHistoryProvider.transactionDetailsList.toList();

    // Group transactions by date
    Map<String, List<TransactionDetailsModel>> groupedTransactions =
        transactionHistoryProvider
            .groupTransactionsByDate(displayedTransactions.reversed.toList());
    // Extract date categories
    List<String> dateCategories = groupedTransactions.keys.toList();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            // leading: IconButton(
            // onPressed: () => Navigator.of(context).canPop(),
            // icon: const Icon(
            //   Icons.arrow_back_ios,
            //   color: kblack,
            // )),
          title: const DisplayText(
            title: "Transaction History",
            textSize: 18,
            textFont: FontWeight.bold,
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: size.width * 0.05),
              child: const Icon(Icons.filter_list),
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.only(left: size.width * 0.02),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
                child: CustomTextFormField(
                  controller: transactionController,
                  keybordType: TextInputType.text,
                  hintText: 'Search your transaction history',
                  hintColor: kgrey,
                  suffixIcon: const Icon(
                    Icons.search_rounded,
                  ),
                  onChanged: (value) {
                    // Trigger search when the text field content changes
                    transactionHistoryProvider.searchTransactions(value);
                  },
                  textValidator: (value) {
                    return value;
                  },
                  obscureText: false,
                ),
              ),
              Expanded(
                child: groupedTransactions.isEmpty
                    ? const Center(
                        child: DisplayText(
                          title: 'No transactions available.',
                          textSize: 16,
                          textFont: FontWeight.bold,
                          textColor: kblack,
                        ),
                      )
                    : ListView.builder(
                        itemCount: dateCategories.length,
                        itemBuilder: (context, categoryIndex) {
                          String dateCategory = dateCategories[categoryIndex];
                          List<TransactionDetailsModel> transactions =
                              groupedTransactions[dateCategory] ?? [];
                          return Column(
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: DisplayText(title: dateCategory),
                              ),
                              ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: transactions.length,
                                separatorBuilder: (context, index) {
                                  return SizedBox(
                                    height: size.height * 0.01,
                                  );
                                },
                                itemBuilder: (context, index) {
                                  TransactionDetailsModel transaction =
                                      transactions[index];

                                  Color textColor =
                                      transaction.Status == 'Income'
                                          ? incomeColor
                                          : expenseColor;

                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      ListTile(
                                        leading: Container(
                                          height: size.height * 0.06,
                                          width: size.width * 0.15,
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade200,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/${transaction.Category}.png'),
                                            ),
                                          ),
                                        ),
                                        title: DisplayText(
                                          title:
                                              transaction.Category.toString(),
                                          textSize: 16,
                                          textFont: FontWeight.w500,
                                        ),
                                        subtitle: DisplayText(
                                          title: transaction.Discription
                                              .toString(),
                                          textSize: 13,
                                          textFont: FontWeight.w500,
                                          textColor: kgrey,
                                        ),
                                        trailing: Row(
                                          // Use Row to add multiple widgets to the trailing property
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                DisplayText(
                                                  title:
                                                      "- \$${transaction.Amount}",
                                                  textSize: 16,
                                                  textFont: FontWeight.w600,
                                                  textColor: textColor,
                                                ),
                                                DisplayText(
                                                  title: transaction.Time
                                                      .toString(),
                                                  textSize: 13,
                                                  textFont: FontWeight.w500,
                                                  textColor: kgrey,
                                                ),
                                              ],
                                            ),
                                            PopupMenuButton(
                                              itemBuilder:
                                                  (BuildContext context) {
                                                return [
                                                  PopupMenuItem(
                                                    child: ListTile(
                                                      leading: const Icon(
                                                          Icons.edit),
                                                      title: const Text('Edit'),
                                                      onTap: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                        transactionUpdateDialogBox(
                                                          transaction.Amount
                                                              .toString(),
                                                          transaction.Category
                                                              .toString(),
                                                          transaction
                                                                  .Discription
                                                              .toString(),
                                                          transaction.Status
                                                              .toString(),
                                                          transaction.Date
                                                              .toString(),
                                                          transaction.Time
                                                              .toString(),
                                                          transaction.AmountType
                                                              .toString(),
                                                          transactionHistoryProvider,
                                                          transaction.Id!,
                                                          context,
                                                        );
                                                        print(
                                                            "${transaction.Id.toString()}......1");
                                                      },
                                                    ),
                                                  ),
                                                  PopupMenuItem(
                                                    child: ListTile(
                                                      leading: const Icon(
                                                          Icons.delete),
                                                      title:
                                                          const Text('Delete'),
                                                      onTap: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                        transactionDeleteDialogBox(
                                                            transactionHistoryProvider,
                                                            transaction.Id!,
                                                            context);
                                                      },
                                                    ),
                                                  ),
                                                ];
                                              },
                                              child: const Icon(
                                                Icons.more_vert,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              DisplayText(
                                                title:
                                                    transaction.Date.toString(),
                                                textSize: 13,
                                                textFont: FontWeight.w500,
                                                textColor: kgrey,
                                              ),
                                              DisplayText(
                                                title:
                                                    transaction.Id.toString(),
                                                textSize: 13,
                                                textFont: FontWeight.w500,
                                                textColor: kgrey,
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: size.width * 0.06,
                                          )
                                        ],
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ],
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> transactionDeleteDialogBox(
    TransactionProvider provider,
    int transactionId,
    BuildContext context,
  ) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Delete"),
          content: const SizedBox(
            height: 50,
            child: Text("Are you sure you wanna remove this transaction ?"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("cancel"),
            ),
            TextButton(
              onPressed: () {
                provider.deleteTransaction(transactionId);
                Navigator.of(context).pop();
              },
              child: const Text("delete"),
            ),
          ],
        );
      },
    );
  }

  Future<void> transactionUpdateDialogBox(
    String amount,
    String title,
    String subTitle,
    String status,
    String date,
    String time,
    String amoutType,
    TransactionProvider provider,
    int transactionId,
    BuildContext context,
  ) async {
    final TextEditingController _amountEditController =
        TextEditingController(text: amount);
    final TextEditingController _subTitleEditController =
        TextEditingController(text: subTitle);

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Update"),
          content: SizedBox(
            height: 180,
            child: Column(
              children: [
                // const SizedBox(
                //   height: 10,
                // ),
                CustomTextFormField(
                  controller: _amountEditController,
                  keybordType: TextInputType.number,
                  labelText: "Edit Transaction Amount",
                  hintColor: kgrey,
                  textValidator: (p0) {
                    return null;
                  },
                  obscureText: false,
                ),
                CustomTextFormField(
                  controller: _subTitleEditController,
                  keybordType: TextInputType.text,
                  labelText: "Edit Transaction subTitle",
                  hintColor: kgrey,
                  textValidator: (p0) {
                    return null;
                  },
                  obscureText: false,
                )
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("cancel"),
            ),
            TextButton(
              onPressed: () {
                String updatedAmount = _amountEditController.text;
                String updatedSubtitle = _subTitleEditController.text;

                TransactionDetailsModel updatedTransaction =
                    TransactionDetailsModel(
                  Id: transactionId,
                  Category: title,
                  Discription: updatedSubtitle,
                  Amount: int.tryParse(updatedAmount) ?? 0,
                  Date: date,
                  Time: time,
                  Status: status,
                  AmountType: amoutType,
                );

                provider.updateTransaction(transactionId, updatedAmount, title,
                    updatedSubtitle, status, date, time, amoutType);

                int kAmount = int.parse(amount);
                int kUpdatedAmount = int.parse(updatedAmount);

                // Update the main balance
                kAmount > kUpdatedAmount
                    ? provider.mainBalance -= kAmount - kUpdatedAmount
                    : provider.mainBalance += kUpdatedAmount - kAmount;
                print('${kAmount.toString()}....kamount');
                print('${kUpdatedAmount.toString()}.....kUpdateAmout');
                print("${provider.mainBalance.toString()}......mainbalance");

                Navigator.of(context).pop();
              },
              child: const Text("Update"),
            ),
          ],
        );
      },
    );
  }
}

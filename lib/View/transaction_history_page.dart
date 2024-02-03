
import 'package:expence_app/Model/transaction_datails_model.dart';
import 'package:expence_app/View/Widgets/custom_textform_feild.dart';
import 'package:expence_app/View/Widgets/display_text.dart';
import 'package:expence_app/View/Widgets/transaction_delete_dialog_box.dart';
import 'package:expence_app/View/Widgets/transaction_update_dialog_box.dart';
import 'package:expence_app/const/colors.dart';
import 'package:expence_app/controller/provider/transaction_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransactionHistoryPage extends StatelessWidget {
  TransactionHistoryPage({super.key});

  final TextEditingController transactionController = TextEditingController();
  final TextEditingController titleEditController = TextEditingController();
  final TextEditingController subTitleEditController = TextEditingController();
  final TextEditingController amountEditController = TextEditingController();

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
                                      transaction.status == 'Income'
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
                                                  'assets/${transaction.category}.png'),
                                            ),
                                          ),
                                        ),
                                        title: DisplayText(
                                          title:
                                              transaction.category.toString(),
                                          textSize: 16,
                                          textFont: FontWeight.w500,
                                        ),
                                        subtitle: DisplayText(
                                          title: transaction.discription
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
                                                      "- \$${transaction.amount}",
                                                  textSize: 16,
                                                  textFont: FontWeight.w600,
                                                  textColor: textColor,
                                                ),
                                                DisplayText(
                                                  title: transaction.time
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
                                                          transaction.amount
                                                              .toString(),
                                                          transaction.category
                                                              .toString(),
                                                          transaction
                                                              .discription
                                                              .toString(),
                                                          transaction.status
                                                              .toString(),
                                                          transaction.date
                                                              .toString(),
                                                          transaction.time
                                                              .toString(),
                                                          transaction.amountType
                                                              .toString(),
                                                          transactionHistoryProvider,
                                                          transaction.id!,
                                                          context,
                                                        );
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
                                                          transaction.id!,
                                                          context,
                                                        );
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
                                                    transaction.date.toString(),
                                                textSize: 13,
                                                textFont: FontWeight.w500,
                                                textColor: kgrey,
                                              ),
                                              DisplayText(
                                                title:
                                                    transaction.id.toString(),
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

  Future<void> transactionUpdateDialogBox(
    String amount,
    String title,
    String subTitle,
    String status,
    String date,
    String time,
    String amountType,
    TransactionProvider provider,
    int transactionId,
    BuildContext context,
  ) async {
    showDialog(
      context: context,
      builder: (context) => TransactionUpdateDialog(
        amount: amount,
        subTitle: subTitle,
        transactionId: transactionId,
        onUpdate: (updatedAmount, updatedSubtitle) {
          // Update your transaction here
          provider.updateTransaction(
            transactionId,
            updatedAmount,
            title,
            updatedSubtitle,
            status,
            date,
            time,
            amountType,
          );

          int kAmount = int.parse(amount);
          int kUpdatedAmount = int.parse(updatedAmount);

          // Update the main balance
          if (kAmount > kUpdatedAmount && status == "Income") {
            provider.mainBalance -= kAmount - kUpdatedAmount;
          } else if (kUpdatedAmount > kAmount && status == "Income") {
            provider.mainBalance += kUpdatedAmount - kAmount;
          } else if (kAmount > kUpdatedAmount && status == "Expense") {
            provider.mainBalance += kAmount - kUpdatedAmount;
          } else {
            provider.mainBalance -= kUpdatedAmount - kAmount;
          }
        },
      ),
    );
  }

  Future<void> transactionDeleteDialogBox(
    TransactionProvider provider,
    int transactionId,
    BuildContext context,
  ) async {
    showDialog(
      context: context,
      builder: (context) => TransactionDeleteDialog(
        transactionId: transactionId,
        onDelete: (deletedTransactionId) {
          // Delete your transaction here
          provider.deleteTransaction(deletedTransactionId);
        },
      ),
    );
  }
}


import 'package:expence_app/Model/transaction_datails_model.dart';
import 'package:expence_app/View/Widgets/custom_drop_down_button.dart';
import 'package:expence_app/View/Widgets/custom_textform_feild.dart';
import 'package:expence_app/View/Widgets/display_text.dart';
import 'package:expence_app/Utils/colors.dart';
import 'package:expence_app/controller/provider/transaction_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransactionHistoryPage extends StatelessWidget {
  TransactionHistoryPage({super.key});

  final TextEditingController transactionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TransactionProvider transactionHistoryProvider =
        Provider.of<TransactionProvider>(context);

    // Group transactions by date
    Map<String, List<TransactionDetailsModel>> groupedTransactions =
        transactionHistoryProvider.groupTransactionsByDate(
            transactionHistoryProvider.transactionDetailsList.reversed
                .toList());

    // Extract date categories
    List<String> dateCategories = groupedTransactions.keys.toList();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: CustomDropDownButton(
            listype: const [
              'January',
              'February',
              'March',
              'April',
              'May',
              'June',
              'July',
              'August',
              'September',
              'October',
              'November',
              'December',
            ],
            buttonWidth: 110,
            hasBorder: false,
            onValueChanged: (newvalue) {},
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 25),
              child: Icon(Icons.filter_list),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextFormField(
                controller: transactionController,
                keybordType: TextInputType.text,
                hintText: 'See your financial report',
                suffixIcon: const Icon(Icons.arrow_forward_ios),
                textValidator: (p0) {
                  return p0;
                },
                obscureText: false,
              ),
              Expanded(
                child: groupedTransactions.isEmpty
                    ? const Center(
                        child: DispalyText(
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: DispalyText(title: dateCategory),
                              ),
                              ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: transactions.length,
                                separatorBuilder: (context, index) {
                                  return const SizedBox(
                                    height: 10,
                                  );
                                },
                                itemBuilder: (context, index) {
                                  TransactionDetailsModel transaction =
                                      transactions[index];

                                  Color textColor =
                                      transaction.Status == 'Income'
                                          ? incomeColor
                                          : expenseColor;

                                  return ListTile(
                                    leading: Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                        borderRadius: BorderRadius.circular(15),
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'assets/${transaction.Category}.png'),
                                        ),
                                      ),
                                    ),
                                    title: DispalyText(
                                      title: transaction.Category.toString(),
                                      textSize: 16,
                                      textFont: FontWeight.w500,
                                    ),
                                    subtitle: DispalyText(
                                      title: transaction.Discription.toString(),
                                      textSize: 13,
                                      textFont: FontWeight.w500,
                                      textColor: kgrey,
                                    ),
                                    trailing: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        DispalyText(
                                          title: "- \$${transaction.Amount}",
                                          textSize: 16,
                                          textFont: FontWeight.w600,
                                          textColor: textColor,
                                        ),
                                        DispalyText(
                                          title: transaction.Time.toString(),
                                          textSize: 13,
                                          textFont: FontWeight.w500,
                                          textColor: kgrey,
                                        ),
                                      ],
                                    ),
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
}

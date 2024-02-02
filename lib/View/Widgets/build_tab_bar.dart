import 'package:expence_app/Model/transaction_datails_model.dart';
import 'package:expence_app/View/Widgets/display_text.dart';
import 'package:expence_app/const/colors.dart';
import 'package:expence_app/controller/provider/transaction_provider.dart';
import 'package:flutter/material.dart';

Widget buildTabContent(BuildContext context, TransactionProvider provider,
    DateCategory dateCategory) {
  List<TransactionDetailsModel> filteredTransactions =
      provider.getTransactionByDateCategory(dateCategory);

  return filteredTransactions.isEmpty
      ? SizedBox(
          height: MediaQuery.of(context).size.height * 0.23,
          child: const Center(
            child: DisplayText(
              title: 'No transactions available.',
              textSize: 16,
              textFont: FontWeight.bold,
              textColor: kblack,
            ),
          ),
        )
      : SizedBox(
          height: MediaQuery.of(context).size.height * 0.20,
          width: double.infinity,
          child: ListView.separated(
            itemCount: filteredTransactions.length > 3
                ? 3
                : filteredTransactions.length,
            separatorBuilder: (context, index) {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              );
            },
            itemBuilder: (context, index) {
              TransactionDetailsModel transaction = filteredTransactions[index];

              Color textColor =
                  transaction.status == 'Income' ? incomeColor : expenseColor;
              return ListTile(
                leading: Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.15,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: AssetImage('assets/${transaction.category}.png'),
                    ),
                  ),
                ),
                title: DisplayText(
                  title: transaction.category.toString(),
                  textSize: 16,
                  textFont: FontWeight.w500,
                ),
                subtitle: DisplayText(
                  title: transaction.discription.toString(),
                  textSize: 13,
                  textFont: FontWeight.w500,
                  textColor: kgrey,
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DisplayText(
                      title: "- \$${transaction.amount}",
                      textSize: 16,
                      textFont: FontWeight.w600,
                      textColor: textColor,
                    ),
                    DisplayText(
                      title: transaction.time.toString(),
                      textSize: 13,
                      textFont: FontWeight.w500,
                      textColor: kgrey,
                    ),
                  ],
                ),
              );
            },
          ),
        );
}

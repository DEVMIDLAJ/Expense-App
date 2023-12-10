import 'package:expence_app/Model/transaction_datails_model.dart';
import 'package:expence_app/View/Widgets/custom_textform_feild.dart';
import 'package:expence_app/View/Widgets/display_text.dart';
import 'package:expence_app/const/colors.dart';
import 'package:expence_app/const/utils.dart';
import 'package:flutter/material.dart';

class TransactionHistoryPage extends StatelessWidget {
  TransactionHistoryPage({super.key});

  final TextEditingController transactionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
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
              TransactionDetailsList.isEmpty
                  ? const Center(
                      child: DispalyText(
                        title: 'No transactions available.',
                        textSize: 16,
                        textFont: FontWeight.bold,
                        textColor: kblack,
                      ),
                    )
                  : ListView.separated(
                      itemCount: TransactionDetailsList.length,
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 10,
                        );
                      },
                      itemBuilder: (context, index) {
                        TransactionDetailsModel transaction =
                            TransactionDetailsList[index];

                        Color textColor = transaction.Status == 'Income'
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
                            mainAxisAlignment: MainAxisAlignment.center,
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
          ),
        ),
      ),
    );
  }
}

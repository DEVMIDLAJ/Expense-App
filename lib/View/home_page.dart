// ignore_for_file: must_be_immutable

import 'package:expence_app/View/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:expence_app/Model/transaction_datails_model.dart';
import 'package:expence_app/View/Widgets/custom_drop_down_button.dart';
import 'package:expence_app/View/Widgets/display_text.dart';
import 'package:expence_app/View/Widgets/income_expence_status_card.dart';
import 'package:expence_app/View/Widgets/line_chart.dart';
import 'package:expence_app/View/Widgets/profile_url_display.dart';
import 'package:expence_app/View/transaction_history_page.dart';
import 'package:expence_app/const/colors.dart';
import 'package:expence_app/controller/provider/transaction_provider.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  String dropdownvalue = 'January';

  List<String> month = [
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
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TransactionProvider homeTransactionProvider =
        Provider.of<TransactionProvider>(context);

    return DefaultTabController(
      length: 4,
      child: WillPopScope(
        onWillPop: () async {
          SystemNavigator.pop();
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            leading: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7),
              child: ProfileUrlDisplay(
                radiusOne: 15,
                radiusTwo: 17,
                buttonAction: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ProfilePage(),
                    ),
                  );
                },
              ),
            ),
            actions: [
              const Icon(
                Icons.notifications,
                color: kfirstColor,
              ),
              SizedBox(
                width: size.width * 0.05,
              ),
            ],
            title: CustomDropDownButton(
              listype: month,
              hintText: '',
              buttonWidth: size.width * 0.3,
              hasBorder: false,
              onValueChanged: (newvalue) {},
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: DispalyText(
                    title: 'Account Balance',
                    textColor: Colors.grey[600],
                    textFont: FontWeight.w500,
                  ),
                ),
                DispalyText(
                  title: '\$${homeTransactionProvider.mainBalance}',
                  textSize: 35,
                  textFont: FontWeight.bold,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IncomeAndExpenseStatusCard(
                      statusName: 'Income',
                      statusAmount: '\$${homeTransactionProvider.finalIncome}',
                      statusImage: 'assets/income.png',
                      statusCardColor: incomeColor,
                    ),
                    IncomeAndExpenseStatusCard(
                      statusName: 'Expense',
                      statusAmount: '\$${homeTransactionProvider.finalExpense}',
                      statusImage: 'assets/expense.png',
                      statusCardColor: expenseColor,
                    ),
                  ],
                ),
                const Align(
                  alignment: Alignment.bottomLeft,
                  child: DispalyText(
                    title: 'Spended Frequency',
                    textSize: 22,
                    textFont: FontWeight.bold,
                  ),
                ),
                const LineChartHome(),
                TabBar(
                  dividerColor: Colors.transparent,
                  splashBorderRadius: const BorderRadius.all(
                    Radius.circular(120),
                  ),
                  splashFactory: NoSplash.splashFactory,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorPadding: const EdgeInsets.all(7),
                  indicator: BoxDecoration(
                    color: const Color.fromARGB(255, 237, 219, 191),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  labelColor: Colors.black54,
                  unselectedLabelColor: Colors.black45,
                  tabs: const [
                    Tab(text: 'Today'),
                    Tab(text: 'Week'),
                    Tab(text: 'Month'),
                    Tab(text: 'Year'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const DispalyText(
                      title: 'Recent Frequency',
                      textSize: 22,
                      textFont: FontWeight.bold,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => TransactionHistoryPage()));
                      },
                      child: const Text('See All'),
                    ),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      buildTabContent(
                          context, homeTransactionProvider, DateCategory.Today),
                      buildTabContent(context, homeTransactionProvider,
                          DateCategory.ThisWeek),
                      buildTabContent(context, homeTransactionProvider,
                          DateCategory.ThisMonth),
                      buildTabContent(context, homeTransactionProvider,
                          DateCategory.ThisYear),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTabContent(BuildContext context, TransactionProvider provider,
      DateCategory dateCategory) {
    List<TransactionDetailsModel> filteredTransactions =
        provider.getTransactionByDateCategory(dateCategory);

    return filteredTransactions.isEmpty
        ? SizedBox(
            height: MediaQuery.of(context).size.height * 0.23,
            child: const Center(
              child: DispalyText(
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
                TransactionDetailsModel transaction =
                    filteredTransactions[index];

                Color textColor =
                    transaction.Status == 'Income' ? incomeColor : expenseColor;
                return ListTile(
                  leading: Container(
                    height: MediaQuery.of(context).size.height * 0.06,
                    width: MediaQuery.of(context).size.width * 0.15,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        image: AssetImage('assets/${transaction.Category}.png'),
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
          );
  }
}

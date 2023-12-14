// ignore_for_file: unused_local_variable, must_be_immutable

import 'package:expence_app/Model/transaction_datails_model.dart';
import 'package:expence_app/View/Widgets/custom_drop_down_button.dart';
import 'package:expence_app/View/Widgets/profile_url_display.dart';
import 'package:expence_app/View/profile_page.dart';
import 'package:expence_app/View/Widgets/display_text.dart';
import 'package:expence_app/View/Widgets/income_expence_status_card.dart';
import 'package:expence_app/View/Widgets/line_chart.dart';
import 'package:expence_app/View/transaction_history_page.dart';
import 'package:expence_app/Utils/colors.dart';
import 'package:expence_app/controller/provider/transaction_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
   HomePage({super.key});

  // default selected dropdown
  String dropdownvalue = 'January';

  // appbar dropdown list
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
    var homeTransactionProvider = Provider.of<TransactionProvider>(context);

    return DefaultTabController(
      length: 4,
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
          actions: const [
            Icon(
              Icons.notifications,
              color: kfirstColor,
            ),
            SizedBox(
              width: 15,
            ),
          ],
          // appbar dropdown button
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
        ),
        body: WillPopScope(
          onWillPop: () async {
            SystemNavigator.pop();
            return true;
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    // account balance text
                    child: DispalyText(
                      title: 'Account Balance',
                      textColor: Colors.grey[600],
                      textFont: FontWeight.w500,
                    ),
                  ),
                  // mainbalence text
                  DispalyText(
                    title: '\$${homeTransactionProvider.mainBalance}',
                    textSize: 35,
                    textFont: FontWeight.bold,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //income status card
                      IncomeAndExpenseStatusCard(
                        statusName: 'Income',
                        statusAmount:
                            '\$${homeTransactionProvider.finalIncome}',
                        statusImage: 'assets/income.png',
                        statusCardColor: incomeColor,
                      ),
                      IncomeAndExpenseStatusCard(
                        statusName: 'Expense',
                        statusAmount:
                            '\$${homeTransactionProvider.finalExpense}',
                        statusImage: 'assets/expense.png',
                        statusCardColor: expenseColor,
                      ),
                    ],
                  ),
                  // spendedfrequency text
                  const Align(
                    alignment: Alignment.bottomLeft,
                    child: DispalyText(
                      title: 'Spended Frequency',
                      textSize: 22,
                      textFont: FontWeight.bold,
                    ),
                  ),
                  //called line chart
                  const LineChartHome(),
                  // screen tabbar
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
                      // resent freuency text
                      const DispalyText(
                        title: 'Resent Frequency',
                        textSize: 22,
                        textFont: FontWeight.bold,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => TransactionHistoryPage()));
                        },
                        child: const Text(
                          'See All',
                        ),
                      ),
                    ],
                  ),
                  homeTransactionProvider.transactionDetailsList.isEmpty
                      ? const SizedBox(
                          height: 170,
                          child: Center(
                            child: DispalyText(
                              title: 'No transactions available.',
                              textSize: 16,
                              textFont: FontWeight.bold,
                              textColor: kblack,
                            ),
                          ),
                        )
                      : SizedBox(
                          height: 170,
                          width: double.infinity,
                          child: ListView.separated(
                            itemCount: homeTransactionProvider
                                        .transactionDetailsList.length >
                                    3
                                ? 3
                                : homeTransactionProvider
                                    .transactionDetailsList.length,
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                height: 10,
                              );
                            },
                            itemBuilder: (context, index) {
                              TransactionDetailsModel transaction =
                                  homeTransactionProvider
                                      .transactionDetailsList.reversed
                                      .toList()[index];

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
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: must_be_immutable, unused_local_variable

import 'package:expence_app/View/Widgets/build_tab_bar.dart';
import 'package:expence_app/View/profile_page.dart';
import 'package:flutter/material.dart';
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
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TransactionProvider homeTransactionProvider =
        Provider.of<TransactionProvider>(context);

    return Consumer(
      builder: (BuildContext context, TransactionProvider data, Widget? _) {
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
                title: DisplayText(
                  title: data.formattedMonthDay,
                  textSize: 20,
                  textFont: FontWeight.w800,
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: DisplayText(
                        title: 'Account Balance',
                        textColor: Colors.grey[600],
                        textFont: FontWeight.w500,
                      ),
                    ),
                    DisplayText(
                      title: '\$${data.mainBalance}',
                      textSize: 35,
                      textFont: FontWeight.bold,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IncomeAndExpenseStatusCard(
                          statusName: 'Income',
                          statusAmount: '\$${data.finalIncome}',
                          statusImage: 'assets/income.png',
                          statusCardColor: incomeColor,
                        ),
                        IncomeAndExpenseStatusCard(
                          statusName: 'Expense',
                          statusAmount: '\$${data.finalExpense}',
                          statusImage: 'assets/expense.png',
                          statusCardColor: expenseColor,
                        ),
                      ],
                    ),
                    const Align(
                      alignment: Alignment.bottomLeft,
                      child: DisplayText(
                        title: 'Spended Frequency',
                        textSize: 22,
                        textFont: FontWeight.bold,
                      ),
                    ),
                    const LineChartHome(),
                    TabBar(
                      dividerColor: Colors.transparent,
                      splashBorderRadius: const BorderRadius.all(
                        Radius.circular(100),
                      ),
                      splashFactory: NoSplash.splashFactory,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicatorPadding: const EdgeInsets.all(6),
                      indicator: BoxDecoration(
                        color: const Color.fromARGB(255, 237, 219, 191),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      labelColor: Colors.black54,
                      unselectedLabelColor: Colors.black45,
                      tabs: const [
                        Tab(text: 'Today'),
                        Tab(text: 'Yesterday'),
                        Tab(text: 'Week'),
                        Tab(text: 'Month'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const DisplayText(
                          title: 'Recent Frequency',
                          textSize: 22,
                          textFont: FontWeight.bold,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    TransactionHistoryPage()));
                          },
                          child: const Text('See All'),
                        ),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          buildTabContent(
                            context,
                            data,
                            DateCategory.Today,
                          ),
                          buildTabContent(
                            context,
                            data,
                            DateCategory.ThisWeek,
                          ),
                          buildTabContent(
                            context,
                            data,
                            DateCategory.ThisMonth,
                          ),
                          buildTabContent(
                            context,
                            data,
                            DateCategory.ThisYear,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

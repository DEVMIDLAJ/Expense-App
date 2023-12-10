
import 'package:expence_app/Model/transaction_datails_model.dart';
import 'package:expence_app/View/profile_page.dart';
import 'package:expence_app/View/Widgets/display_text.dart';
import 'package:expence_app/View/Widgets/income_expence_status_card.dart';
import 'package:expence_app/View/Widgets/line_chart.dart';
import 'package:expence_app/View/transaction_history_page.dart';
import 'package:expence_app/const/colors.dart';
import 'package:expence_app/const/utils.dart';
import 'package:expence_app/controller/provider/transaction_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
    return Consumer<TransactionProvider>(builder: (context, data, _) {
      return DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            leading: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ProfilePage(),
                  ),
                );
              },
              child: const Padding(
                padding: EdgeInsets.only(left: 15, top: 10),
                child: CircleAvatar(
                  radius: 15,
                  backgroundColor: kfirstColor,
                  child: CircleAvatar(
                    radius: 17,
                  ),
                ),
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
            title: DropdownButton(
              value: dropdownvalue,
              icon: const Icon(Icons.keyboard_arrow_down),
              items: month.map((String month) {
                return DropdownMenuItem(
                  value: month,
                  child: Text(month),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownvalue = newValue!;
                });
              },
            ),
          ),
          body: SingleChildScrollView(
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
                    title: '\$${data.calculateIncomeExpenseBalance()}',
                    textSize: 35,
                    textFont: FontWeight.bold,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //income status card
                      IncomeAndExpenseStatusCard(
                        statusName: 'Income',
                        statusAmount: '\$${data.calculateIncome()}',
                        statusImage: 'assets/income.png',
                        statusCardColor: incomeColor,
                      ),
                      IncomeAndExpenseStatusCard(
                        statusName: 'Expense',
                        statusAmount: '\$${data.calculateExpense()}',
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
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => TransactionHistoryPage()));
                        },
                        child: const Text(
                          'See All',
                        ),
                      ),
                    ],
                  ),
                  TransactionDetailsList.isEmpty
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
                            itemCount: TransactionDetailsList.length > 3
                                ? 3
                                : TransactionDetailsList.length,
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
                                    image:  DecorationImage(
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
                        ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

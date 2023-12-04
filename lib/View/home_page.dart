

import 'package:expence_app/Widgets/display_text.dart';
import 'package:expence_app/Widgets/income_expence_status_card.dart';
import 'package:expence_app/Widgets/line_chart.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  //final Functions obj;
  const HomePage({
    super.key,
    // required this.obj,
  });
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
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          actions: const [
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Icon(
                Icons.notifications,
                color: Color(0xFF713FC6),
              ),
            )
          ],
          leading: const Padding(
            padding: EdgeInsets.all(25.0),
            child: Icon(
              Icons.person_2_rounded,
              color: Color.fromARGB(255, 113, 63, 198),
            ),
          ),
          backgroundColor: Colors.white,
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
        // bottomNavigationBar: Bottonnav(
        //   obj: widget.obj,
        // ),

        body: SingleChildScrollView(
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
              const DispalyText(
                title: '${22000}',
                textSize: 35,
                textFont: FontWeight.bold,
              ),
               const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //income status card
                  IncomeAndExpenseStatusCard(
                    statusIcon: Icons.unarchive,
                    statusCardColor: Colors.green,
                    statusName: 'Income',
                    statusAmount: '${5445}',
                  ),
                  //Expense status card
                  IncomeAndExpenseStatusCard(
                    statusIcon: Icons.move_to_inbox,
                    statusCardColor: Colors.red,
                    statusName: 'Expense',
                    statusAmount: '${4876}',
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
                  splashBorderRadius:
                      const BorderRadius.all(Radius.circular(120)),
                  splashFactory: NoSplash.splashFactory,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorPadding: const EdgeInsets.all(7),
                  indicator: BoxDecoration(
                      color: const Color.fromARGB(255, 237, 219, 191),
                      borderRadius: BorderRadius.circular(20)),
                  labelColor: Colors.black54,
                  unselectedLabelColor: Colors.black45,
                  tabs: const [
                    Tab(text: 'Today'),
                    Tab(text: 'Week'),
                    Tab(text: 'Month'),
                    Tab(text: 'Year')
                  ]),
                  // TabBarView(children: [
                  //                       Text('one'),
                  //                       Text('two'),Text('three'),Text('four'),

                  // ]),
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
                    onPressed: () {},
                    child: const Text(
                      'See All',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
       
      ),
    );
  }
}


import 'package:expence_app/View/fourth_page.dart';
import 'package:expence_app/View/home_page.dart';
import 'package:expence_app/View/second_page.dart';
import 'package:expence_app/View/theird_page.dart';
import 'package:expence_app/Widgets/custom_bottom_navigation_bar.dart';
import 'package:expence_app/Widgets/custom_floating_action_button.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selectedIndex = 0;
  List<Widget> pages = <Widget>[
    const HomePage(),
    const Second(),
    const Theird(),
    const Fourth()
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Scaffold(
        
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: const CustomFloatingActionButton(
            ),
            bottomNavigationBar: CustumBottomNavigationBar(
          buttonAction: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
        ),
        body: pages.elementAt(selectedIndex),
      ),
    );
  }
}

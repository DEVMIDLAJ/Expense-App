// ignore_for_file: must_be_immutable
import 'package:expence_app/const/colors.dart';
import 'package:expence_app/controller/provider/auh_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustumBottomNavigationBar extends StatelessWidget {

  const CustumBottomNavigationBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, data, _) {
        return BottomNavigationBar(
          elevation: 0,
          currentIndex: data.selectedIndex,
          onTap: (value) {
            data.setIndex(value);
          },
          selectedItemColor: kfirstColor,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          unselectedLabelStyle: const TextStyle(
            color: Colors.grey,
          ),
          items: [
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/home.png',
                color:
                    data.selectedIndex == 0 ? Colors.deepPurple : Colors.grey,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/transaction2.png',
                color:
                    data.selectedIndex == 1 ? Colors.deepPurple : Colors.grey,
              ),
              label: 'Transaction',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/pie chart.png',
                color:
                    data.selectedIndex == 2 ? Colors.deepPurple : Colors.grey,
              ),
              label: 'Budget',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/user.png',
                color:
                    data.selectedIndex == 3 ? Colors.deepPurple : Colors.grey,
              ),
              label: 'Profile',
            ),
          ],
        );
      },
    );
  }
}

// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CustumBottomNavigationBar extends StatelessWidget {
  final void Function(int) buttonAction;

   const CustumBottomNavigationBar({
    super.key,
    required this.buttonAction,
  });

  // int index = 0;

  @override
  Widget build(BuildContext context) {
    return 
  // BottomNavigationBar(
  //           elevation: 0,
  //           currentIndex: index,
  //           onTap: (value) {
  //             index = value;
  //           },
  //           selectedItemColor: kfirstColor,
  //           unselectedItemColor: Colors.grey,
  //           type: BottomNavigationBarType.fixed,
  //           unselectedLabelStyle: const TextStyle(
  //             color: Colors.grey,
  //           ),
  //           items: [
  //             BottomNavigationBarItem(
  //               icon: Image.asset(
  //                 'assets/home.png',
  //                 color: index == 0 ? Colors.deepPurple : Colors.grey,
  //               ),
  //               label: 'Home',
  //             ),
  //             BottomNavigationBarItem(
  //               icon: Image.asset(
  //                 'assets/transaction.png',
  //                 color: index == 1 ? Colors.deepPurple : Colors.grey,
  //               ),
  //               label: 'Transaction',
  //             ),
  //             BottomNavigationBarItem(
  //               icon: Image.asset(
  //                 'assets/pie chart.png',
  //                 color: index == 2 ? Colors.deepPurple : Colors.grey,
  //               ),
  //               label: 'Budget',
  //             ),
  //             BottomNavigationBarItem(
  //               icon: Image.asset(
  //                 'assets/user.png',
  //                 color: index == 3 ? Colors.deepPurple : Colors.grey,
  //               ),
  //               label: 'Profile',
  //             ),
  //           ],
  //         );
    BottomAppBar(
      height: 75,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => buttonAction(0),
                child: const Image(
                  image: AssetImage('assets/home.png'),
                ),
              ),
              GestureDetector(
                onTap: () => buttonAction(1),
                child: const Image(
                  image: AssetImage('assets/transaction.png'),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              GestureDetector(
                onTap: () => buttonAction(2),
                child: const Image(
                  image: AssetImage('assets/pie chart.png'),
                ),
              ),
              GestureDetector(
                onTap: () => buttonAction(3),
                child: const Image(
                  image: AssetImage('assets/user.png'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

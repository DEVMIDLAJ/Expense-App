// ignore_for_file: must_be_immutable

import 'package:expence_app/View/budget_page.dart';
import 'package:expence_app/View/home_page.dart';
import 'package:expence_app/View/profile_page.dart';
import 'package:expence_app/View/transaction_history_page.dart';
import 'package:expence_app/View/Widgets/custom_bottom_navigation_bar.dart';
import 'package:expence_app/View/Widgets/custom_floating_action_button.dart';
import 'package:expence_app/controller/provider/auh_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Main page widget representing the app's home screen
class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        // IndexedStack to efficiently manage the visibility of different screens
        child: IndexedStack(
          index: Provider.of<AuthProvider>(context).selectedIndex,
          children:  [
            // Home page
            HomePage(),
            // Transaction history page
            TransactionHistoryPage(),
            // Budget page
            const BudgetPage(),
            // Profile page
            ProfilePage(),
          ],
        ),
      ),
      // Configure the floating action button
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const CustomFloatingActionButton(),
      // Custom bottom navigation bar
      bottomNavigationBar: const CustumBottomNavigationBar(),
    );
  }
}

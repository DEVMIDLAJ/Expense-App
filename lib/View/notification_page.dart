import 'package:expence_app/View/Widgets/build_toggle_switch_section.dart';
import 'package:expence_app/View/Widgets/display_text.dart';
import 'package:expence_app/controller/provider/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer(
      builder: (BuildContext context, ProfileProvider data, Widget? _) {
        return Consumer(
          builder: (BuildContext context, ProfileProvider data,Widget?_) {
            return Scaffold(
              appBar: AppBar(
                title: const DisplayText(
                  title: "Notification",
                  textSize: 20,
                  textFont: FontWeight.bold,
                ),
                centerTitle: true,
              ),
              body: Column(
                children: [
                  BuildToggleSwitch(
                    title: "Expense Alert",
                    subTitle: "Get notification about you’reexpense",
                    value: data.isLoading,
                    toggleChanged: (bool value) {
                      data.boolLoading();
                    },
                  ),
                  SizedBox(height: size.height * 0.05),
                  BuildToggleSwitch(
                    title: "Budget",
                    subTitle:
                        "Get notification when you’rebudget exceeding the limit",
                    value: data.isLoading1,
                    toggleChanged: (bool value) {
                      data.boolLoading1();
                    },
                  ),
                  SizedBox(height: size.height * 0.05),
                  BuildToggleSwitch(
                    title: "Tips & Articles",
                    subTitle:
                        "Small & useful pieces of pratical financial advice",
                    value: data.isLoading2,
                    toggleChanged: (bool value) {
                      data.boolLoading2();
                    },
                  ),
                ],
              ),
            );
          }
        );
      },
    );
  }
}

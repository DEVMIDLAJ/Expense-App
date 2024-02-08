// ignore_for_file: unused_local_variable

import 'package:expence_app/View/Widgets/display_text.dart';
import 'package:expence_app/View/currency_page.dart';
import 'package:expence_app/View/language_page.dart';
import 'package:expence_app/View/notification_page.dart';
import 'package:expence_app/View/security_page.dart';
import 'package:expence_app/View/theme_page.dart';
import 'package:expence_app/const/colors.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const DisplayText(
          title: "Settings",
          textSize: 20,
          textFont: FontWeight.bold,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.02,
            ),
            buildSettingsOptions(
              "Currency",
              "USD",
              () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => CurrencyPage()));
              },
            ),
            buildSettingsOptions(
              "Language",
              "English",
              () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => LanguagePage()));
              },
            ),
            buildSettingsOptions(
              "Theme",
              "Light",
              () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => ThemePage()));
              },
            ),
            buildSettingsOptions(
              "Security",
              "Fingerprint",
              () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SecurityPage()));
              },
            ),
            buildSettingsOptions(
              "Notification",
              "",
              () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) =>  const NotificationPage()));
              },
            ),
            SizedBox(
              height: size.height * 0.04,
            ),
            buildSettingsOptions(
              "About",
              "",
              () {},
            ),
            buildSettingsOptions(
              "Help",
              "",
              () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSettingsOptions(
      final String title, String subtitle, final VoidCallback onPressed) {
    return Row(
      children: [
        DisplayText(
          title: title,
          textSize: 16,
          textFont: FontWeight.w500,
        ),
        const Spacer(),
        DisplayText(
          title: subtitle,
          textColor: kgrey,
          textSize: 16,
          textFont: FontWeight.w500,
        ),
        IconButton(
          onPressed: onPressed,
          icon: const Icon(
            Icons.arrow_forward_ios,
            color: kfirstColor,
          ),
        )
      ],
    );
  }
}

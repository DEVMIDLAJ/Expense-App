// ignore_for_file: unused_local_variable

import 'package:expence_app/View/Widgets/custom_drop_down_button.dart';
import 'package:expence_app/View/Widgets/display_text.dart';
import 'package:flutter/material.dart';

class ExploreDataPage extends StatelessWidget {
  const ExploreDataPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const DisplayText(
          title: "Explore Data",
          textSize: 20,
          textFont: FontWeight.bold,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: size.height * 0.07,
            ),
            const DisplayText(
              title: "What data do your want to explore?",
              textSize: 16,
              textFont: FontWeight.w500,
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            CustomDropDownButton(
              categories: const ["All"],
              hintText: "All",
              onValueChanged: (value) {},
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            const DisplayText(
              title: "When date range",
              textSize: 16,
              textFont: FontWeight.w500,
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            CustomDropDownButton(
              categories: const ["Last 30 Days"],
              hintText: "Last 30 Days",
              onValueChanged: (value) {},
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            const DisplayText(
              title: "What format do you want to export?",
              textSize: 16,
              textFont: FontWeight.w500,
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            CustomDropDownButton(
              categories: const ["CSV"],
              hintText: "CSV",
              onValueChanged: (value) {},
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

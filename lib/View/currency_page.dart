// ignore_for_file: unused_local_variable

import 'package:expence_app/Model/checkbox_listtile_model.dart';
import 'package:expence_app/View/Widgets/build_checkbox_listtile.dart';
import 'package:expence_app/View/Widgets/display_text.dart';
import 'package:expence_app/controller/provider/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CurrencyPage extends StatelessWidget {
  CurrencyPage({super.key});

  final List<CheckboxListTileModel> currencyList = [
    CheckboxListTileModel(title: "United State", subTitle: "(USD)"),
    CheckboxListTileModel(title: "Indonesia", subTitle: "(IDR)"),
    CheckboxListTileModel(title: "Japan", subTitle: "(JYP)"),
    CheckboxListTileModel(title: "Russia", subTitle: "(RUB)"),
    CheckboxListTileModel(title: "Germany", subTitle: "(EUR)"),
    CheckboxListTileModel(title: "Korea", subTitle: "(WON)"),
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Consumer(
      builder: (BuildContext context, ProfileProvider data, Widget? _) {
        return Scaffold(
          appBar: AppBar(
            title: const DisplayText(
              title: "Currency",
              textSize: 20,
              textFont: FontWeight.bold,
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                BuildCheckboxListTile(
                  newCheckList: currencyList,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

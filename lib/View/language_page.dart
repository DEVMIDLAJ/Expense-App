import 'package:expence_app/Model/checkbox_listtile_model.dart';
import 'package:expence_app/View/Widgets/build_checkbox_listtile.dart';
import 'package:expence_app/View/Widgets/display_text.dart';
import 'package:expence_app/controller/provider/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LanguagePage extends StatelessWidget {
  LanguagePage({super.key});

  final List<CheckboxListTileModel> languageList = [
    CheckboxListTileModel(title: "Englisg", subTitle: "(EN)"),
    CheckboxListTileModel(title: "Indonesia", subTitle: "(ID)"),
    CheckboxListTileModel(title: "Arabic", subTitle: "(AR)"),
    CheckboxListTileModel(title: "Chinese", subTitle: "(ZH)"),
    CheckboxListTileModel(title: "Dutch", subTitle: "(NL)"),
    CheckboxListTileModel(title: "French", subTitle: "(FR)"),
    CheckboxListTileModel(title: "German", subTitle: "(DE)"),
    CheckboxListTileModel(title: "Italian", subTitle: "(IT)"),
    CheckboxListTileModel(title: "Korean", subTitle: "(KO)"),
    CheckboxListTileModel(title: "Portuguese", subTitle: "(PT)"),
    CheckboxListTileModel(title: "Russia", subTitle: "(RU)"),
    CheckboxListTileModel(title: "Spanish", subTitle: "(ES)"),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context,ProfileProvider data,Widget? _) {
        return Scaffold(
          appBar: AppBar(
            title: const DisplayText(
              title: "Language",
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
               BuildCheckboxListTile(newCheckList: languageList)
              ],
            ),
          ),
        );
      }
    );
  }
}

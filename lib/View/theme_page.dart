
import 'package:expence_app/Model/checkbox_listtile_model.dart';
import 'package:expence_app/View/Widgets/build_checkbox_listtile.dart';
import 'package:expence_app/View/Widgets/display_text.dart';
import 'package:expence_app/controller/provider/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemePage extends StatelessWidget {
  ThemePage({super.key});

  final List<CheckboxListTileModel> themeList = [
    CheckboxListTileModel(title: "Light", subTitle: ""),
    CheckboxListTileModel(title: "Dart", subTitle: ""),
    CheckboxListTileModel(title: "Use device theme", subTitle: ""),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, ProfileProvider data, Widget? _) {
        return Scaffold(
          appBar: AppBar(
            title: const DisplayText(
              title: "Theme",
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
               BuildCheckboxListTile(newCheckList: themeList)
              ],
            ),
          ),
        );
      },
    );
  }
}

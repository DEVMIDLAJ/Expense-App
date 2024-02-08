import 'package:expence_app/View/Widgets/display_text.dart';
import 'package:expence_app/const/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BuildToggleSwitch extends StatelessWidget {
  final String title;
  final String subTitle;
  final bool value;
  final void Function(bool)? toggleChanged;

  const BuildToggleSwitch({
    super.key,
    required this.title,
    required this.subTitle,
    required this.value,
    required this.toggleChanged,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height * 0.05,
      width: size.width,
      child: ListTile(
        title: DisplayText(
          title: title,
          textSize: 16,
          textFont: FontWeight.w500,
        ),
        subtitle: DisplayText(
          title: subTitle,
          textColor: kgrey,
          textSize: 13,
          textFont: FontWeight.w500,
        ),
        trailing: CupertinoSwitch(
          thumbColor: kWhite,
          trackColor: ksecondColor,
          activeColor: kfirstColor,
          value: value,
          onChanged: toggleChanged,
        ),
      ),
    );
  }
}

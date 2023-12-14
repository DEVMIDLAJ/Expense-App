// ignore_for_file: must_be_immutable
import 'package:expence_app/const/colors.dart';
import 'package:flutter/material.dart';

class ProfileUrlDisplay extends StatelessWidget {
  final void Function()? buttonAction;
  double? radiusOne;
  double? radiusTwo;

  ProfileUrlDisplay({
    super.key,
    required this.buttonAction,
    this.radiusOne,
    this.radiusTwo,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonAction,
      child: CircleAvatar(
        radius: radiusOne,
        backgroundColor: kfirstColor,
        child: CircleAvatar(
          radius: radiusTwo,
        ),
      ),
    );
  }
}

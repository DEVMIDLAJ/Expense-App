import 'package:expence_app/View/Widgets/display_text.dart';
import 'package:expence_app/const/colors.dart';
import 'package:flutter/material.dart';

class CurrencyPage extends StatelessWidget {
  const CurrencyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const DisplayText(
          title: "Currency",
          textSize: 20,
          textFont: FontWeight.bold,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Row(
            children: [
              const DisplayText(title: "United States (USD)"),
              Checkbox(
                value: false,
                activeColor: kfirstColor,
                shape: CircleBorder(),
                onChanged: (value) {},
              )
            ],
          )
        ],
      ),
    );
  }
}

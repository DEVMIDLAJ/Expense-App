import 'package:expence_app/View/Widgets/custome_elevated_button.dart';
import 'package:expence_app/View/Widgets/display_text.dart';
import 'package:expence_app/const/colors.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const DisplayText(
          title: "Account",
          textSize: 20,
          textFont: FontWeight.bold,
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                height: size.height * 0.03,
              ),
              const DisplayText(
                title: "Account Balance",
                textSize: 14,
                textFont: FontWeight.w500,
                textColor: kgrey,
              ),
              const DisplayText(
                title: "\$9400",
                textSize: 40,
                textFont: FontWeight.w600,
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Expanded(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: 4,
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: size.height * 0.04,
                    );
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: Container(
                        height: size.height * 0.06,
                        width: size.width * 0.13,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      title: const DisplayText(
                        title: "Wallet",
                        textSize: 18,
                        textFont: FontWeight.w600,
                      ),
                      trailing: const DisplayText(
                        title: "\$400",
                        textSize: 18,
                        textFont: FontWeight.w600,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 20,
            left: 15,
            right: 15,
            child: CustomElevatedButton(
              buttonText: '+Add new wallet',
              buttonColor: kfirstColor,
              textColor: kWhite,
              onpressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}

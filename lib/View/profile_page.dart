// ignore_for_file: non_constant_identifier_names

import 'package:expence_app/View/Widgets/custom_textform_feild.dart';
import 'package:expence_app/View/Widgets/display_text.dart';
import 'package:expence_app/View/Widgets/profile_url_display.dart';
import 'package:expence_app/const/colors.dart';
import 'package:expence_app/controller/firebase_service.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});
  final TextEditingController UsernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: size.height * 0.02,
            ),
            ListTile(
              leading: ProfileUrlDisplay(
                radiusOne: 35,
                radiusTwo: 25,
                buttonAction: () {},
              ),
              title: const DispalyText(
                title: 'USER NAME',
                textSize: 14,
                textFont: FontWeight.w500,
                textColor: kgrey,
              ),
              subtitle: CustomTextFormField(
                controller: UsernameController,
                keybordType: TextInputType.name,
                hintText: 'Username',
                obscureText: false,
                hasBorder: false,
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.edit,
                  ),
                ),
                textValidator: (p0) {
                  return null;
                },
              ),
            ),
             SizedBox(
              height: size.height * 0.03,
            ),
            profileOptions(
              'assets/wallet-3.png',
              'Account',
              () {},
            ),
            profileOptions(
              'assets/settings.png',
              'settings',
              () {},
            ),
            profileOptions(
              'assets/upload.png',
              'Export Data',
              () {},
            ),
            profileOptions(
              'assets/logout.png',
              'Logout',
              () {
                FirebaseService().signOut(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector profileOptions(
    String imageUrl,
    String title,
    void Function() buttonAction,
  ) {
    return GestureDetector(
      onTap: buttonAction,
      child: ListTile(
        leading: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            color: Colors.purple.shade50,
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
              image: AssetImage(imageUrl),
            ),
          ),
        ),
        title: DispalyText(
          title: title,
          textSize: 16,
          textFont: FontWeight.w500,
        ),
      ),
    );
  }
}

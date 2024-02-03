// ignore_for_file: non_constant_identifier_names

import 'package:expence_app/View/Widgets/custom_textform_feild.dart';
import 'package:expence_app/View/Widgets/custome_elevated_button.dart';
import 'package:expence_app/View/Widgets/display_text.dart';
import 'package:expence_app/View/Widgets/profile_url_display.dart';
import 'package:expence_app/View/explore_data_page.dart';
import 'package:expence_app/View/settings_page.dart';
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
              title: const DisplayText(
                title: 'USER NAME',
                textSize: 14,
                textFont: FontWeight.w500,
                textColor: kgrey,
              ),
              subtitle: CustomTextFormField(
                controller: UsernameController,
                keybordType: TextInputType.name,
                helperText: 'Username',
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
              () {
                  Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const SettingsPage(),
                  ),
                );
              },
            ),
            profileOptions(
              'assets/upload.png',
              'Export Data',
              () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ExploreDataPage(),
                  ),
                );
              },
            ),
            profileOptions(
              'assets/logout.png',
              'Logout',
              () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Padding(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                        ),
                        child: SizedBox(
                          height: size.height * 0.26,
                          width: size.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const DisplayText(
                                title: "Logout?",
                                textSize: 18,
                                textFont: FontWeight.w600,
                              ),
                              const DisplayText(
                                title: "Are you sure do you wanna logout?",
                                textColor: kgrey,
                                textSize: 16,
                                textFont: FontWeight.w500,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Flexible(
                                    child: CustomElevatedButton(
                                      onpressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      buttonText: 'No',
                                    ),
                                  ),
                                  SizedBox(
                                    width: size.width * 0.02,
                                  ),
                                  Flexible(
                                    child: CustomElevatedButton(
                                      onpressed: () {
                                        FirebaseService().signOut(context);
                                      },
                                      buttonText: 'Yes',
                                      textColor: kWhite,
                                      buttonColor: kfirstColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
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
        title: DisplayText(
          title: title,
          textSize: 16,
          textFont: FontWeight.w500,
        ),
      ),
    );
  }
}

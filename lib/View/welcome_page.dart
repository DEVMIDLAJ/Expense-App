// ignore_for_file: non_constant_identifier_names, must_be_immutable

import 'package:carousel_slider/carousel_slider.dart';
import 'package:expence_app/Model/welcome_model.dart';
import 'package:expence_app/View/authentication_screens/login_page.dart';
import 'package:expence_app/View/authentication_screens/signup_page.dart';
import 'package:expence_app/Widgets/custome_elevated_button.dart';
import 'package:expence_app/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomePage extends StatelessWidget {
  WelcomePage({super.key});

  final List<WelcomeModel> WelcomeSectionList = [
    WelcomeModel(
        welcomeUrl: 'assets/Illustration1.png',
        welcomeTitle: 'Gain total control \n  of your money',
        welcomeSubtitle:
            'Become your own money manager \n     and make every cent count'),
    WelcomeModel(
        welcomeUrl: 'assets/Illustration2.png',
        welcomeTitle: 'Know where your \n  money goes',
        welcomeSubtitle:
            '      Track your transaction easily,\nwith categories and financial report'),
    WelcomeModel(
        welcomeUrl: 'assets/Illustration3.png',
        welcomeTitle: 'Planning ahead',
        welcomeSubtitle:
            'Setup your budget for each category \n                so you in control'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 76,
            ),
            CarouselSlider.builder(
              itemCount: WelcomeSectionList.length,
              itemBuilder: (context, index, realIndex) {
                return Column(
                  children: [
                    SizedBox(
                      width: 312,
                      height: 312,
                      child: ClipRRect(
                        child: Image(
                          image: AssetImage(
                              '${WelcomeSectionList[index].welcomeUrl}'),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      '${WelcomeSectionList[index].welcomeTitle},',
                      style: GoogleFonts.inder(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      '${WelcomeSectionList[index].welcomeSubtitle},',
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ],
                );
              },
              options: CarouselOptions(
                autoPlay: true,
                enlargeCenterPage: true,
                viewportFraction: 0.9,
                aspectRatio: 0.7,
                initialPage: 0,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            CustomElevatedButton(
              onpressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const SignUpPage())),
              buttonText: 'Sign Up',
              buttonColor: kfirstColor,
              textColor: kWhite,
            ),
            const SizedBox(
              height: 15,
            ),
            CustomElevatedButton(
              onpressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => LoginPage())),
              buttonText: 'Login',
              buttonColor: ksecondColor,
              textColor: kfirstColor,
            ),
            const Spacer(),
            const SizedBox(
              height: 42,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:expence_app/View/authentication_screens/login_page.dart';
import 'package:expence_app/View/Widgets/custome_elevated_button.dart';
import 'package:expence_app/View/Widgets/display_text.dart';
import 'package:expence_app/const/colors.dart';
import 'package:flutter/material.dart';

class ForgotPasswordAndEmailSignin extends StatelessWidget {
  // The email for which the password reset instructions were sent
  final String email;

  // Constructor for the ForgotPasswordAndEmailSignin widget
  const ForgotPasswordAndEmailSignin({
    super.key,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 35,
            ),
            const SizedBox(
              width: 312,
              height: 312,
              child: ClipRRect(
                child: Image(
                  image: AssetImage('assets/Illustration4.png'),
                ),
              ),
            ),
            // DisplayText widget with the confirmation message
            const DispalyText(
              title: 'Your email is on the way',
              textSize: 24,
              textFont: FontWeight.w600,
            ),
            const SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              // DisplayText widget with instructions for password reset
              child: DispalyText(
                title:
                    'Check your $email  and follow the instructions to reset your password',
                textSize: 16,
                textFont: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 190,
            ),
            // CustomElevatedButton for navigating back to the login page
            CustomElevatedButton(
              onpressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const LoginPage()));
              },
              buttonText: 'Back to Login',
              buttonColor: kfirstColor,
              textColor: kWhite,
            ),
          ],
        ),
      ),
    );
  }
}

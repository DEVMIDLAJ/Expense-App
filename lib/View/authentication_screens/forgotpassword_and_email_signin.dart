import 'package:expence_app/View/Widgets/custome_elevated_button.dart';
import 'package:expence_app/View/Widgets/display_text.dart';
import 'package:expence_app/View/authentication_screens/resetpassword_page.dart';
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
        Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
             SizedBox(
              height: size.height * 0.1,
            ),
             SizedBox(
              width: size.width * 1,
              height: size.height * 0.4,
              child:const ClipRRect(
                child: Image(
                  image: AssetImage('assets/Illustration4.png'),
                ),
              ),
            ),
            // DisplayText widget with the confirmation message
            const DisplayText(
              title: 'Your email is on the way',
              textSize: 24,
              textFont: FontWeight.w600,
            ),
             SizedBox(
              height: size.height * 0.03,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              // DisplayText widget with instructions for password reset
              child: DisplayText(
                title:
                    'Check your $email  and follow the instructions to reset your password',
                textSize: 16,
                textFont: FontWeight.w500,
              ),
            ),
             SizedBox(
              height: size.height * 0.2,
            ),
            // CustomElevatedButton for navigating back to the login page
            CustomElevatedButton(
              onpressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) =>  ResetPasswordPage(email: email)));
              },
              buttonText: 'Continue',
              buttonColor: kfirstColor,
              textColor: kWhite,
            ),
          ],
        ),
      ),
    );
  }
}

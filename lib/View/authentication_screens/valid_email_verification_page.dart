// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:expence_app/View/Widgets/custom_snackbar.dart';
import 'package:expence_app/View/Widgets/custome_elevated_button.dart';
import 'package:expence_app/View/Widgets/display_text.dart';
import 'package:expence_app/View/authentication_screens/mobile_otp_verification.dart';
import 'package:expence_app/View/authentication_screens/signup_page.dart';
import 'package:expence_app/const/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EmailVerificationPage extends StatefulWidget {
  const EmailVerificationPage({Key? key}) : super(key: key);

  @override
  State<EmailVerificationPage> createState() => _EmailVerificationPageState();
}

class _EmailVerificationPageState extends State<EmailVerificationPage> {
  bool isEmailVerified = false;
  bool canResentEmail = false;
  Timer? timer;
  //create firebase instanse
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    //user needs to be created befor!
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (!isEmailVerified) {
      sendVerificationEmail();

      timer = Timer.periodic(const Duration(seconds: 3), (timer) {
        checkEmailVerified();
      });
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future checkEmailVerified() async {
    //call after emailverification!
    await FirebaseAuth.instance.currentUser!.reload();

    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isEmailVerified) timer?.cancel();
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
      setState(() {
        canResentEmail = false;
      });
      await Future.delayed(
        const Duration(seconds: 5),
      );
      setState(() {
        canResentEmail = true;
      });
    } catch (e) {
      CustomSnackBar.show(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return isEmailVerified
        ? const MobileOtpVerificationPage()
        : Scaffold(
            appBar: AppBar(
              title: const DisplayText(
                title: "Email verification",
                textSize: 18,
                textFont: FontWeight.w600,
              ),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  SizedBox(
                    width: size.width * 1,
                    height: size.height * 0.4,
                    child: const ClipRRect(
                      child: Image(
                        image: AssetImage('assets/Illustration4.png'),
                      ),
                    ),
                  ),
                  const DisplayText(
                    title: 'Verify your email address',
                    textSize: 24,
                    textFont: FontWeight.w600,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  const DisplayText(
                    title:
                        'We have just send email verification link on your email. Please check email and click \ton that link verify your Email address',
                    textSize: 15,
                    textFont: FontWeight.w600,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: size.height * 0.1,
                  ),
                  CustomElevatedButton(
                    onpressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => SignUpPage(),
                        ),
                      );
                    },
                    buttonText: 'Cancel',
                    textColor: kWhite,
                    buttonColor: kfirstColor,
                  ),
                ],
              ),
            ),
          );
  }
}

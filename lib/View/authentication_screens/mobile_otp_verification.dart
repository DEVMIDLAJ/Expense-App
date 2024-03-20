// ignore_for_file: use_build_context_synchronously

import 'package:country_picker/country_picker.dart';
import 'package:expence_app/View/Widgets/custome_elevated_button.dart';
import 'package:expence_app/View/main_page.dart';
import 'package:expence_app/const/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class MobileOtpVerificationPage extends StatefulWidget {
  const MobileOtpVerificationPage({super.key});

  @override
  State<MobileOtpVerificationPage> createState() =>
      _MobileOtpVerificationPageState();
}

class _MobileOtpVerificationPageState extends State<MobileOtpVerificationPage> {
  final phonenumberController = TextEditingController();

  final otpController = TextEditingController();

  //   //create firebase instanse
  final FirebaseAuth auth = FirebaseAuth.instance;

  Country selctedCountry = Country(
      phoneCode: "91",
      countryCode: "IN",
      e164Sc: 0,
      geographic: true,
      level: 1,
      name: 'india',
      example: 'india',
      displayName: 'india',
      displayNameNoCountryCode: 'IN',
      e164Key: '');

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Continue with Mobile OTP",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            const Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Text(
                "Please enter your mobile number , we will send you an OTP to your mobile number.",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            SizedBox(
              width: size.width - 30,
              child: TextFormField(
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
                controller: phonenumberController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    hintText: "Enter Phone Number",
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(
                          left: 10, top: 10.5, bottom: 10, right: 4),
                      child: InkWell(
                        onTap: () {
                          showCountryPicker(
                            context: context,
                            countryListTheme: const CountryListThemeData(
                                bottomSheetHeight: 500),
                            onSelect: (value) {
                              setState(() {
                                selctedCountry = value;
                              });
                            },
                          );
                        },
                        child: Text(
                          "${selctedCountry.flagEmoji} + ${selctedCountry.phoneCode}",
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Colors.black12)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Colors.black12)),
                    // border: InputBorder.none,
                    suffixIcon: TextButton(
                        onPressed: () {
                          phoneotp(context);
                          phonenumberr = phonenumberController.text;
                        },
                        child: const Text('Send Otp'))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Pinput(
                length: 6,
                obscureText: false,
                controller: otpController,
                submittedPinTheme: const PinTheme(
                    textStyle:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            CustomElevatedButton(
              onpressed: () {
                otpp(context, otpController.text);
              },
              buttonText: "Verify",
              textColor: kWhite,
              buttonColor: kfirstColor,
            ),
          ],
        ),
      ),
    );
  }

  late String phonenumberr, verificationID;

  phoneotp(
    BuildContext context,
  ) async {
    await auth.verifyPhoneNumber(
      phoneNumber: '+91$phonenumberr',
      codeSent: (verificationId, int? resendToken) async {
        verificationID = verificationId;
        // Update the UI - wait for the user to enter the SMS code
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
      verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {},
      verificationFailed: (FirebaseAuthException error) {},
    );
  }

  otpp(BuildContext context, String text) async {
    String smsCode = text;

    // Create a PhoneAuthCredential with the code
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationID, smsCode: smsCode);

    // Sign the user in (or link) with the credential
    UserCredential result = await auth.signInWithCredential(credential);
    User? user = result.user;
    if (user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const MainPage(),
        ),
      );
    }
  }
}

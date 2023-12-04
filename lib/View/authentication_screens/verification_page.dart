// ignore_for_file: unused_local_variable, must_be_immutable, use_build_context_synchronously
import 'package:expence_app/Model/email_otp.dart';
import 'package:expence_app/Widgets/custome_elevated_button.dart';
import 'package:expence_app/Widgets/display_text.dart';
import 'package:expence_app/const/colors.dart';
import 'package:expence_app/controller/firebase_service.dart';
import 'package:expence_app/controller/provider/auh_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class VerificationPage extends StatelessWidget {
  VerificationPage({
    super.key,
    required this.id,
    required this.name,
    required this.email,
    required this.password,
  });

  final String name;
  final String email;
  final String password;
  final String id;

  String emailOtp = '';

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, data, _) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: kWhite,
          automaticallyImplyLeading: false,
         
          title: Text(
            'Verification',
            style: GoogleFonts.inter(
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 130,
                ),
                const DispalyText(
                  title: 'Enter your Verification Code',
                  textSize: 36,
                  textFont: FontWeight.w500,
                ),
                const SizedBox(
                  height: 50,
                ),
                Pinput(
                  onCompleted: (otp) {
                    emailOtp = otp;
                  },
                  autofocus: true,
                  defaultPinTheme: PinTheme(
                    width: 54,
                    height: 54,
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 30,
                      color: kblack,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      color: kfirstColor,
                      fontSize: 16,
                    ),
                    children: <TextSpan>[
                      const TextSpan(
                        text: '"We send verification code to your\nemail ',
                        style: TextStyle(
                          color: kblack,
                        ),
                      ),
                      TextSpan(
                        text: '$email ',
                      ),
                      const TextSpan(
                        text: 'You can\ncheck your inbox.',
                        style: TextStyle(
                          color: kblack,
                        ),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'I didn’t received the code? Send again',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                CustomElevatedButton(
                  onpressed: () async {
                    final FirebaseService service = FirebaseService();
                    var otpVerification = await EmailOTP().verifyOtp(id, emailOtp);
                    if (otpVerification == 'success') {
                      data.boolLoading();
                      await service.signUp(name, email, password,id, context);
                    
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          behavior: SnackBarBehavior.floating,
                          elevation: 5,
                          clipBehavior: Clip.antiAlias,
                          padding: const EdgeInsets.all(15),
                          content: const Text('Invalid OTP'),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      );
                    }
                  },
                  buttonText: 'verify',
                  buttonColor: kfirstColor,
                  textColor: kWhite,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

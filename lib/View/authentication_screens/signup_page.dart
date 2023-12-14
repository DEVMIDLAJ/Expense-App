// ignore_for_file: use_build_context_synchronously, override_on_non_overriding_member

import 'package:expence_app/Model/email_otp.dart';
import 'package:expence_app/View/authentication_screens/login_page.dart';
import 'package:expence_app/View/authentication_screens/verification_page.dart';
import 'package:expence_app/View/Widgets/custom_textform_feild.dart';
import 'package:expence_app/View/Widgets/custome_elevated_button.dart';
import 'package:expence_app/Utils/colors.dart';
import 'package:expence_app/controller/firebase_service.dart';
import 'package:expence_app/controller/provider/auh_provider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatelessWidget {
   SignUpPage({super.key});

  @override
  final signupNamecontroller = TextEditingController();

  final signupEmailcontroller = TextEditingController();

  final signupPasswordcontroller = TextEditingController();

  //create formKey
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, data, _) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Center(
            child: Text(
              'Sign Up',
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF212224),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 70,
                  ),
                  CustomTextFormField(
                    controller: signupNamecontroller,
                    keybordType: TextInputType.name,
                    hintText: 'NAME',
                    obscureText: false,
                    textValidator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Username is required';
                      } else if (value.length < 3) {
                        return 'Username must be at least 3 characters';
                      } else if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(value)) {
                        return 'Username can only contain letters, numbers, and underscores';
                      }
                      return null;
                    },
                  ),
                  CustomTextFormField(
                      controller: signupEmailcontroller,
                      keybordType: TextInputType.emailAddress,
                      hintText: 'EMAIL',
                      textValidator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email is required';
                        } else if (!RegExp(
                                r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                            .hasMatch(value)) {
                          return 'Enter a valid email address';
                        }
                        return null;
                      },
                      obscureText: false),
                  CustomTextFormField(
                    controller: signupPasswordcontroller,
                    keybordType: TextInputType.text,
                    hintText: 'PASSWORD',
                    obscureText: !data.isObscure,
                    suffixIcon: GestureDetector(
                      onTap: () {
                        data.boolObscure();
                      },
                      child: data.isObscure
                          ? const Icon(Icons.visibility)
                          : const Icon(Icons.visibility_off),
                    ),
                    textValidator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      } else if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      } else if (!RegExp(r'^(?=.*[A-Za-z])(?=.*\d).+$')
                          .hasMatch(value)) {
                        return 'Password must contain both letters and numbers';
                      }
                      return null;
                    },
                  ),
                  Row(
                    children: [
                      Transform.scale(
                        scale: 1.2,
                        child: Checkbox(
                          checkColor: kWhite,
                          activeColor: kfirstColor,
                          side: const BorderSide(
                            color: kfirstColor,
                            width: 1.7,
                          ),
                          value: data.isChecked,
                          onChanged: (bool? value) {
                            data.boolChecked();
                          },
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'By signing up, you agree to the',
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: kblack,
                              ),
                            ),
                            TextSpan(
                              text: ' Terms of\n Service and Privacy Policy',
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: kfirstColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomElevatedButton(
                    onpressed: () async {
                      String userName = signupNamecontroller.text.trim();
                      String userEmail = signupEmailcontroller.text.trim();
                      String userPassword =
                          signupPasswordcontroller.text.trim();
                      if (_formKey.currentState!.validate()) {
                        var id = await EmailOTP()
                            .sendOtp(signupEmailcontroller.text);
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VerificationPage(
                              name: userName,
                              email: userEmail,
                              password: userPassword,
                              id: id.toString(),
                            ),
                          ),
                        );
                      }
                    },
                    buttonText: 'Sign Up',
                    buttonColor: kfirstColor,
                    textColor: kWhite,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Or With',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: 350,
                    height: 56,
                    child: ElevatedButton(
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                          kWhite,
                        ),
                      ),
                      onPressed: () async {
                        FirebaseService().signInWithGoogle(
                            signupEmailcontroller.text, context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CircleAvatar(
                            child: Image(
                              image: AssetImage('assets/google_logo.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Sign Up with Google',
                            style: GoogleFonts.inter(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF212224),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        color: kfirstColor,
                        fontSize: 16,
                      ),
                      children: <TextSpan>[
                        const TextSpan(
                          text: 'All ready have an account? ',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: 'Login ',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()));
                            },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

// ignore_for_file: unused_field, unnecessary_null_comparison, unused_local_variable, must_be_immutable
import 'package:expence_app/View/authentication_screens/forgot_password.dart';
import 'package:expence_app/View/authentication_screens/signup_page.dart';
import 'package:expence_app/View/Widgets/custom_textform_feild.dart';
import 'package:expence_app/View/Widgets/custome_elevated_button.dart';
import 'package:expence_app/Utils/colors.dart';
import 'package:expence_app/controller/firebase_service.dart';
import 'package:expence_app/controller/provider/auh_provider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final loginemailcontroller = TextEditingController();

  final loginpasswordcontroller = TextEditingController();

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
              'Login',
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: kblack,
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 120,
                  ),
                  CustomTextFormField(
                    controller: loginemailcontroller,
                    keybordType: TextInputType.emailAddress,
                    hintText: 'EMAIL',
                    obscureText: false,
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
                  ),
                  CustomTextFormField(
                    controller: loginpasswordcontroller,
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
                  CustomElevatedButton(
                    onpressed: () async {
                      FirebaseService authMethord = FirebaseService();
                      String email = loginemailcontroller.text.trim();
                      String password = loginpasswordcontroller.text.trim();

                      if (_formKey.currentState!.validate()) {
                        String? loginResult =
                            await authMethord.signIn(email, password, context);
                      }
                    },
                    buttonText: 'Login',
                    buttonColor: kfirstColor,
                    textColor: kWhite,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomElevatedButton(
                    onpressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ForgotPasswordPage(),
                        ),
                      );
                    },
                    buttonText: 'Forgot Password?',
                    buttonColor: ksecondColor,
                    textColor: kfirstColor,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        color: kfirstColor,
                        fontSize: 16,
                      ),
                      children: <TextSpan>[
                        const TextSpan(
                          text: 'Don’t have an account yet? Sign Up ',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                            text: 'Sign Up ',
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                             SignUpPage()));
                              }),
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

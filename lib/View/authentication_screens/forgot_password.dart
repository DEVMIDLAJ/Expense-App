// ignore_for_file: non_constant_identifier_names

import 'package:expence_app/View/Widgets/custom_textform_feild.dart';
import 'package:expence_app/View/Widgets/custome_elevated_button.dart';
import 'package:expence_app/View/Widgets/display_text.dart';
import 'package:expence_app/const/colors.dart';
import 'package:expence_app/controller/firebase_service.dart';
import 'package:expence_app/controller/provider/auh_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgotPasswordPage extends StatelessWidget {
  // TextEditingController for the email input field
  final TextEditingController ForgotPasswordEmailController =
      TextEditingController();

  // GlobalKey for the form to perform form-related operations
  final _formKey = GlobalKey<FormState>();

  // Constructor for the ForgotPasswordPage widget
  ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<AuthProvider>(
      builder: (context, data, _) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Center(
              child: DisplayText(
                title: 'Forgot Password',
                textSize: 18,
                textFont: FontWeight.w600,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: SingleChildScrollView(
              child: Form(
                // Assign the formKey to the Form widget
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.1,
                    ),
                    // DisplayText widget with welcome message
                    const DisplayText(
                      title:
                          'Don’t worry.\nEnter your email and we’ll\nsend you a link to reset your\n password',
                      textSize: 24,
                      textFont: FontWeight.w600,
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    // CustomTextFormField for email input
                    CustomTextFormField(
                      controller: ForgotPasswordEmailController,
                      keybordType: TextInputType.emailAddress,
                      hintText: 'Email',
                      textValidator: (p0) {
                        if (p0 == null || p0.isEmpty) {
                          return 'Email is required';
                        } else if (!RegExp(
                                r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                            .hasMatch(p0)) {
                          return 'Enter a valid email address';
                        }
                        return null;
                      },
                      obscureText: false,
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    // CustomElevatedButton for the Continue button
                    CustomElevatedButton(
                      onpressed: () async {
                        String email =
                            ForgotPasswordEmailController.text.trim();
                        if (_formKey.currentState!.validate()) {
                          await FirebaseService()
                              .forgotPassword(context, email);
                        }
                      },
                      buttonText: 'Continue',
                      buttonColor: kfirstColor,
                      textColor: kWhite,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

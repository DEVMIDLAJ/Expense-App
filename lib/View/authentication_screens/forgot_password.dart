// ignore_for_file: non_constant_identifier_names

import 'package:expence_app/View/authentication_screens/resetpassword_page.dart';
import 'package:expence_app/View/Widgets/custom_textform_feild.dart';
import 'package:expence_app/View/Widgets/custome_elevated_button.dart';
import 'package:expence_app/View/Widgets/display_text.dart';
import 'package:expence_app/const/colors.dart';
import 'package:expence_app/controller/provider/auh_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgotPasswordPage extends StatelessWidget {
  // TextEditingController for the email input field
  final TextEditingController ForgotPasswordEmailController = TextEditingController();

  // GlobalKey for the form to perform form-related operations
  final _formKey = GlobalKey<FormState>();

  // Constructor for the ForgotPasswordPage widget
  ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, data, _) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Center(
              child: DispalyText(
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
                    const SizedBox(
                      height: 90,
                    ),
                    // DisplayText widget with welcome message
                    const DispalyText(
                      title:
                          'Don’t worry.\nEnter your email and we’ll\nsend you a link to reset your\n password',
                      textSize: 24,
                      textFont: FontWeight.w600,
                    ),
                    const SizedBox(
                      height: 25,
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
                    const SizedBox(
                      height: 10,
                    ),
                    // CustomElevatedButton for the Continue button
                    CustomElevatedButton(
                      onpressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Navigate to the ResetPasswordPage with the provided email
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ResetPasswordPage(
                                    email: ForgotPasswordEmailController.text,
                                  )));
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

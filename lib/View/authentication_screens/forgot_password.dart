// ignore_for_file: non_constant_identifier_names, unused_field
import 'package:expence_app/View/authentication_screens/resetpassword_page.dart';
import 'package:expence_app/Widgets/custom_textform_feild.dart';
import 'package:expence_app/Widgets/custome_elevated_button.dart';
import 'package:expence_app/Widgets/display_text.dart';
import 'package:expence_app/const/colors.dart';
import 'package:expence_app/controller/provider/auh_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ForgotPasswordPage extends StatelessWidget {
  ForgotPasswordPage({super.key});

  final ForgotPasswordEmailController = TextEditingController();
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
              'Forgot Password',
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF212224),
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 90,
                  ),
                  const DispalyText(
                    title:
                        'Don’t worry.\nEnter your email and we’ll\nsend you a link to reset your\n password',
                    textSize: 24,
                    textFont: FontWeight.w600,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
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
                  CustomElevatedButton(
                    onpressed: () {
                      if (_formKey.currentState!.validate()) {
                        // FirebaseService().ForgotPassword(context, ForgotPasswordEmailController.text);
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
    });
  }
}

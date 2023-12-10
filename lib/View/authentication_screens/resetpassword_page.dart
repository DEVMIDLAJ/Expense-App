// ignore_for_file: non_constant_identifier_names

import 'package:expence_app/View/Widgets/custom_textform_feild.dart';
import 'package:expence_app/View/Widgets/custome_elevated_button.dart';
import 'package:expence_app/const/colors.dart';
import 'package:expence_app/controller/firebase_service.dart';
import 'package:expence_app/controller/provider/auh_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ResetPasswordPage extends StatelessWidget {
  final String email;
  ResetPasswordPage({
    super.key,
    required this.email,
  });

  final ResetPasswordController = TextEditingController();
  final ConformResetPasswordController = TextEditingController();
  //create formKey
  final _formKey = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, data, _) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Center(
              child: Text(
                'Reset Password',
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
                      height: 120,
                    ),
                    
                    CustomTextFormField(
                      controller: ResetPasswordController,
                      keybordType: TextInputType.text,
                      hintText: 'NEW PASSWORD',
                      obscureText: !data.isObscure,
                      suffixIcon: GestureDetector(
                        onTap: () {
                          data.boolObscure();
                        },
                        child: data.isObscure
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off),
                      ),
                      textValidator: (p0) {
                        if (p0 == null || p0.isEmpty) {
                          return 'Password is required';
                        } else if (p0.length < 6) {
                          return 'Password must be at least 6 characters';
                        } else if (!RegExp(r'^(?=.*[A-Za-z])(?=.*\d).+$')
                            .hasMatch(p0)) {
                          return 'Password must contain both letters and numbers';
                        }
                        return null;
                      },
                    ),
                    CustomTextFormField(
                      controller: ConformResetPasswordController,
                      keybordType: TextInputType.text,
                      hintText: 'RETYPE NEW PASSWORD',
                      obscureText: !data.isObscure,
                      suffixIcon: GestureDetector(
                        onTap: () {
                          data.boolObscure();
                        },
                        child: data.isObscure
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off),
                      ),
                      textValidator: (p0) {
                        if (p0 == null || p0.isEmpty) {
                          return 'Password is required';
                        } else if (p0.length < 6) {
                          return 'Password must be at least 6 characters';
                        } else if (!RegExp(r'^(?=.*[A-Za-z])(?=.*\d).+$')
                            .hasMatch(p0)) {
                          return 'Password must contain both letters and numbers';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomElevatedButton(
                      onpressed: ()async {
                        if (_formKey.currentState!.validate() &&
                            ResetPasswordController.text ==
                                ConformResetPasswordController.text) {
                         await FirebaseService().ForgotPassword(
                              context, email,ResetPasswordController.text );
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

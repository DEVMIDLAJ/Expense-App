// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:expence_app/View/authentication_screens/forgotpassword_and_email_signin.dart';
import 'package:expence_app/View/authentication_screens/login_page.dart';
import 'package:expence_app/View/authentication_screens/valid_email_verification_page.dart';
import 'package:expence_app/View/main_page.dart';
import 'package:expence_app/View/Widgets/custom_snackbar.dart';
import 'package:expence_app/View/welcome_page.dart';
import 'package:expence_app/controller/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseService implements AuthMethod {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  //current user object
  User? currentUser = FirebaseAuth.instance.currentUser;
  //current user object
  final user = FirebaseAuth.instance.currentUser;

  // Sign up method
  @override
  Future<String?> signUp(email, password, context) async {
    await _auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      value.user?.sendEmailVerification().whenComplete(() =>
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => const EmailVerificationPage())));
    }).onError((error, stackTrace) {
      //CustomSnackBar.show(context, error.toString());
    });
    return null;
  }

  // Sign in method
  @override
  Future<String?> signIn(String email, String password, context) async {
    await _auth
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      // Navigate to the main page on successful sign-in
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const MainPage()));
      CustomSnackBar.show(context, 'Login successfully');
    }).onError((error, stackTrace) {
      // Show an error message if sign-in fails
      CustomSnackBar.show(context, 'Please fill valid email and password');
    });
    return null;
  }

  // Forgot password method
  @override
  // ForgotPassword method in FirebaseService class
  Future<void> forgotPassword(BuildContext context, String email) async {
    await _auth.sendPasswordResetEmail(email: email).then((value) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ForgotPasswordAndEmailSignin(
                  email: email,
                )),
      );
      CustomSnackBar.show(context, 'check your email then set new password');
    }).onError((error, stackTrace) {
      //  Handle password reset failure
      CustomSnackBar.show(context, 'Please enter valid email');
    });
  }

// reset password methord
  @override
  Future<void> resetPassword(
      BuildContext context, String email, String newPassword) async {
    await _auth
        .signInWithEmailAndPassword(email: email, password: newPassword)
        .then((value) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ),
          (route) => false);
      CustomSnackBar.show(context, 'Password reset successful');
    }).onError((error, stackTrace) {
      CustomSnackBar.show(context, 'check your email then set new password');
    });
  }

  // Google sign-in method
  @override
  Future<String?> signInWithGoogle(email, BuildContext context) async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication gAuth = await googleUser!.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );
    await FirebaseAuth.instance.signInWithCredential(credential);
    // Navigate to the main page on successful Google sign-in
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const MainPage()));
    CustomSnackBar.show(context, 'GoogleSignIn successfully');
    return null;
  }

  // Sign out method
  @override
  Future<void> signOut(BuildContext context) async {
    await _auth.signOut().then((value) {
      // Navigate to the login page on successful sign-out
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
        (route) => false, // This will clear the navigation stack
      );
    }).onError((error, stackTrace) {
      // Show an error message if sign-out fails
      CustomSnackBar.show(context, 'Error: ${error.toString()}');
    });
  }

  // user login check method
  @override
  isLogin(BuildContext context) {
    if (user != null) {
      Timer(
          const Duration(seconds: 3),
          () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => const MainPage())));
    } else {
      Timer(
          const Duration(seconds: 3),
          () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => WelcomePage())));
    }
  }
}

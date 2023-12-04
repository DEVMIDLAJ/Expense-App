// ignore_for_file: unused_field, body_might_complete_normally_nullable, use_build_context_synchronously, non_constant_identifier_names, prefer_const_constructors, unused_local_variable, unnecessary_string_interpolations
import 'package:expence_app/View/authentication_screens/login_page.dart';
import 'package:expence_app/View/main_page.dart';
import 'package:expence_app/controller/firebase_auth.dart';
import 'package:expence_app/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseService implements AuthMethord {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

//signUp
  @override
  Future<String?> signUp(name, email, password, id, context) async {
    await _auth
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) async {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => MainPage()));
      Utils().toMassage('Created Account');
    }).onError((error, stackTrace) {
      // Return null for success, or an error message if any.
      Utils().toMassage(error.toString());
    });
  }

  //signIn
  @override
  Future<String?> signIn(String email, String password, context) async {
    await _auth
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const MainPage()));
      Utils().toMassage('Account Login');
    }).onError((error, stackTrace) {
      // Return null for success, or an error message if any.
      Utils().toMassage(error.toString());
    });
    return null;
  }

  @override
  Future<void> ForgotPassword(
      BuildContext context, String email, String password) async {
    User? user = _auth.currentUser;
    if (user != null) {
      await user.updatePassword(password).then((value) {
        Utils().toMassage('Password updated successfully');
      }).onError((error, stackTrace) {
        // Handle the error
        Utils().toMassage('Password updated successfully');
      });
    } else {
      // Handle the case where the user is not signed in
      Utils().toMassage('User not signed in');
    }
  }

  //GooglesignIn
  @override
  Future<String?> signInWithGoogle(email, BuildContext context) async {
     final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication gAuth = await gUser!.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );
    await FirebaseAuth.instance.signInWithCredential(credential);
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MainPage()));
  }

  //signout
  @override
  Future<void> signOut(context) async {
    await _auth.signOut().then((value) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => LoginPage()));
    }).onError((error, stackTrace) {
      // Return null for success, or an error message if any.
      Utils().toMassage(error.toString());
    });
  }
}

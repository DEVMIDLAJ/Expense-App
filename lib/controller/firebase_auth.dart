// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'package:flutter/widgets.dart';

// Abstract class representing authentication methods
abstract class AuthMethod {
  // Method for user sign-up
  Future<void> signUp(String name, String email, String password, String id, BuildContext context);

  // Method for user sign-in
  Future<void> signIn(String email, String password, BuildContext context);

  // Method for signing in with Google
  Future<void> signInWithGoogle(String email, BuildContext context);

  // Method for resetting the user's password
  Future<void> ForgotPassword(BuildContext context, String email, String newPassword);

  // Method for user sign-out
  Future<void> signOut(BuildContext context);

  // Methord for authentication check
  isLogin(BuildContext context);
}

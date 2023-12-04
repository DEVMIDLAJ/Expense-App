// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'package:flutter/widgets.dart';

abstract class AuthMethord {
  Future<void> signUp(String name, String email, String password,String id, BuildContext context);
  Future<void> signIn(String email, String password, BuildContext context);
  Future<void> signInWithGoogle(String email,BuildContext context);
  Future<void> ForgotPassword(BuildContext context,String email,String newPassword);
  Future<void> signOut(BuildContext context);
}

import 'dart:async';
import 'package:expence_app/View/welcome_page.dart';
import 'package:expence_app/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => WelcomePage())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kfirstColor,
      body: Center(
        child: Stack(
          children: [
            const Positioned(
              left: 25,
              child: SizedBox(
                height: 90,
                width: 90,
                child: Image(
                  image: AssetImage(
                    'assets/Ellipse 38.png',
                  ),
                ),
              ),
            ),
            Text(
              'montra',
              style: GoogleFonts.inter(
                fontSize: 56,
                fontWeight: FontWeight.w700,
                color: kWhite,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:expence_app/const/colors.dart';
import 'package:expence_app/controller/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    FirebaseService().isLogin(context);
    super.initState();
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


    // Timer(
    //     const Duration(seconds: 3),
    //     () => Navigator.of(context).pushReplacement(MaterialPageRoute(
    //         builder: (BuildContext context) => WelcomePage())));
 
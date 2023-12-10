import 'package:expence_app/controller/firebase_service.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () => FirebaseService().signOut(context),
          child: Icon(Icons.logout),
        ),
      ),
    );
  }
}

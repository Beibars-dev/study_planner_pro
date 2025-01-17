import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:study_planner_pro_app/pages/home_page.dart';
import 'package:study_planner_pro_app/pages/onboarding_page.dart';

class FirebaseStream extends StatelessWidget {
  const FirebaseStream({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Scaffold(
              body: Center(child: Text('Что-то пошло не так!')));
        } else if (snapshot.hasData) {
          if (!snapshot.data!.emailVerified) {
            return OnboardingPage();
          }
          return const HomePage();
        } else {
          return const HomePage();
        }
      },
    );
  }
}

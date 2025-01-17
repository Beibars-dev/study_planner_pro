import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:study_planner_pro_app/pages/onboarding_page.dart';
import 'package:study_planner_pro_app/pages/registration_page.dart';
import 'package:study_planner_pro_app/pages/welcome_page.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:study_planner_pro_app/services/snack_bar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailTextInputController = TextEditingController();
  TextEditingController passwordTextInputController = TextEditingController();

  @override
  void dispose() {
    emailTextInputController.dispose();
    passwordTextInputController.dispose();

    super.dispose();
  }

  Future<void> login() async {
    final navigator = Navigator.of(context);

    final isValid = _formKey.currentState!.validate();
    if (!isValid) return;

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailTextInputController.text.trim(),
        password: passwordTextInputController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      print(e.code);

      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        SnackBarService.showSnackBar(
          context,
          'Incorrect email or password. Please try again',
          true,
        );
        return;
      }
      if (e.code == 'invalid-credential') {
        SnackBarService.showSnackBar(
          context,
          'Invalid credentials provided. Please check your inputs.',
          true,
        );
        return;
      } else {
        SnackBarService.showSnackBar(
          context,
          'Unknown error! Try again or contact support.',
          true,
        );
        return;
      }
    }

    navigator.push(MaterialPageRoute(builder: (context) => OnboardingPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/Logo.png',
                    height: 100,
                    scale: 2,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'My Study Life',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Create a unique emotional story that describes better than words',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 30),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 64,
                  width: 152,
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(
                      (MdiIcons.google),
                      size: 24,
                    ),
                    label: Text('Google',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        side: BorderSide(color: Color(0xFF2FD1C5))),
                  ),
                ),
                SizedBox(width: 10),
                SizedBox(
                  height: 64,
                  width: 152,
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(
                      Icons.apple,
                      size: 24,
                      color: Colors.black,
                    ),
                    label: Text('Apple',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        side: BorderSide(color: Color(0xFF2FD1C5))),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(child: Divider()),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text('Or'),
                ),
                Expanded(child: Divider()),
              ],
            ),
            SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: emailTextInputController,
                    autocorrect: false,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFFC4D7FF), width: 2),
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    validator: (email) =>
                        email != null && !EmailValidator.validate(email)
                            ? 'Write correctly email'
                            : null,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: passwordTextInputController,
                    autocorrect: false,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFFC4D7FF), width: 2),
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "PLease field your password";
                      }
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: login,
              child: Text(
                'Continue',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding: EdgeInsets.symmetric(vertical: 15),
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: Container(
                  child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RegistrationPage()));
                },
                child: Text(
                  "If you haven't account, REGISTER",
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.teal,
                      decoration: TextDecoration.underline),
                ),
              )),
            )
          ],
        ),
      ),
    );
  }
}

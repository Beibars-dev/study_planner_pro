import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:study_planner_pro_app/pages/log_in_page.dart';
import 'package:study_planner_pro_app/services/snack_bar.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  bool isHiddenPassword = true;
  TextEditingController emailTextInputController = TextEditingController();
  TextEditingController passwordTextInputController = TextEditingController();
  TextEditingController passwordTextConfirmInputController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailTextInputController.dispose();
    passwordTextInputController.dispose();
    passwordTextConfirmInputController.dispose();

    super.dispose();
  }

  void togglePasswordView() {
    setState(() {
      isHiddenPassword = !isHiddenPassword;
    });
  }

  Future<void> signUp() async {
    final navigator = Navigator.of(context);

    final isValid = _formKey.currentState!.validate();
    if (!isValid) return;

    if (passwordTextInputController.text !=
        passwordTextConfirmInputController.text) {
      SnackBarService.showSnackBar(
        context,
        'Password should be similar',
        true,
      );
      return;
    }

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailTextInputController.text.trim(),
        password: passwordTextInputController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      print(e.code);

      if (e.code == 'email-already-in-use') {
        SnackBarService.showSnackBar(
          context,
          'This Email is already in use, please try again using another Email',
          true,
        );
        return;
      } else {
        SnackBarService.showSnackBar(
          context,
          'Unknown error! Try again or contact support.',
          true,
        );
      }
    }

    navigator.push(MaterialPageRoute(builder: (context) => LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
                          decoration: InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (email) =>
                              email != null && !EmailValidator.validate(email)
                                  ? 'Please field your email'
                                  : null,
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                            controller: passwordTextInputController,
                            obscureText: isHiddenPassword,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              border: OutlineInputBorder(),
                              suffix: InkWell(
                                onTap: togglePasswordView,
                                child: Icon(
                                  isHiddenPassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "PLease field your password";
                              }
                            }),
                        SizedBox(height: 16),
                        TextFormField(
                            controller: passwordTextConfirmInputController,
                            obscureText: isHiddenPassword,
                            decoration: InputDecoration(
                              labelText: 'Confirm Password',
                              border: OutlineInputBorder(),
                              suffix: InkWell(
                                onTap: togglePasswordView,
                                child: Icon(
                                  isHiddenPassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "PLease confirm your password";
                              }
                            }),
                      ],
                    )),
                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: signUp,
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    backgroundColor: Colors.teal,
                  ),
                  child: Text(
                    'Register',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

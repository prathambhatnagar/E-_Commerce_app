import 'package:e_commerce/core/services/firebase/firebase_user_service/firestore_user_service.dart';
import 'package:e_commerce/features/authentication/widgets/gradient_button.dart';
import 'package:e_commerce/features/authentication/widgets/image_button.dart';
import 'package:e_commerce/features/authentication/widgets/snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/services/firebase/auth_services/user_auth_service.dart';
import '../widgets/auth_form_field.dart';

class LoginPage extends StatefulWidget {
  final Function switchMethod;
  const LoginPage({super.key, required this.switchMethod});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  final FirebaseAuthService _authService = FirebaseAuthService();

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<User?>(context);

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Login.',
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5),
                  ),
                  const SizedBox(height: 30),
                  AuthFormField(
                    textController: emailController,
                    label: 'Email',
                    prefixIcon: const Icon(Icons.email_outlined),
                    validator: (value) {
                      if (!value!.contains('@')) {
                        return 'Enter a valid Email Address';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),
                  AuthFormField(
                    textController: passController,
                    label: 'Password',
                    prefixIcon: const Icon(Icons.password),
                    isObscure: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return " Enter password before";
                      } else if (value.length < 6) {
                        return 'Length must be >6';
                      } else
                        return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  GradientButton(
                    title: "Login In",
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          await _authService
                              .signupWithEmailPassword(
                                  email: emailController.text.trim(),
                                  password: passController.text.trim())
                              .then(
                            (user) async {
                              CustomSnackBar.showCustomSnackBar(
                                  context: context,
                                  content: 'Login Successful',
                                  color: Colors.green);
                            },
                          );
                        } on FirebaseException catch (e) {
                          CustomSnackBar.showCustomSnackBar(
                            context: context,
                            content: e.message.toString(),
                            color: Colors.orange,
                          );
                        }
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      widget.switchMethod();
                    },
                    child: RichText(
                      text: TextSpan(
                        style: Theme.of(context).textTheme.titleMedium,
                        text: 'Don\'t have an account? ',
                        children: [
                          TextSpan(
                            text: 'Sign In',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(color: Colors.pinkAccent),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          child: Divider(color: Colors.grey, thickness: 1)),
                      Text(" OR ", style: TextStyle(fontSize: 20)),
                      Expanded(
                          child: Divider(color: Colors.grey, thickness: 1)),
                    ],
                  ),
                  SizedBox(height: 30),
                  ImageButton(
                      image: Image.asset(
                        'assets/images/google_icon.png',
                      ),
                      onTap: () async {
                        await _authService.googleSignIn();
                      },
                      label: "Sign in with Google ")
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

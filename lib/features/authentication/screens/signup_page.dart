import 'package:e_commerce/core/services/firebase/firebase_user_service/firestore_user_service.dart';
import 'package:e_commerce/features/authentication/widgets/gradient_button.dart';
import 'package:e_commerce/features/authentication/widgets/snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/services/firebase/auth_services/user_auth_service.dart';
import '../widgets/auth_form_field.dart';
import '../widgets/image_button.dart';

class SignupPage extends StatefulWidget {
  final Function switchMethod;

  const SignupPage({super.key, required this.switchMethod});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  final FirebaseAuthService _authUserService = FirebaseAuthService();

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    confirmPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<User?>(context);
    final FirestoreUserService firestoreUserService =
        FirestoreUserService(user: user);

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Sign Up.',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                AuthFormField(
                  textController: emailController,
                  label: 'Email',
                  prefixIcon: Icon(Icons.email_outlined),
                  validator: (value) {
                    if (!value!.contains('@')) {
                      return 'Enter a valid Email Address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                AuthFormField(
                  isObscure: true,
                  textController: passController,
                  label: 'Password',
                  prefixIcon: Icon(Icons.password),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return " Enter password before";
                    } else if (value.length < 6) {
                      return 'Password must contains at least 6 characters';
                    } else
                      return null;
                  },
                ),
                const SizedBox(height: 20),
                AuthFormField(
                  isObscure: true,
                  textController: confirmPassController,
                  label: 'Confirm Password',
                  prefixIcon: Icon(Icons.password),
                  validator: (value) {
                    if (value != passController.text) {
                      return 'Password not match';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                GradientButton(
                    title: "Sign In",
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        try {
                          _authUserService
                              .createUserWithEmailPassword(
                            email: emailController.text.trim(),
                            password: passController.text.trim(),
                          )
                              .then((user) async {
                            await firestoreUserService.createUser();
                            CustomSnackBar.showCustomSnackBar(
                                context: context,
                                content: "User created Successfully",
                                color: Colors.blueAccent);
                          });
                        } on FirebaseAuthException catch (e) {
                          CustomSnackBar.showCustomSnackBar(
                            context: context,
                            content: e.message.toString(),
                            color: Colors.orange,
                          );
                        }
                      }
                    }),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    widget.switchMethod();
                  },
                  child: RichText(
                    text: TextSpan(
                      style: Theme.of(context).textTheme.titleMedium,
                      text: 'Already have an account? ',
                      children: [
                        TextSpan(
                          text: 'Login',
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
                    Expanded(child: Divider(color: Colors.grey, thickness: 1)),
                    Text(" OR ", style: TextStyle(fontSize: 20)),
                    Expanded(child: Divider(color: Colors.grey, thickness: 1)),
                  ],
                ),
                SizedBox(height: 30),
                ImageButton(
                    image: Image.asset(
                      'assets/images/google_icon.png',
                    ),
                    onTap: () async {
                      await _authUserService.googleSignIn();
                    },
                    label: "Sign in with Google ")
              ],
            ),
          ),
        ),
      ),
    );
  }
}

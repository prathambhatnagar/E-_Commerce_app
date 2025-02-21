import 'package:e_commerce/features/authentication/screens/login_page.dart';
import 'package:e_commerce/features/authentication/screens/signup_page.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({super.key});

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool switchPageBool = false;

  void switchPage() {
    setState(() {
      switchPageBool = !switchPageBool;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (switchPageBool) {
      return SignupPage(switchMethod: switchPage);
    } else {
      return LoginPage(switchMethod: switchPage);
    }
  }
}

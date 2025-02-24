import 'dart:convert';

import 'package:e_commerce/core/services/firebase/firebase_user_service/firestore_user_service.dart';
import 'package:e_commerce/features/add_product/add_product.dart';
import 'package:e_commerce/features/authentication/widgets/auth_form_field.dart';
import 'package:e_commerce/features/authentication/widgets/gradient_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart' as crypto;

class AdminPannel extends StatelessWidget {
  const AdminPannel({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController passwordController = TextEditingController();
    TextEditingController userNameController = TextEditingController();
    FirestoreUserService firestoreUserService =
        FirestoreUserService(user: FirebaseAuth.instance.currentUser);

    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Pannel'),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 120, horizontal: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.white12),
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Admin Login',
                style: Theme.of(context).textTheme.headlineLarge),
            SizedBox(height: 30),
            AuthFormField(
              label: 'User Name',
              textController: userNameController,
              prefixIcon: Icon(Icons.person),
            ),
            SizedBox(height: 20),
            AuthFormField(
              label: 'Password',
              textController: passwordController,
              isObscure: true,
              prefixIcon: Icon(Icons.password_sharp),
            ),
            SizedBox(height: 30),
            GradientButton(
              title: 'Admin Login',
              onTap: () async {
                Map<String, String> creds =
                    await firestoreUserService.getAdminCreds();
                String passHash = crypto.md5
                    .convert(utf8.encode(passwordController.text))
                    .toString();
                if (creds['password'] == passHash &&
                    creds['userName'] == userNameController.text) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddProduct()));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Center(
                        child: Text(
                          "Wrong Credentials",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      backgroundColor: Colors.orange,
                    ),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

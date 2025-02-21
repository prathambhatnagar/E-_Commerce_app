import 'package:e_commerce/features/authentication/widgets/auth_form_field.dart';
import 'package:flutter/material.dart';

class AdminPannel extends StatelessWidget {
  const AdminPannel({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Pannel'),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [
            AuthFormField(
              label: 'User Name',
              textController: passwordController,
              isObscure: true,
              prefixIcon: Icon(Icons.password_sharp),
            ),
            AuthFormField(
              label: 'Password',
              textController: passwordController,
              isObscure: true,
              prefixIcon: Icon(Icons.password_sharp),
            ),
          ],
        ),
      ),
    );
  }
}

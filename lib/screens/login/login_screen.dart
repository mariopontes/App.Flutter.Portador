import 'package:flutter/material.dart';
import './login_form.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        alignment: Alignment.topCenter,
        color: Colors.indigo[900],
        child: Stack(
          children: [
            Positioned(
              child: LoginForm(),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../signup/signup_screen.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      // child: const Center(
      child: TextButton(
        onPressed: () {
          Navigator.pushNamedAndRemoveUntil(
              context, SignupScreen.idScreen, (route) => false);
        },
        child: const Text(
          "Create an Account",
          style: TextStyle(
              color: Colors.cyan, fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ),
      // ),
    );
  }
}

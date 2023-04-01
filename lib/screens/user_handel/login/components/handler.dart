import '../../../../screens/user_handel/login/login_screen.dart';
import '../../../../screens/user_handel/signup/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:smart_safe/screens/user_handel/login/login_screen.dart';
import 'package:smart_safe/screens/user_handel/signup/signup_screen.dart';

class Handler extends StatefulWidget {
  const Handler({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _Handler();
  }
}

class _Handler extends State<Handler> {
  bool showSignin = true;

  void toggleView() {
    setState(() {
      showSignin = !showSignin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignin) {
      return LoginScreen();
    } else {
      return const SignupScreen();
    }
  }
}

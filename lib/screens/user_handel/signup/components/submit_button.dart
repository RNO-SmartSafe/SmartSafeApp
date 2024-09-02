// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_safe/models/loginuser.dart';

import '../../../../services/auth.dart';
import '../../../../widgets/toast_message.dart';
import '../../../home/home_screen.dart';
// import 'package:provider/provider.dart';

// import '../../../../providers/auth_provider.dart';

class Submit extends StatelessWidget {
  final TextEditingController nameTxtController;
  final TextEditingController emailTxtController;
  final TextEditingController passwordTxtController;
  final TextEditingController rePasswordTxtController;
  final TextEditingController phoneTxtController;

  const Submit({
    Key? key,
    required this.emailTxtController,
    required this.passwordTxtController,
    required this.rePasswordTxtController,
    required this.nameTxtController,
    required this.phoneTxtController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 50),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ElevatedButton(
        //style: ElevatedButton.styleFrom(backgroundColor: Colors.cyan[500]),
        onPressed: () {
          _submit(context);
        },
        child: const Center(
          child: Text(
            "Submit",
            style: TextStyle(
                color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Future<void> _submit(context) async {
    if (validate(context)) {
      await Provider.of<AuthService>(context, listen: false)
          .registerEmailPassword(LoginUser(
                  email: emailTxtController.text,
                  password: passwordTxtController.text)
              // nameTxtController.text,
              // emailTxtController.text,
              // passwordTxtController.text,
              // phoneTxtController.text,
              )
          .then(((value) => Navigator.pushNamedAndRemoveUntil(
              context, HomeScreen.idScreen, (route) => false)));
    }
  }

  bool validate(context) {
    if (nameTxtController.text.length < 3) {
      displayToastMessage("Name must be at least 3 characters.", context);
    } else if (!emailTxtController.text.contains("@")) {
      displayToastMessage("Email is not valid.", context);
    } else if (!phoneTxtController.text.startsWith("05") ||
        phoneTxtController.text.length < 10) {
      displayToastMessage("Phone number is not valid.", context);
    } else if (passwordTxtController.text.length < 8) {
      displayToastMessage(
          "Password need to be at least 8 characters long.", context);
    } else if (rePasswordTxtController.text != passwordTxtController.text) {
      displayToastMessage("Password dont match.", context);
    } else {
      return true;
    }
    return false;
  }
}

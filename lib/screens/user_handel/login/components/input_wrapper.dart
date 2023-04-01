import 'package:flutter/material.dart';

import 'signup_button.dart';
import 'input_field.dart';
import 'login_button.dart';

class InputWrapper extends StatelessWidget {
  const InputWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 40,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: const InputField(),
            ),
            const SizedBox(
              height: 40,
            ),
            const Text(
              "Forgot Password?",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(
              height: 40,
            ),
            // LoginButton(),
            const SizedBox(
              height: 40,
            ),
            Row(
              children: const [
                // SizedBox(
                //   height: 40,
                // ),
                Text(
                  "New here? ",
                  style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                SignUpButton(),
              ],
            )
          ],
        ),
      ),
    );
  }
}

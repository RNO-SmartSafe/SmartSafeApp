import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../widgets/toast_message.dart';
import '../../home/home_screen.dart';
import '../reusable_widgets.dart';
import 'components/header.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);
  static const String idScreen = "signup";

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignupScreen> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _userNameTextController = TextEditingController();
  final TextEditingController _phoneTextController = TextEditingController();
  final TextEditingController _rePasswordTextController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.topCenter, colors: [
                Colors.cyan[500]!,
                Colors.cyan[300]!,
                Colors.cyan[400]!
              ]),
            ),
            child: Column(children: <Widget>[
              const SizedBox(
                height: 90,
              ),
              const Header(),
              Expanded(
                  child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60),
                      topRight: Radius.circular(60),
                    )),
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom:
                                      BorderSide(color: Colors.grey[200]!))),
                          child: reusableTextField(
                              "Name",
                              Icons.person_outline,
                              false,
                              false,
                              _userNameTextController,
                              TextInputType.name),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom:
                                      BorderSide(color: Colors.grey[200]!))),
                          child: reusableTextField(
                            "Email",
                            Icons.email,
                            false,
                            false,
                            _emailTextController,
                            TextInputType.emailAddress,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom:
                                      BorderSide(color: Colors.grey[200]!))),
                          child: reusableTextField("Phone", Icons.phone, false,
                              true, _phoneTextController, TextInputType.phone),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom:
                                      BorderSide(color: Colors.grey[200]!))),
                          child: reusableTextField(
                              "Password",
                              Icons.lock_outlined,
                              true,
                              false,
                              _passwordTextController,
                              TextInputType.visiblePassword),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom:
                                      BorderSide(color: Colors.grey[200]!))),
                          child: reusableTextField(
                              "Confirm your password",
                              Icons.lock_outlined,
                              true,
                              false,
                              _rePasswordTextController,
                              TextInputType.visiblePassword),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        firebaseUIButton(context, "Sign Up", () {
                          if (validate(context)) {
                            FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                                    email: _emailTextController.text,
                                    password: _passwordTextController.text)
                                .then((value) {
                              print("Created New Account");
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const HomeScreen()));
                            }).onError((error, stackTrace) {
                              print("Error ${error.toString()}");
                            });
                          }
                        })
                      ],
                    ),
                  ),
                ),
              ))
            ])));
  }

  bool validate(value) {
    if (_emailTextController.text.isEmpty ||
        _phoneTextController.text.isEmpty ||
        _passwordTextController.text.isEmpty ||
        _userNameTextController.text.isEmpty ||
        _rePasswordTextController.text.isEmpty) {
      displayToastMessage('Please fill in all fields.', value);
      return false;
    } else if (_userNameTextController.text.length < 3) {
      displayToastMessage("Name must be at least 3 characters.", value);
      return false;
      // } else if (_emailTextController.text.contains('@') ||
      //     _emailTextController.text.endsWith('.com')) {
      //   displayToastMessage('Enter a Valid Email Address.', value);
      //   return false;
    } else if (_phoneTextController.text.trim().length < 10) {
      displayToastMessage(
          'Number must be at least 10 characters in length.', value);
      return false;
    } else if (!_phoneTextController.text.startsWith("05")) {
      displayToastMessage('Number must start with 05.', value);
      return false;
    } else if (_passwordTextController.text.trim().length < 6 ||
        _rePasswordTextController.text.trim().length < 6) {
      displayToastMessage(
          'Password must be at least 6 characters in length.', value);
      return false;
    } else if (_passwordTextController.text != _rePasswordTextController.text) {
      displayToastMessage('Both passwords must be identical.', value);
      return false;
    }
    return true;
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:smart_safe/models/firebaseuser.dart';
import 'package:smart_safe/models/signupUsers.dart';
import '../../../widgets/toast_message.dart';
import '../../home/home_screen.dart';
import '../reusable_widgets.dart';
import 'components/header.dart';
import 'package:smart_safe/models/FirebaseUser.dart';

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
  final TextEditingController _companyTextController = TextEditingController();
  final TextEditingController _phoneTextController = TextEditingController();
  final TextEditingController _rePasswordTextController =
      TextEditingController();
  String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  final _newUser = SignupUsers(
      id: 0, name: '', company: '', email: '', password: '', phone: 0);
  // FirebaseUser()
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
                            child: TextFormField(
                              decoration: const InputDecoration(
                                labelText: "Name",
                                prefixIcon: Icon(
                                  Icons.person_outline,
                                  color: Colors.grey,
                                ),
                                hintStyle: TextStyle(color: Colors.grey),
                                border: InputBorder.none,
                              ),
                              controller: _userNameTextController,
                              keyboardType: TextInputType.name,
                              onSaved: (val) =>
                                  setState(() => _newUser.name = val!),
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom:
                                        BorderSide(color: Colors.grey[200]!))),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                labelText: "Company",
                                prefixIcon: Icon(
                                  Icons.business_center,
                                  color: Colors.grey,
                                ),
                                hintStyle: TextStyle(color: Colors.grey),
                                border: InputBorder.none,
                              ),
                              controller: _companyTextController,
                              keyboardType: TextInputType.name,
                              onSaved: (val) =>
                                  setState(() => _newUser.company = val!),
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom:
                                        BorderSide(color: Colors.grey[200]!))),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                labelText: "Email",
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: Colors.grey,
                                ),
                                hintStyle: TextStyle(color: Colors.grey),
                                border: InputBorder.none,
                              ),
                              controller: _emailTextController,
                              keyboardType: TextInputType.emailAddress,
                              onSaved: (val) =>
                                  setState(() => _newUser.email = val!),
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom:
                                        BorderSide(color: Colors.grey[200]!))),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                labelText: "Phone",
                                prefixIcon: Icon(
                                  Icons.phone,
                                  color: Colors.grey,
                                ),
                                hintStyle: TextStyle(color: Colors.grey),
                                border: InputBorder.none,
                              ),
                              controller: _phoneTextController,
                              keyboardType: TextInputType.phone,
                              onSaved: (val) =>
                                  setState(() => _newUser.phone = val! as int),
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom:
                                        BorderSide(color: Colors.grey[200]!))),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                labelText: "Password",
                                prefixIcon: Icon(
                                  Icons.lock_outlined,
                                  color: Colors.grey,
                                ),
                                hintStyle: TextStyle(color: Colors.grey),
                                border: InputBorder.none,
                              ),
                              obscureText: true,
                              controller: _passwordTextController,
                              keyboardType: TextInputType.visiblePassword,
                              onSaved: (val) =>
                                  setState(() => _newUser.password = val!),
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom:
                                        BorderSide(color: Colors.grey[200]!))),
                            child: TextFormField(
                                decoration: const InputDecoration(
                                  labelText: "Confirm your password",
                                  prefixIcon: Icon(
                                    Icons.lock_outlined,
                                    color: Colors.grey,
                                  ),
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: InputBorder.none,
                                ),
                                obscureText: true,
                                controller: _rePasswordTextController,
                                keyboardType: TextInputType.visiblePassword)),
                        const SizedBox(
                          height: 20,
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
                            Map<String, String> userToSave = {
                              'name': _userNameTextController.text,
                              'company': _companyTextController.text,
                              'email': _emailTextController.text,
                              'phone': _phoneTextController.text,
                              'password': _passwordTextController.text
                            };
                            FirebaseFirestore.instance
                                .collection('company')
                                .doc(_companyTextController.text.toString())
                                .collection('users')
                                .add(userToSave);
                            FirebaseFirestore.instance
                                .collection('users')
                                .add(userToSave);
                          }
                        }),
                        const SizedBox(
                          height: 20,
                        ),
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
        _companyTextController.text.isEmpty ||
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

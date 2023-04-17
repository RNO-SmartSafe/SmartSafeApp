import 'package:flutter/material.dart';
import 'package:smart_safe/models/loginuser.dart';
import 'package:smart_safe/screens/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_safe/screens/user_handel/signup/signup_screen.dart';
import '../reusable_widgets.dart';
import 'components/header.dart';

class LoginScreen extends StatefulWidget {
  static const String idScreen = "login";
  final Function? toggleView;
  LoginScreen({this.toggleView});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final _user = LoginUser(email: '', password: '');

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
        child: Column(
          children: <Widget>[
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
                              height: 40,
                            ),
                            Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                    labelText: "Email",
                                    prefixIcon: Icon(
                                      Icons.person_outline,
                                      color: Colors.grey,
                                    ),
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none,
                                  ),
                                  controller: _emailTextController,
                                  keyboardType: TextInputType.emailAddress,
                                  onSaved: (val) =>
                                      setState(() => _user.email = val!),
                                )),
                            Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey[200]!))),
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                    labelText: "Password",
                                    prefixIcon: Icon(
                                      Icons.vpn_key_outlined,
                                      color: Colors.grey,
                                    ),
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none,
                                  ),
                                  controller: _passwordTextController,
                                  keyboardType: TextInputType.visiblePassword,
                                  obscureText: true,
                                  onSaved: (val) =>
                                      setState(() => _user.email = val!),
                                )),
                            const SizedBox(
                              height: 40,
                            ),
                            forgetPassword(context),
                            const SizedBox(
                              height: 40,
                            ),
                            firebaseUIButton(context, "Sign In", () {
                              FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                      email: _emailTextController.text,
                                      password: _passwordTextController.text)
                                  .then((value) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const HomeScreen()));
                              }).onError((error, stackTrace) {
                                print("Error ${error.toString()}");
                              });
                            }),
                            const SizedBox(
                              height: 40,
                            ),
                            signUpOption(context)
                          ],
                        ),
                      ),
                    )))
          ],
        ),
      ),
    );
  }
}

Row signUpOption(BuildContext context) {
  return Row(
    // mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Text(
        "New here? ",
        style: TextStyle(
            color: Colors.blueGrey, fontSize: 15, fontWeight: FontWeight.bold),
      ),
      TextButton(
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
    ],
  );
}

Widget forgetPassword(BuildContext context) {
  return SizedBox(
    width: MediaQuery.of(context).size.width,
    height: 35,
    child: TextButton(
      child: const Text(
        "Forgot Password?",
        style: TextStyle(color: Colors.grey),
        textAlign: TextAlign.center,
      ),
      onPressed: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => const HomeScreen())),
    ),
  );
}

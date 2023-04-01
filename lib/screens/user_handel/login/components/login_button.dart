// import 'package:flutter/material.dart';
// import 'package:smart_safe/screens/home/home_screen.dart';

// import 'package:firebase_auth/firebase_auth.dart';

// import '../../../../widgets/toast_message.dart';
// import '../../reusable_widgets.dart';
// import '../../signup/signup_screen.dart';

// class LoginButton extends StatelessWidget {
//   LoginButton({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 50,
//       margin: const EdgeInsets.symmetric(horizontal: 50),
//       decoration: BoxDecoration(
//         color: Colors.cyan[500],
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: ElevatedButton(
//         style: ElevatedButton.styleFrom(primary: Colors.cyan[500]),
//         onPressed: () {
//           firebaseUIButton(context, "Sign In", () {
//             FirebaseAuth.instance
//                 .signInWithEmailAndPassword(
//                     // email: _emailTextController.text,
//                     // password: _passwordTextController.text)
//                 .then((value) {
//               Navigator.push(context,
//                   MaterialPageRoute(builder: (context) => const HomeScreen()));
//             }).onError((error, stackTrace) {
//               print("Error ${error.toString()}");
//             });
//           });
//           signUpOption();
//         },
//         child: const Center(
//           child: Text(
//             "Submit",
//             style: TextStyle(
//                 color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
//           ),
//         ),
//       ),
//     );

// //   bool validate(value) {
// //     if (_emailTextController.text.isEmpty ||
// //         _passwordTextController.text.isEmpty) {
// //       displayToastMessage('Please fill in all fields.', value);
// //       return false;
// //     } // } else if (_emailTextController.text.contains('@') ||
// //       //     _emailTextController.text.endsWith('.com')) {
// //       //   displayToastMessage('Enter a Valid Email Address.', value);
// //       //   return false;
// //     }

// //     return true;
// //   }
//   }
// }

// Row signUpOption() {
//   return Row(
//     mainAxisAlignment: MainAxisAlignment.center,
//     children: [
//       const Text("Don't have account?",
//           style: TextStyle(color: Colors.white70)),
//       GestureDetector(
//         onTap: () {
//           // Navigator.push(
//           //     context, MaterialPageRoute(builder: (context) => const SignupScreen()));
//         },
//         child: const Text(
//           " Sign Up",
//           style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//         ),
//       )
//     ],
//   );
// }

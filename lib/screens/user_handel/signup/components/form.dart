// import 'package:flutter/material.dart';

// import '../../../../services/auth.dart';
// import '../../../../style/fonts.dart';
// import 'form_field.dart';
// import 'password.dart';

// class SignupForm extends StatefulWidget {
//   final TextEditingController nameTxtController;
//   final TextEditingController emailTxtController;
//   final TextEditingController phoneTxtController;
//   final TextEditingController rePasswordTxtController;
//   final TextEditingController passwordTxtController;

//   const SignupForm({
//     super.key,
//     required this.nameTxtController,
//     required this.emailTxtController,
//     required this.phoneTxtController,
//     required this.rePasswordTxtController,
//     required this.passwordTxtController,
//   });

//   @override
//   State<SignupForm> createState() => _SignupFormState();
// }

// class _SignupFormState extends State<SignupForm> {
//   final AuthService _auth = new AuthService();
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         FormTextField(
//           icon: Icons.person,
//           name: 'Name',
//           txtController: widget.nameTxtController,
//           keyboardType: TextInputType.name,
//           validator: (value) {
//             if (value == null || value.trim().isEmpty) {
//               return 'This field is required';
//             }
//             return null;
//           },
//         ),
//         const SizedBox(height: formPadding),
//         FormTextField(
//           icon: Icons.email,
//           name: 'Email',
//           txtController: widget.emailTxtController,
//           keyboardType: TextInputType.emailAddress,
//           validator: (value) {
//             if (value != null) {
//               if (value.contains('@') && value.endsWith('.com')) {
//                 return null;
//               }
//               return 'Enter a Valid Email Address';
//             }
//           },
//         ),
//         const SizedBox(height: formPadding),
//         FormTextField(
//           icon: Icons.phone,
//           name: 'Phone',
//           txtController: widget.phoneTxtController,
//           keyboardType: TextInputType.phone,
//           validator: (value) {
//             if (value == null || value.trim().isEmpty) {
//               return 'This field is required';
//             }
//             if (value.trim().length < 11) {
//               return 'Number must be at least 10 characters in length';
//             }
//             // Return null if the entered password is valid
//             return null;
//           },
//         ),
//         const SizedBox(height: formPadding),
//         PasswordField(
//           textController: widget.passwordTxtController,
//           name: "Password",
//           validator: (value) {
//             if (value == null || value.trim().isEmpty) {
//               return 'This field is required';
//             }
//             if (value.trim().length < 8) {
//               return 'Password must be at least 8 characters in length';
//             }
//             // Return null if the entered password is valid
//             return null;
//           },
//         ),
//         const SizedBox(height: formPadding),
//         PasswordField(
//           textController: widget.rePasswordTxtController,
//           name: "Confirm your password",
//           validator: (value) {
//             if (value == null || value.trim().isEmpty) {
//               return 'This field is required';
//             }
//             if (value.trim().length < 8) {
//               return 'Password must be at least 8 characters in length';
//             }
//             // Return null if the entered password is valid
//             return null;
//           },
//         ),
//         const SizedBox(height: formPadding),
//       ],
//     );
//   }
// }

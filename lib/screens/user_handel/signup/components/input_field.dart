// import 'package:flutter/material.dart';

// import '../../../../style/fonts.dart';
// import 'form.dart';
// import 'submit_button.dart';

// class InputField extends StatelessWidget {
//   TextEditingController nameTxtController = TextEditingController();
//   TextEditingController emailTxtController = TextEditingController();
//   TextEditingController phoneTxtController = TextEditingController();
//   TextEditingController passwordTxtController = TextEditingController();
//   TextEditingController rePasswordTxtController = TextEditingController();

//   InputField({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: <Widget>[
//         Container(
//             padding: const EdgeInsets.all(10),
//             decoration: BoxDecoration(
//                 border: Border(bottom: BorderSide(color: Colors.grey[200]!))),
//             child: Padding(
//               padding: const EdgeInsets.all(10),
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     _form(),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     _submitBtn(),
//                   ],
//                 ),
//               ),
//             )),
//       ],
//     );
//   }

//   Widget _submitBtn() {
//     return Submit(
//       nameTxtController: nameTxtController,
//       emailTxtController: emailTxtController,
//       phoneTxtController: phoneTxtController,
//       passwordTxtController: passwordTxtController,
//       rePasswordTxtController: rePasswordTxtController,
//     );
//   }

//   Widget _form() {
//     return SignupForm(
//       nameTxtController: nameTxtController,
//       emailTxtController: emailTxtController,
//       phoneTxtController: phoneTxtController,
//       passwordTxtController: passwordTxtController,
//       rePasswordTxtController: rePasswordTxtController,
//     );
//   }
// }

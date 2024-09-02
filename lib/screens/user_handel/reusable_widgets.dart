import 'package:flutter/material.dart';

Image logoWidget(String imageName) {
  return Image.asset(
    imageName,
    fit: BoxFit.fitWidth,
    width: 240,
    height: 240,
    color: Colors.white,
  );
}

TextField reusableTextField(
    String text,
    IconData icon,
    bool isPasswordType,
    bool isPhoneType,
    TextEditingController controller,
    TextInputType keyboardType) {
//   return FormTextField(
//       txtController: controller,
//       icon: icon,
//       name: text,
//       keyboardType: keyboardType,
//       validator: (value) => {
//             if (keyboardType == TextInputType.visiblePassword)
//               {
//                 const TextField(
//                   obscureText: true,
//                 )
//               }
//           });
// }
  return TextField(
    controller: controller,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    // cursorColor: Colors.white,
    // style: TextStyle(color: Colors.white.withOpacity(0.9)),
    decoration: InputDecoration(
      prefixIcon: Icon(
        icon,
        color: Colors.grey,
      ),
      hintStyle: const TextStyle(color: Colors.grey),
      border: InputBorder.none,
      hintText: text,
      // labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
      // filled: false,
      // floatingLabelBehavior: FloatingLabelBehavior.never,
      // fillColor: Colors.white.withOpacity(0.3),
    ),
    keyboardType: isPasswordType
        ? TextInputType.visiblePassword
        : isPhoneType
            ? TextInputType.phone
            : TextInputType.emailAddress,
  );
}

Container firebaseUIButton(
    BuildContext context, String title, VoidCallback onTap) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 50,
    margin: const EdgeInsets.symmetric(horizontal: 50),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(90),
    ),
    child: ElevatedButton(
      onPressed: onTap,
      // style: ElevatedButton.styleFrom(
      //   backgroundColor: Colors.cyan[500], // background color
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(30),
      //   ),
      // ),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

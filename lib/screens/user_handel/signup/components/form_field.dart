import 'package:flutter/material.dart';

class FormTextField extends StatelessWidget {
  final TextEditingController txtController;
  final String name;
  final IconData icon;
  final TextInputType keyboardType;
  final dynamic validator;

  const FormTextField({
    super.key,
    required this.txtController,
    required this.name,
    required this.icon,
    required this.keyboardType,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey[200]!))),
          child: TextField(
            obscureText: false,
            enableSuggestions: false,
            autocorrect: false,
            controller: txtController,
            keyboardType: keyboardType,
            style: const TextStyle(color: Colors.grey),
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Icon(icon, color: Colors.grey),
              hintText: name,
              hintStyle: const TextStyle(color: Colors.grey),
            ),
          ),
        ),
      ],
    );
  }
}

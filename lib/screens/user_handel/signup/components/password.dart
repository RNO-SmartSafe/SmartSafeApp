import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController textController;
  final String name;
  final dynamic validator;
  const PasswordField({
    super.key,
    required this.textController,
    required this.name,
    required this.validator,
  });

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool sec = true;
  bool rememberpwd = false;

  var visable = const Icon(
    Icons.visibility,
    color: Color(0xff4c5166),
  );
  var visableoff = const Icon(
    Icons.visibility_off,
    color: Color(0xff4c5166),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          child: TextField(
            controller: widget.textController,
            obscureText: sec,
            style: const TextStyle(color: Colors.black),
            decoration: InputDecoration(
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    sec = !sec;
                    sec = !sec;
                  });
                },
                icon: sec ? visableoff : visable,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.only(top: 14),
              prefixIcon: const Icon(
                Icons.vpn_key,
                color: Color(0xff4c5166),
              ),
              hintText: widget.name,
              hintStyle: const TextStyle(color: Colors.black38),
            ),
          ),
        ),
      ],
    );
  }
}

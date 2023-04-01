import 'package:provider/provider.dart';
import 'package:smart_safe/screens/user_handel/login/components/handler.dart';
import '../screens/home/home_screen.dart';
import 'package:flutter/material.dart';

import '../models/FirebaseUser.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser?>(context);
    if (user == null) {
      return const Handler();
    } else {
      return const HomeScreen();
    }
  }
}

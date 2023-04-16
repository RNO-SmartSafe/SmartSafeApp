import 'package:flutter/material.dart';
import 'package:smart_safe/screens/home/home_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        elevation: 20,
        child: Column(
          children: <Widget>[
            AppBar(
              title: const Text('Hello Friend!'),
              automaticallyImplyLeading: false,
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.shop),
              title: const Text('Home'),
              onTap: () {
                Navigator.of(context).pushReplacementNamed('/');
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {
                Navigator.of(context).pushReplacementNamed(HomeScreen.idScreen);
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.data_thresholding_outlined),
              title: const Text('Statistics'),
              onTap: () {
                // Navigator.of(context)
                // .pushReplacementNamed(UserProductsScreen.routName);
              },
            )
          ],
        ));
  }
}

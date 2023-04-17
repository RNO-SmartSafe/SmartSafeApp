import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:smart_safe/screens/home/home_screen.dart';
import 'package:smart_safe/screens/reports/reports_screen.dart';
import 'package:smart_safe/screens/signupEmployees/signupEmployeesScreen.dart';
import 'package:smart_safe/screens/user_handel/signup/signup_screen.dart';
import 'package:smart_safe/screens/wrapper.dart';
import 'models/FirebaseUser.dart';
import 'package:smart_safe/services/auth.dart';
import 'screens/user_handel/login/login_screen.dart';

// import 'providers/auth_provider.dart';
// import 'screens/home/home_screen.dart';
// import 'screens/user_handel/profile/profile_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // qrCode.make();

  await Firebase.initializeApp();
  FirebaseApp defaultApp = Firebase.app();
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: AuthService(),
        ),
      ],
      child: MaterialApp(
        // return MaterialApp(
        initialRoute: HomeScreen.idScreen,
        debugShowCheckedModeBanner: false,
        routes: {
          // main screen
          // HomeScreen.idScreen: (context) => const HomeScreen(),

          //user stuff
          LoginScreen.idScreen: (context) => LoginScreen(),
          SignupScreen.idScreen: (context) => const SignupScreen(),
          //   // ProfileScreen.idScreen: (context) => const ProfileScreen(),

          //   //features
          //   // CalculatorScreen.idScreen: (context) => const CalculatorScreen(),
          //   // InfoScreen.idScreen: (context) => const InfoScreen(),
          //   // TranspotationScreen.idScreen: (context) =>
          //   //     const TranspotationScreen(),
          //   // RecycleScreen.idScreen: (context) => const RecycleScreen(),
          //   // GameScreen.idScreen: (context) => const GameScreen(),

          //   //shop
          ReportsScreen.idScreen: (context) => const ReportsScreen(),
          SignupEmployessScreen.idScreen: (context) =>
              const SignupEmployessScreen(),
          //   // NewShopScreen.idScreen: (context) => const NewShopScreen(),
          //   // ProductFullScreen.idScreen: (context) => const ProductFullScreen(),

          //   //addons?
          //   // CameraDetector.idScreen: (context) => const CameraDetector(),
          //   // BarcodeScreen.idScreen: (context) => const BarcodeScreen(),
        },
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.black,
          buttonTheme: ButtonThemeData(
            buttonColor: Colors.black,
            textTheme: ButtonTextTheme.primary,
            colorScheme:
                Theme.of(context).colorScheme.copyWith(secondary: Colors.white),
          ),
          // child: MaterialApp(
          // initialRoute: LoginScreen.idScreen,
          //   debugShowCheckedModeBanner: false,
          //   routes: {
          //     //main screen
          //     // HomeScreen.idScreen: (context) => const HomeScreen(),

          //     //user stuff
          //     LoginScreen.idScreen: (context) => const LoginScreen(),
          //     SignupScreen.idScreen: (context) => const SignupScreen(),
          //     // ProfileScreen.idScreen: (context) => const ProfileScreen(),

          //     //features
          //     // CalculatorScreen.idScreen: (context) => const CalculatorScreen(),
          //     // InfoScreen.idScreen: (context) => const InfoScreen(),
          //     // TranspotationScreen.idScreen: (context) =>
          //     //     const TranspotationScreen(),
          //     // RecycleScreen.idScreen: (context) => const RecycleScreen(),
          //     // GameScreen.idScreen: (context) => const GameScreen(),

          //     //shop
          //     // ShopScreen.idScreen: (context) => const ShopScreen(),
          //     // NewShopScreen.idScreen: (context) => const NewShopScreen(),
          //     // ProductFullScreen.idScreen: (context) => const ProductFullScreen(),

          //     //addons?
          //     // CameraDetector.idScreen: (context) => const CameraDetector(),
          //     // BarcodeScreen.idScreen: (context) => const BarcodeScreen(),
          //   },
          // );
        ),
        home: const Wrapper(),
        // home: const HomeScreen(),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:smart_safe/screens/home/home_screen.dart';
import 'package:smart_safe/screens/reports/reports_screen.dart';
import 'package:smart_safe/screens/signupEmployees/signupEmployeesScreen.dart';
import 'package:smart_safe/screens/user_handel/signup/signup_screen.dart';
import 'package:smart_safe/screens/wrapper.dart';
import 'package:smart_safe/services/PushNotificationService.dart';
import 'package:smart_safe/services/notifications.dart';
import 'firebase_options.dart';
import 'models/FirebaseUser.dart';
import 'package:smart_safe/services/auth.dart';
import 'screens/user_handel/login/login_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'providers/auth_provider.dart';
// import 'screens/home/home_screen.dart';
// import 'screens/user_handel/profile/profile_screen.dart';

final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // qrCode.make()
  await Firebase.initializeApp();
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  FirebaseFunctions functions = FirebaseFunctions.instance;

  await firebaseMessaging.requestPermission();
  String? token = await firebaseMessaging.getToken();
  print('token $token'); // this is how I get the token for now

  configureFirebaseMessaging();

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
          // HomeScreen.idScreen: (context) => const HomeScreen(),

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

Future<void> createUser() async {
  HttpsCallable callable =
      FirebaseFunctions.instance.httpsCallable('createUser');
  final resp = await callable.call(<String, dynamic>{
    'text': 'A message sent from a client device',
  });
  print("result: ${resp.data}");
}

Future<void> saveTokenToDatabase(String token) async {
  // Assume user is logged in for this example
  String userId = FirebaseAuth.instance.currentUser!.uid;

  await FirebaseFirestore.instance.collection('users').doc(userId).update({
    'tokens': FieldValue.arrayUnion([token]),
  });
}

Future<void> onUserPictureLiked(String token) async {
  // Assume user is logged in for this example
  await FirebaseFirestore.instance.collection('users').doc(token).update({
    'tokens': FieldValue.arrayUnion([token]),
  });
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
  // Implement custom logic to handle the background message here
}

void configureFirebaseMessaging() {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  // Handle messages when the app is in the foreground
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Foreground Message received: ${message.notification?.title}');
    // Handle the received message as desired
  });

  // Handle messages when the app is in the background or terminated
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
}

Future<void> sendNotifications(RemoteMessage message) async {
  print('Background Message received: ${message.notification?.title}');
  // Handle the received message as desired
}


// void showNotification(Map<String, dynamic> messageData) async {
//   const AndroidNotificationDetails androidPlatformChannelSpecifics =
//       AndroidNotificationDetails(
//     'channel_id',
//     'channel_name',
//     importance: Importance.max,
//     priority: Priority.high,
//   );

//   const NotificationDetails platformChannelSpecifics =
//       NotificationDetails(android: androidPlatformChannelSpecifics);

//   await _flutterLocalNotificationsPlugin.show(
//     0,
//     messageData['notification']['title'] as String,
//     messageData['notification']['body'] as String,
//     platformChannelSpecifics,
//   );
// }

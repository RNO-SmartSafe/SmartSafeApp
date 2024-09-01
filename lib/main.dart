import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:smart_safe/screens/home/home_screen.dart';
import 'package:smart_safe/screens/real_time_state/real_time_screen.dart';
import 'package:smart_safe/screens/reports/reports_screen.dart';
import 'package:smart_safe/screens/signupEmployees/signupEmployeesScreen.dart';
import 'package:smart_safe/screens/user_handel/signup/signup_screen.dart';
import 'package:smart_safe/screens/wrapper.dart';
import 'package:smart_safe/services/auth.dart';
import 'screens/user_handel/login/login_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  FirebaseFunctions functions = FirebaseFunctions.instance;

  await firebaseMessaging.requestPermission();
  var status = await Permission.storage.request();
  print("status $status");
  String? token = await firebaseMessaging.getToken();
  print('token $token');

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
        initialRoute: HomeScreen.idScreen,
        debugShowCheckedModeBanner: false,
        routes: {
          LoginScreen.idScreen: (context) => LoginScreen(),
          SignupScreen.idScreen: (context) => const SignupScreen(),
          RealTimeScreen.idScreen: (context) => const RealTimeScreen(),
          ReportsScreen.idScreen: (context) => const ReportsScreen(),
          SignupEmployessScreen.idScreen: (context) =>
              const SignupEmployessScreen(),
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
        ),
        // home: const Wrapper(),
        home: LoginScreen(),
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
  String userId = FirebaseAuth.instance.currentUser!.uid;

  await FirebaseFirestore.instance.collection('users').doc(userId).update({
    'tokens': FieldValue.arrayUnion([token]),
  });
}

Future<void> onUserPictureLiked(String token) async {
  await FirebaseFirestore.instance.collection('users').doc(token).update({
    'tokens': FieldValue.arrayUnion([token]),
  });
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}

void configureFirebaseMessaging() {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Foreground Message received: ${message.notification?.title}');
  });
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
}

Future<void> sendNotifications(RemoteMessage message) async {
  print('Background Message received: ${message.notification?.title}');
}

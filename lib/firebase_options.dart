// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCDOQiBrUILrdmkQfmvSBFEFFSvRKb4t5s',
    appId: '1:61996553605:web:98b59be6f4d0ae62da20ec',
    messagingSenderId: '61996553605',
    projectId: 'smartsafe-a050e',
    authDomain: 'smartsafe-a050e.firebaseapp.com',
    databaseURL: 'https://smartsafe-a050e-default-rtdb.firebaseio.com',
    storageBucket: 'smartsafe-a050e.appspot.com',
    measurementId: 'G-BYH91P4ZC4',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAHm69ZI-DmG9lobAXhv5gS3HXSIWF_0jY',
    appId: '1:61996553605:android:ee7092ce074dd04cda20ec',
    messagingSenderId: '61996553605',
    projectId: 'smartsafe-a050e',
    databaseURL: 'https://smartsafe-a050e-default-rtdb.firebaseio.com',
    storageBucket: 'smartsafe-a050e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAVMx94r0WiZZL138hLy5g2-7YiZZRXTlY',
    appId: '1:61996553605:ios:b72a4b1cc8bf10c1da20ec',
    messagingSenderId: '61996553605',
    projectId: 'smartsafe-a050e',
    databaseURL: 'https://smartsafe-a050e-default-rtdb.firebaseio.com',
    storageBucket: 'smartsafe-a050e.appspot.com',
    iosClientId: '61996553605-4u1v4926ik5qs2j5sbhpfiiq6aee2e2u.apps.googleusercontent.com',
    iosBundleId: 'com.example.smartSafe',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAVMx94r0WiZZL138hLy5g2-7YiZZRXTlY',
    appId: '1:61996553605:ios:b72a4b1cc8bf10c1da20ec',
    messagingSenderId: '61996553605',
    projectId: 'smartsafe-a050e',
    databaseURL: 'https://smartsafe-a050e-default-rtdb.firebaseio.com',
    storageBucket: 'smartsafe-a050e.appspot.com',
    iosClientId: '61996553605-4u1v4926ik5qs2j5sbhpfiiq6aee2e2u.apps.googleusercontent.com',
    iosBundleId: 'com.example.smartSafe',
  );
}
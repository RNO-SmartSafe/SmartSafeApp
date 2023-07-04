// import 'dart:js';

// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

// void setupFirebaseMessaging() {
//   // Request permission to receive push notifications (if needed).
//   _firebaseMessaging.requestPermission();

//   // Configure how the app handles incoming messages.
//   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//     // Handle the received message when the app is in the foreground.
//     print('Received message: ${message.notification?.title}');
//   });

//   // Listen for changes in the Firestore collection or document.
//   FirebaseFirestore.instance.collection('notifications').snapshots().listen((snapshot) {
//     // Handle the Firestore snapshot change.
//     snapshot.docChanges.forEach((change) {
//       if (change.type == DocumentChangeType.added) {
//         // Extract necessary information from the added document.
//         String documentId = change.doc.id;
//         String title = change.doc['title'];
//         String body = change.doc['body'];

//         // Construct the notification payload.
//         var notificationPayload = {
//           'notification': {
//             'title': title,
//             'body': body,
//           },
//           'data': {
//             'documentId': documentId,
//           },
//         };

//         // Send the push notification.
//         _sendPushNotification(notificationPayload);
//       }
//     });
//   });
// }

// Future<void> sendNotification(String promoId, String promoDesc) async {
// final results = CloudFunctions.instance
// .getHttpsCallable(functionName: 'sendNotification')
// .call({"your_param_sent_from_the_client": param});
// print(results);
// }

// void _sendPushNotification(Map<String, dynamic> payload) async {
//   FirebaseMessaging.onMessage.listen((event) {
//   // fetchRideInfo(getRideID(message), context);
//   (Map<String, dynamic> message) async => sendNotification(getRideID(message), context);
//   });

//   FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//     // fetchRideInfo(getRideID(message), context);
//     (Map<String, dynamic> message) async => fetchRideInfo(getRideID(message), context);
//   });
// }
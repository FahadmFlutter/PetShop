// import 'dart:convert';
//
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:petshop/UI/Screens/Notification.dart';
// import 'package:petshop/main.dart';
//
// import '../UI/Screens/notificationScreen.dart';
//
//
// class FirebaseApi {
//
//
//
//   void handleMessage(RemoteMessage? message) {
//     if (message == null) return;
//     navigatorKey.currentState?.pushNamed(
//         NotificationScreen.route,
//         arguments: message
//     );
//   }
//
//   Future initPushNotification() async {
//     await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//
//     FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
//     FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
//     FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
//     FirebaseMessaging.onMessage.listen(
//           (message) {
//         final notification = message.notification;
//         if (notification == null) return;
//         _localNotification.show(
//             notification.hashCode,
//             notification.title,
//             notification.body,
//             NotificationDetails(
//               android: AndroidNotificationDetails(
//                 _androidChannel.id,
//                 _androidChannel.name,
//                 channelDescription: _androidChannel.description,
//                 icon: '@drawable/ic_launcher',
//               ),
//             ),
//             payload: jsonEncode(message.toMap())
//         );
//       },
//     );
//   }
//
//   Future initLocalNotification()async{
//     // const iOS =IOSInitializationSettings();
//     const android =AndroidInitializationSettings('@drawable/ic_launcher');
//     const settings = InitializationSettings(android: android,);
//
//     await _localNotification.initialize(
//         settings,
//         onSelectNotification: (payload){
//           final message = RemoteMessage.fromMap(jsonDecode(payload!));
//           handleMessage(message);
//         }
//     );
//
//     final platform = _localNotification.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
//     await platform?.createNotificationChannel(_androidChannel);
//   }
//
//   Future<void> handleBackgroundMessage(RemoteMessage message) async {
//     print('Title: ${message.notification?.title}');
//     print('Body: ${message.notification?.body}');
//     print('Payload: ${message.data}');
//   }
//
//
//
//   final _androidChannel = const AndroidNotificationChannel(
//     'high_importance_channel',
//     'high_importance_Notification',
//     description: 'This channel is used for important notification',
//     importance: Importance.defaultImportance,
//   );
//   final _localNotification = FlutterLocalNotificationsPlugin();
//
//   final _firebaseMessaging = FirebaseMessaging.instance;
//
//   Future<void> initNotification() async {
//     await _firebaseMessaging.requestPermission();
//     final fCMToken = await _firebaseMessaging.getToken();
//     print('Token : $fCMToken');
//     initPushNotification();
//     initLocalNotification();
//   }
// }

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


import 'Api/Notification_Services.dart';
import 'UI/Register_pages/Log_inScreen.dart';
import 'firebase_options.dart';

final navigatorKey= GlobalKey<NavigatorState>();


Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp( options: DefaultFirebaseOptions.currentPlatform,);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // await FirebaseApi().initNotification();
  runApp(const MyApp());

}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async{
  await Firebase.initializeApp();
  print('hello'+message.notification!.title.toString());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    NotificationServices().requestNotificationPermission();
    NotificationServices().firebaseInit(context);
    // notificationServices.isTokenRefresh();
    NotificationServices().getDeviceToken().then((value) {
      if (kDebugMode) {
        print('Device token');
        print(value);
      }

    });
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pet Shop',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff0E697C)),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const LogIn(),
    );
  }
}

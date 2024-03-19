import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:petshop/UI/Screens/notificationScreen.dart';

import '../utils/utils.dart';


class NotificationServices {

  final ref = FirebaseDatabase.instance.ref('Post');


  final fireStoreNotification = FirebaseFirestore.instance.collection('notification');


  //initialising firebase message plugin
  FirebaseMessaging messaging = FirebaseMessaging.instance ;

  //initialising firebase message plugin
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin  = FlutterLocalNotificationsPlugin();

  //function to initialise flutter local notification plugin to show notifications for android when app is active
  void initLocalNotifications(BuildContext context, RemoteMessage message)async{
    var androidInitializationSettings = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInitializationSettings = const DarwinInitializationSettings();
    if (kDebugMode) {
      print('==============initLocalNotifications=============');
    }
    var initializationSetting = InitializationSettings(
        android: androidInitializationSettings ,
        iOS: iosInitializationSettings
    );

    await _flutterLocalNotificationsPlugin.initialize(
        initializationSetting,
        onDidReceiveNotificationResponse: (payload){
          // handle interaction when app is active for android
          handleMessage(context, message);
          if (kDebugMode) {
            print('============== _flutterLocalNotificationsPlugin =============');
          }
        }
    );
  }

  void firebaseInit(BuildContext context){
    if (kDebugMode) {
      print('============== firebaseInit =============');
    }
    FirebaseMessaging.onMessage.listen((message) {
      RemoteNotification? notification = message.notification ;

      print("notifications title:${notification!.title}");
      print("notifications body:${notification.body}");

      if(Platform.isIOS){
        foregroundMessage();
      }
      if(Platform.isAndroid){
        initLocalNotifications(context, message);
        showNotification(message);
      }
    });
  }

  void requestNotificationPermission() async {
    if (kDebugMode) {
      print('==============requestNotificationPermission=============');
    }
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true ,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      if (kDebugMode) {
        print('user granted permission');
      }
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      if (kDebugMode) {
        print('user granted provisional permission');
      }
    } else {
      // appsetting.AppSettings.openNotificationSettings();
      if (kDebugMode) {
        print('user denied permission');
      }
    }
  }

  // function to show visible notification when app is active
  Future<void> showNotification(RemoteMessage message)async{
    if (kDebugMode) {
      print('===============showNotification===================');
    }
    AndroidNotificationChannel channel = AndroidNotificationChannel(
        message.notification!.android!.channelId.toString(),
        message.notification!.android!.channelId.toString() ,
        importance: Importance.max  ,
        showBadge: true ,
        playSound: true,

    );

    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(

        channel.id.toString(),
        channel.name.toString() ,
        channelDescription: 'your channel description',
        importance: Importance.high,
        priority: Priority.high ,
        playSound: true,
        ticker: 'ticker' ,
        sound: channel.sound
      //     sound: RawResourceAndroidNotificationSound('jetsons_doorbell')
      //  icon: largeIconPath
    );

    const DarwinNotificationDetails darwinNotificationDetails = DarwinNotificationDetails(
        presentAlert: true ,
        presentBadge: true ,
        presentSound: true
    ) ;

    NotificationDetails notificationDetails = NotificationDetails(

        android: androidNotificationDetails,
        iOS: darwinNotificationDetails
    );

    Future.delayed(Duration.zero , (){
      if (kDebugMode) {
        print('=============== ! Future.delayed ! ===================');
      }
      String id = DateTime.now().millisecondsSinceEpoch.toString();
      fireStoreNotification.doc(id).set({
        'title':  message.notification!.title.toString(),
        'body': message.notification!.body.toString(),


      }).then((value) {
        Utils().toastMessage('notification sent');
        if (kDebugMode) {
          print('notification sent');
        }
      }).onError((error, stackTrace) {
        Utils().toastMessage(error.toString());
      });


      //firebase database

      // String id = DateTime.now().millisecondsSinceEpoch.toString();
      // ref.child(id).set({
      //   'title':  message.notification!.title.toString(),
      //   'id':  message.notification!.body.toString(),
      // }).then((value) {
      //   Utils().toastMessage('Post added');
      // }).onError((error, stackTrace) {
      //   Utils().toastMessage(error.toString());
      // });

      //    //    //

      _flutterLocalNotificationsPlugin.show(
        0,
        message.notification!.title.toString(),
        message.notification!.body.toString(),
        notificationDetails ,
      );

    });

  }

  //function to get device token on which we will send the notifications
  Future<String> getDeviceToken() async {
    String? token = await messaging.getToken();
    return token!;
  }

  void isTokenRefresh()async{
    messaging.onTokenRefresh.listen((event) {
      event.toString();
      if (kDebugMode) {
        print('refresh');
      }
    });
  }

  //handle tap on notification when app is in background or terminated
  Future<void> setupInteractMessage(context)async{

    // when app is terminated
    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();

    if(initialMessage != null){
      handleMessage(context, initialMessage);
    }


    //when app ins background
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      handleMessage(context, event);
    });

  }

  void handleMessage(BuildContext context, RemoteMessage message) {

    if(message.data['type'] =='chat'){
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => NotificationScreen(
            id: message.data['id'] ,
          )));
    }
  }

  Future foregroundMessage() async {
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }


}
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class NotificationHelper {
  static final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'theenest_high_importance_channel', // id
    'High Importance Notifications Of The Enest', // title
    'This channel is used for important notifications of the Enest.', // description
    importance: Importance.high,
  );

  static final AndroidNotificationDetails androidNotificationDetails=AndroidNotificationDetails(
    channel.id,
    channel.name,
    channel.description,
    // TODO add a proper drawable resource to android, for now using
    //      one that already exists in example app.
    icon: '@mipmap/ic_launcher',
  );

  static final IOSNotificationDetails iosNotificationDetails=IOSNotificationDetails(
      badgeNumber: 1,
      subtitle: "TEST SUBTITLE",
      presentAlert: true,
      presentBadge: true,
      presentSound: true);

  static getDeviceToken() async {
    return await firebaseMessaging.getToken();
  }

  static requestPermission() async {
    NotificationSettings settings = await firebaseMessaging.requestPermission(
        announcement: true,
        carPlay: true,
        criticalAlert: true,
        provisional: false);
  }

  static handleNotification(context) async{
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    print("RUN NOTIFICATION");
    firebaseMessaging.getInitialMessage().then((RemoteMessage message) async{
      if (message != null) {
        RemoteNotification notification = message.notification;
        AndroidNotification android = message.notification?.android;
        if (notification != null && android != null) {
          flutterLocalNotificationsPlugin.show(
              notification.hashCode,
              notification.title,
              notification.body,
              NotificationDetails(
                  android: androidNotificationDetails,
                  iOS: iosNotificationDetails));
        }
        ///Do something...

        message=null;
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async{
      print("ON MESSAGE");
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
                android: androidNotificationDetails,
                iOS: iosNotificationDetails));
      }
      ///Do something...

      message=null;
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async{
      print("ON MESSAGE OPENED APP");
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
                android: androidNotificationDetails,
                iOS: iosNotificationDetails));
      }
      ///Do something...

      message=null;
    });

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }

  static Future<void> firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    print('Handle background notification');
  }
}

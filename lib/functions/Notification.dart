import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart';
import 'dart:io' show Platform;

class NotificationApi{
  static final _notifications = FlutterLocalNotificationsPlugin();
  //static final onNotifications = BehaviorSubject<String?>();

  static Future _notificationDetails() async{
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'channel id 2',
        'channel name',
        importance: Importance.max,
        sound: RawResourceAndroidNotificationSound('audio'),
        enableLights: true
      ),
      iOS: IOSNotificationDetails(presentSound: false),
    );
  }

  static Future init({bool initScheduled = false}) async{
    final android = AndroidInitializationSettings('@mipmap/ic_launcher');
    final iOS = IOSInitializationSettings();
    final settings = InitializationSettings(android: android, iOS: iOS);
    await _notifications.initialize(settings);
  }

  static Future showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async =>
      _notifications.show(id, title, body, await _notificationDetails());


  static Future showDailyAtTimeNotification({
    int id = 0,
    String? title,
    String? body,
    Time? time,
  }) async {
    var androidChannel = const AndroidNotificationDetails(
        'channel id 2',
        'channel name',
        importance: Importance.max,
        priority: Priority.high,
        sound: RawResourceAndroidNotificationSound('audio'),
        enableLights: true
    );
    var iosChannel = IOSNotificationDetails();
    var platformChannel = NotificationDetails(android: androidChannel, iOS: iosChannel);
    await _notifications.showDailyAtTime(id, title, body, time!, platformChannel);
  }
}
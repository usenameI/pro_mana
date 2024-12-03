
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pro_mana/permisstion/permisstion.dart';

///notificaiton funciton 
class notification {
  static bool grand = false;
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin=FlutterLocalNotificationsPlugin();
  static initNotification(BuildContext context) async {
    grand = await permisstion.requestNotification(context);
    if (!grand) {
      return;
    }
      const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }
  ///show on notification bar
  static showOnNotificationBar(
      {required String title,
      required String body,
      required String description}) {
    if (!grand) {
      return;
    }
    flutterLocalNotificationsPlugin.show(
      889,
      title,
      body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          'my_foreground1',
          'MY FOREGROUND SERVICE1',
          icon: '@mipmap/ic_launcher',
          ongoing: true,
          importance: Importance.min,
          priority: Priority.max,
          enableLights: true,
          enableVibration: true,
          showWhen: true,
          visibility: NotificationVisibility.public,
          styleInformation: BigTextStyleInformation(description),
          fullScreenIntent: true
        ),
      ),
    );
  }

  ///show on notification bar、banner and lock creen
    static showOnBannerAndLockScreen(
      {required String title,
      required String body,
      required String description}) {
    if (!grand) {
      return;
    }
    flutterLocalNotificationsPlugin.show(
      880,
      title,
      body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          'my_foreground2',
          'MY FOREGROUND SERVICE2',
          icon: '@mipmap/ic_launcher',
          ongoing: true,
          importance: Importance.max,
          priority: Priority.max,
          enableLights: true,
          enableVibration: true,
          showWhen: true,
          visibility: NotificationVisibility.public,
          styleInformation: BigTextStyleInformation(description),
          fullScreenIntent: true
        ),
      ),
    );
  }
}

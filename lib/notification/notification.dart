import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pro_mana/observer/observer.dart';
import 'package:pro_mana/permisstion/permisstion.dart';

///descript information when app in background for notification
///
///[title] indicate your notification title
///
///[body] indicate your notification body
///
///[description] indicate your notification detail description
class BackgroundDescriptionConfig {
  String title;
  String body;
  String description;
  BackgroundDescriptionConfig(
      {required this.title, required this.body, required this.description});
}

///notificaiton funciton
class notification {
  static bool grand = false;
  static bool? initialSucess = false;
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  /// if you have configured a [BackgroundDescriptionConfig], it can show a notification when your app in background to prompt user.
  static initNotification(BuildContext context,
      {required BackgroundDescriptionConfig?
          backgroundDescriptionConfig}) async {
    permisstion.requestNotification(context, callback: (p0) async {
      grand = p0;
      if (p0) {
        const AndroidInitializationSettings initializationSettingsAndroid =
            AndroidInitializationSettings('@mipmap/ic_launcher');

        const InitializationSettings initializationSettings =
            InitializationSettings(android: initializationSettingsAndroid);

        await flutterLocalNotificationsPlugin
            .initialize(initializationSettings)
            .then((value) {
          initialSucess = value;
        });

        ///if it be successfully initialized , add a globals broadcast to prompt user state of app in background or foreground
        if (backgroundDescriptionConfig != null) {
          ObserverGlobals().on('appState', (appState) {
            if (!appState) {
              var time=DateTime.now().toString().substring(0,19);
              showOnBannerAndLockScreen(
                  title: backgroundDescriptionConfig.title, 
                  body: '时间：$time', 
                  description: backgroundDescriptionConfig.description
                  );
            }
          });
        }
      }
    });
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
            'my_foreground1', 'MY FOREGROUND SERVICE1',
            icon: '@mipmap/ic_launcher',
            ongoing: true,
            importance: Importance.min,
            priority: Priority.max,
            enableLights: true,
            enableVibration: true,
            showWhen: true,
            visibility: NotificationVisibility.public,
            styleInformation: BigTextStyleInformation(description),
            fullScreenIntent: true),
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
            'my_foreground2', 'MY FOREGROUND SERVICE2',
            icon: '@mipmap/ic_launcher',
            ongoing: true,
            importance: Importance.max,
            priority: Priority.max,
            enableLights: true,
            enableVibration: true,
            showWhen: true,
            visibility: NotificationVisibility.public,
            styleInformation: BigTextStyleInformation(description),
            fullScreenIntent: true),
      ),
    );
  }
}


import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
///本地通知封装
class notification{
 static FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;

  static initNotification()async{
     const AndroidNotificationChannel channel = AndroidNotificationChannel(
    
    'my_foreground', // id
    'MY FOREGROUND SERVICE', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.max, // importance must be at low or higher level
    // lockscreenVisibility: NotificationVisibility.public,
    playSound: true
  );
    flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
        if (Platform.isIOS || Platform.isAndroid) {
    await flutterLocalNotificationsPlugin?.initialize(
       const InitializationSettings(
        iOS: DarwinInitializationSettings(),
         android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      ),
    );
  }

    await flutterLocalNotificationsPlugin
      ?.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);


  }
 static show(){
    flutterLocalNotificationsPlugin?.show(
      888, 
      '燃气勘察正在运行中', 
      'Awesome ${DateTime.now()}', 
       const NotificationDetails(
            android: AndroidNotificationDetails(
              'my_foreground',
              'MY FOREGROUND SERVICE',
              icon: '@mipmap/ic_launcher',
              ongoing: true,

                    importance: Importance.max,
      priority: Priority.max,
      enableLights: true,
      enableVibration: true,
      showWhen: true,
      visibility: NotificationVisibility.public,
      styleInformation: BigTextStyleInformation('这是通知的详细内容，您可以在这里显示更多信息。'),
            ),
          ),
      );
  }

}
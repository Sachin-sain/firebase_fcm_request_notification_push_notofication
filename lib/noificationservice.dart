import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationServices{

  final FirebaseMessaging messaging=FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

///notification Permission
  void requestNotificationPermission(BuildContext context)async{
    NotificationSettings settings=await messaging.requestPermission(
      sound: true,
      provisional: true,
      criticalAlert: true,
      carPlay: true,
       badge: true,
      announcement: true,
      alert: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.denied) {
      if (kDebugMode) {
        print("Permission denied");
      }
    } else if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      if (kDebugMode) {
        print("Permission granted");
      }
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      if (kDebugMode) {
        print("Provisional permission granted");
      }
    }
  }

///get Fcm Token
  void getFcmToken(BuildContext context)async{
    String? token=await messaging.getToken();
    print('FCM Token');
    print(token);
  }

  /// intilization notification
  void initializeLocalNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

     InitializationSettings initializationSettings =
    const InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }
  ///show notification
  void showNotification(RemoteMessage message) {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'channel_ID', 'channel_name',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);
    flutterLocalNotificationsPlugin.show(
      0,
      message.notification?.title,
      message.notification?.body,
      platformChannelSpecifics,
    );
  }

  ///listen Message

  void listenMessage(BuildContext context) {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (kDebugMode) {
        print("Message received: ${message.notification?.title}");
      }
      if (kDebugMode) {
        print("Message received: ${message.notification?.body}");
      }

      // Show notification when in the foreground
      showNotification(message);
    });
  }

}

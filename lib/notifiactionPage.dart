import 'package:flutter/material.dart';
import 'package:push_notification/noificationservice.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  void initState() {
    services.requestNotificationPermission(context);
    services.getFcmToken(context);
    services.initializeLocalNotifications();
    services.listenMessage(context);

    super.initState();
  }
  NotificationServices services=NotificationServices();
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Push Notification"),
          ],
        ),
      ),
    );
  }
}

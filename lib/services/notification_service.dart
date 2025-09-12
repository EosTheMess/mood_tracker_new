import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iOSInit = DarwinInitializationSettings(); // ✅ new API
    const settings = InitializationSettings(android: androidInit, iOS: iOSInit);

    await notificationsPlugin.initialize(settings);
  }

  Future<void> showNotification(String title, String body) async {
    const androidDetails = AndroidNotificationDetails(
      'mood_channel',
      'Mood Notifications',
      importance: Importance.max,
      priority: Priority.high,
    );
    const iOSDetails = DarwinNotificationDetails(); // ✅ new API

    const details = NotificationDetails(android: androidDetails, iOS: iOSDetails);

    await notificationsPlugin.show(0, title, body, details);
  }
}

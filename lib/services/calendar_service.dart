import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class CalendarService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> scheduleMoodReminder(DateTime date, String title, String body) async {
    await notificationsPlugin.zonedSchedule(
      0,
      title,
      body,
      tz.TZDateTime.from(date, tz.local), // ✅ fixed
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'mood_channel',
          'Mood Reminders',
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }
}

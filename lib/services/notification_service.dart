import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: AndroidInitializationSettings('app_icon'),
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void showNotification(String message, String title) async {
    flutterLocalNotificationsPlugin.show(
      message.hashCode,
      title,
      message,
      const NotificationDetails(
          android: AndroidNotificationDetails("123", "test",
              channelDescription: 'test')),
    );
  }
}

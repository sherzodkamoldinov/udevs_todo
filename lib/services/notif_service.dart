import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// ignore: depend_on_referenced_packages
import 'package:timezone/data/latest.dart' as tz;
// ignore: depend_on_referenced_packages
import 'package:timezone/timezone.dart' as tz;
import 'package:udevs_todo/data/models/todo_model/todo_hive_model.dart';

class LocalNotificationService {
  static final LocalNotificationService localNotificationService = LocalNotificationService._();

  factory LocalNotificationService() {
    return localNotificationService;
  }

  LocalNotificationService._();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  void init() {
    tz.initializeTimeZones();

    // init for android
    const AndroidInitializationSettings androidInitializationSettings = AndroidInitializationSettings('@mipmap/ic_launcher');

    // init for ios
    final DarwinInitializationSettings initializationSettingsDarwin = DarwinInitializationSettings(
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );

    // set
    InitializationSettings initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: initializationSettingsDarwin,
    );

    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
    );

    flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestPermission();
  }

  /// for android foreground
  void onDidReceiveNotificationResponse(
    NotificationResponse notificationResponse,
  ) async {}

  // for ios foreground
  void onDidReceiveLocalNotification(
    int id,
    String? title,
    String? body,
    String? payload,
  ) async {}

  //Android channel
  AndroidNotificationChannel androidNotificationChannel = const AndroidNotificationChannel(
    "todo_id_5",
    "udevs todo",
    importance: Importance.high,
    description: "Notification will push when task time came",
  );

  DarwinNotificationDetails darwinNotificationDetails = const DarwinNotificationDetails();

  void scheduleNotification({
    required TodoHiveModel todoModel,
  }) async {
    BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(todoModel.title, htmlFormatBigText: true, contentTitle: todoModel.categoryTitle, htmlFormatContentTitle: true);
    await flutterLocalNotificationsPlugin.zonedSchedule(
      todoModel.id, // :D
      todoModel.categoryTitle,
      todoModel.title,
      tz.TZDateTime.from(
        todoModel.dateTime,
        tz.local,
      ),
      NotificationDetails(
        android: AndroidNotificationDetails(
          androidNotificationChannel.id,
          androidNotificationChannel.name,
          importance: Importance.high,
          priority: Priority.high,
          channelDescription: 'Reminder about TODO',
          playSound: true,
          showProgress: true,
          styleInformation: bigTextStyleInformation,
        ),
      ),
      payload: "Hi!",
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    );
    debugPrint("TODO WITH ID : ${todoModel.id} NOTIF ADDED");
  }

  void cancelNotificationById(int id) {
    flutterLocalNotificationsPlugin.cancel(
      id,
    );
    debugPrint("TODO WITH ID : $id NOTIF CANCEL");
  }

  void cancelAllNotifications() {
    flutterLocalNotificationsPlugin.cancelAll();
  }
}

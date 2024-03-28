import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Controller/notification_controller.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final NotificationService _notificationService = NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationController notificationController = Get.put(NotificationController());

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  NotificationService._internal();

  Future<void> initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  // Future<void> showNotification() async {
  //   await flutterLocalNotificationsPlugin.zonedSchedule(
  //     0,
  //     notificationController.notificationNameController.text,
  //     "It's time to punch your record.",
  //     tz.TZDateTime.now(tz.local).add(Duration(seconds: 5)),
  //     const NotificationDetails(
  //         android: AndroidNotificationDetails(
  //             "your_channel_id",
  //             "your_channel_name",
  //             importance: Importance.max,
  //             priority: Priority.high,
  //           playSound: true
  //         )
  //     ),
  //     uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
  //     androidAllowWhileIdle: true,
  //   );
  // }

  tz.TZDateTime convertToTZDateTime(TimeOfDay time) {
    final now = tz.TZDateTime.now(tz.local);
    return tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );
  }

  Future<void> showDailyTimeNotification() async {
    var time = TimeOfDay(hour: 5, minute: 30); // Set the time for the notification
    var scheduledTime = convertToTZDateTime(time);

    var currentTime = tz.TZDateTime.now(tz.local);

    // Compare the scheduled time with the current time
    if (scheduledTime.isBefore(currentTime)) {
      // If the scheduled time is before the current time, add a day
      scheduledTime = scheduledTime.add(Duration(days: 1));
    }

    var androidChannel = AndroidNotificationDetails(
      "your_channel_id",
      "your_channel_name",
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      enableLights: true,
    );

    var platformChannel = NotificationDetails(android: androidChannel);

    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      notificationController.notificationNameController.text,
      "It's time to punch your record.",
      scheduledTime,
      platformChannel,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    );
  }


  Future<void> cancelNotifications(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}

// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// // import 'package:flutter_native_timezone/flutter_native_timezone.dart';
// import 'package:timezone/data/latest.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;
//
// class NotificationHelper {
//   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//   FlutterLocalNotificationsPlugin();
//
//   /// Initialize notification
//   initializeNotification() async {
//     _configureLocalTimeZone();
//     // const IOSInitializationSettings initializationSettingsIOS = IOSInitializationSettings();
//
//     const AndroidInitializationSettings initializationSettingsAndroid =
//     AndroidInitializationSettings("ic_launcher");
//
//     const InitializationSettings initializationSettings = InitializationSettings(
//       // iOS: initializationSettingsIOS,
//       android: initializationSettingsAndroid,
//     );
//     await flutterLocalNotificationsPlugin.initialize(initializationSettings);
//   }
//
//   /// Set right date and time for notifications
//   tz.TZDateTime _convertTime(int hour, int minutes) {
//     final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
//     tz.TZDateTime scheduleDate = tz.TZDateTime(
//       tz.local,
//       now.year,
//       now.month,
//       now.day,
//       hour,
//       minutes,
//     );
//     if (scheduleDate.isBefore(now)) {
//       scheduleDate = scheduleDate.add(const Duration(days: 1));
//     }
//     return scheduleDate;
//   }
//
//   Future<void> _configureLocalTimeZone() async {
//     tz.initializeTimeZones();
//     // final String timeZone = await FlutterNativeTimezone.getLocalTimezone();
//     // tz.setLocalLocation(tz.getLocation(timeZone));
//   }
//
//   /// Scheduled Notification
//   scheduledNotification({
//     required int hour,
//     required int minutes,
//     required int id,
//   }) async {
//     await flutterLocalNotificationsPlugin.zonedSchedule(
//       id,
//       'It\'s time to drink water!',
//       'After drinking, touch the cup to confirm',
//       _convertTime(hour, minutes),
//       NotificationDetails(
//         android: AndroidNotificationDetails(
//           'your channel id ',
//           'your channel name',
//           channelDescription: 'your channel description',
//           importance: Importance.max,
//           priority: Priority.high,
//           // sound: RawResourceAndroidNotificationSound(sound),
//         ),
//         // iOS: IOSNotificationDetails(sound: '$sound.mp3'),
//       ),
//       androidAllowWhileIdle: true,
//       uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
//       matchDateTimeComponents: DateTimeComponents.time,
//       payload: 'It could be anything you pass',
//     );
//   }
//
//   /// Request IOS permissions
//   void requestIOSPermissions() {
//     flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
//         ?.requestPermissions(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//   }
//
//   cancelAll() async => await flutterLocalNotificationsPlugin.cancelAll();
//   cancel(id) async => await flutterLocalNotificationsPlugin.cancel(id);
// }

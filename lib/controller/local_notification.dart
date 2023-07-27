import 'dart:developer';

import 'package:demo/controller/auth_controller.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:async';
import 'package:timezone/timezone.dart' as tz;
// import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static final localNotificationsPlugin = FlutterLocalNotificationsPlugin();
  Future<void> initNotification() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('flutter_logo');

    var initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {});

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await notificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {});
  }

  static notificationDetails() {
    print("object");
    return const NotificationDetails(
        android: AndroidNotificationDetails('channelId', 'channelName',
            importance: Importance.max),
        iOS: DarwinNotificationDetails());
  }

  Future showNotification(
      {int id = 0, String? title, String? body, String? payLoad}) async {
    return notificationsPlugin.show(
        id, title, body, await notificationDetails());
  }

///////////////////////////
  ///
  ///
  ///
  Future afterNoonNotification({id = 0, payload}) async {
    tz.initializeTimeZones();
    priceContent = await getNotificationContent("price_text?price_area=");

    localNotificationsPlugin.zonedSchedule(
        id,
        "Price Tips",
        priceContent ?? "",
        // tz.TZDateTime.from(DateTime.now().add(Duration(seconds: 5)), tz.local),
        await schedulDailyAfterNoon(TimeOfDay(hour: 14, minute: 0)),
        await notificationDetails(),
        payload: payload,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time);
  }

  Future<tz.TZDateTime> schedulDailyAfterNoon(TimeOfDay time) async {
    tz.initializeTimeZones();
    final now = tz.TZDateTime.now(tz.local);
    log(now.hour.toString() + ":" + now.minute.toString() + ":");
    log(now.location.toString());
    log(TimeOfDay.now().toString());
    final scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );
    print("test now time$now");
    print("test shedulr time$scheduledDate");

    if (scheduledDate.isBefore(now)) {
      priceContent = await getNotificationContent("price_text?price_area=");
      notificationDetails();
      return scheduledDate.add(const Duration(days: 1));
    } else {
      priceContent = await getNotificationContent("price_text?price_area=");
      notificationDetails();

      return scheduledDate;
    }
    // return scheduledDate.isBefore(now)
    //     ? scheduledDate.add(const Duration(days: 1))
    //     :
    //      scheduledDate;
  }

  ///////////////   morning tips  //////////////////////

  Future morningNotification({id = 0, payload}) async {
    tz.initializeTimeZones();
    savingTips = await getNotificationContent("saving_tips_text?price_area=");
    localNotificationsPlugin.zonedSchedule(
        id,
        "Saving Tips",
        priceContent ?? "tri",
        await schedulDailyMroning(TimeOfDay(hour: 9, minute: 00)),
        await notificationDetails(),
        payload: payload,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time);
  }

  Future<tz.TZDateTime> schedulDailyMroning(TimeOfDay time) async {
    tz.initializeTimeZones();
    final now = tz.TZDateTime.now(tz.local);
    log(now.hour.toString() + ":" + now.minute.toString() + ":");
    log(now.location.toString());
    log(TimeOfDay.now().toString());
    final scheduledDate = tz.TZDateTime(
        tz.local, now.year, now.month, now.day, time.hour, time.minute);
    print("test now time$now");
    print("test shedulr time$scheduledDate");

    if (scheduledDate.isBefore(now)) {
      savingTips = await getNotificationContent("saving_tips_text?price_area=");
      notificationDetails();
      print(priceContent);
      return scheduledDate.add(const Duration(days: 1));
    } else {
      savingTips = await getNotificationContent("saving_tips_text?price_area=");
      notificationDetails();
      return scheduledDate;
    }
    // return scheduledDate.isBefore(now)
    //     ? scheduledDate.add(const Duration(days: 1))
    //     :
    //      scheduledDate;
  }

  String? priceContent;
  String? savingTips;
  Future<String?> getNotificationContent(url) async {
    AuthController().fetchZoneIdFromFirestore();
    final pref = await SharedPreferences.getInstance();
    final zone = pref.getString('zone');
    String baseUrl =
        'https://predictor-tdg24xwvka-ew.a.run.app/get_push_notification_${url + zone}';
    final response = await Dio().get(baseUrl + url);
    if (response.statusCode == 200) {
      final result = response.data['text'];
      log(result);
      return result;
    }
    return null;
  }
}

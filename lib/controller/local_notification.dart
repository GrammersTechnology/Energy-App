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
    return const NotificationDetails(
        android: AndroidNotificationDetails('channelId', 'channelName',
            importance: Importance.max),
        iOS: DarwinNotificationDetails());
  }

///////////////////////////
  ///
  ///
  Future afterNoonNotification({id = 0, payload}) async {
    tz.initializeTimeZones();
    priceContent = await getNotificationContent("price_text?price_area=");
    log("Pice Tips+++++++++++++++++++:$priceContent");
    localNotificationsPlugin.zonedSchedule(
        id,
        "Price Tips",
        priceContent ?? "",
        await schedulDailyAfterNoon(const TimeOfDay(hour: 14, minute: 0)),
        await notificationDetails(),
        payload: payload,
        androidAllowWhileIdle: true,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time);
  }

  Future<tz.TZDateTime> schedulDailyAfterNoon(TimeOfDay time) async {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation("Europe/Paris"));
    final now = tz.TZDateTime.now(tz.local);
    final scheduledDate = tz.TZDateTime(
        tz.local, now.year, now.month, now.day, time.hour, time.minute);

    if (scheduledDate.isBefore(now)) {
      priceContent = await getNotificationContent("price_text?price_area=");
      notificationDetails();
      return scheduledDate.add(const Duration(days: 1));
    } else {
      priceContent = await getNotificationContent("price_text?price_area=");
      notificationDetails();

      return scheduledDate;
    }
  }

  ///////////////   morning tips  //////////////////////

  Future morningNotification({id = 0, payload}) async {
    tz.initializeTimeZones();
    savingTips = await getNotificationContent("saving_tips_text?price_area=");

    log("Saving Tips-------------------------:$savingTips");
    localNotificationsPlugin.zonedSchedule(
        id,
        "Saving Tips",
        savingTips ?? "",
        await schedulDailyMroning(const TimeOfDay(hour: 9, minute: 0)),
        await notificationDetails(),
        payload: payload,
        androidAllowWhileIdle: true,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time);
  }

  Future<tz.TZDateTime> schedulDailyMroning(TimeOfDay time) async {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation("Europe/Paris"));
    final now = tz.TZDateTime.now(tz.local);
    final scheduledDate = tz.TZDateTime(
        tz.local, now.year, now.month, now.day, time.hour, time.minute);

    if (scheduledDate.isBefore(now)) {
      savingTips = await getNotificationContent("saving_tips_text?price_area=");
      notificationDetails();
      return scheduledDate.add(const Duration(days: 1));
    } else {
      savingTips = await getNotificationContent("saving_tips_text?price_area=");
      notificationDetails();
      return scheduledDate;
    }
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
      return result;
    }
    return null;
  }

  showNotification() {
    morningNotification();
    afterNoonNotification();
  }
}

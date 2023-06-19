import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/home_services.dart';

class HomeController extends ChangeNotifier {
  List result = [];
  bool loader = false;
  fecthData(context) async {
    final perf = await SharedPreferences.getInstance();

    final zone = perf.getString("zone");
    await HomeScreenServicesScreen().dataDetailsApi(context, 'NO2');
    // if (data?.data != null) {
    //   print(data.toString());
    // }
    print(result.length);

    if (result.isNotEmpty) {
      for (int i = 0; i < result.length; i++) {
        final starteDate = result[i]['time_start'];
        final endDate = result[i]['time_end'];
        DateTime dateTimeStart = DateTime.parse(starteDate);
        DateTime dateTimeEnd = DateTime.parse(endDate);
        result[i]['time_start'] =
            "${dateTimeStart.day}-${dateTimeStart.month}-${dateTimeStart.year}";
        result[i]['time_end'] =
            "${dateTimeEnd.day}-${dateTimeEnd.month}-${dateTimeEnd.year}";
      }
    }
    loader = false;
  }
}

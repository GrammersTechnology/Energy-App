import 'dart:convert';
import 'dart:developer';

import 'package:demo/services/hav_koster_services.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/model.dart';

class HvaController extends ChangeNotifier {
  bool loader = false;

  HavKasterModel? hvaModel;
  List<dynamic> firstLevelValues = [];

  getHvaDetails() async {
    loader = true;
    log("message");
    final pref = await SharedPreferences.getInstance();
    String? zone = pref.getString('zone');
    log(zone.toString());
    if (zone != null) {
      final response = await HvaKasterServices().getHavKasterDetails(zone);
      if (response != null) {
        // hvaModel = response;
        List<String> firstLevelKeys = response.keys.toList();
        firstLevelValues = response.values.toList();

        print('Keys: $firstLevelKeys');
        print('Values: $firstLevelValues');
        // Map<String,dynamic>demo=
        // List<String> firstElements =
        //     firstLevelKeys.map((key) => response[key].toString()).toList();
        for (var element in firstLevelValues) {
          final value = element['details']['front_end_text'];
          final split = value.toString().split('');
          element['details']['front_end_text'] = split.first;
          log(element['details']['front_end_text'].toString());
          print("===========================================");
        }
        // log(data);
      }
    }
    loader = false;
    notifyListeners();
  }
}

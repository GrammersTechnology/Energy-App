// ignore_for_file: avoid_print

import 'package:demo/services/hav_koster_services.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../riverpod/Hva Koster/model/kva_koster.dart';

class HvaController extends ChangeNotifier {
  bool loader = false;

  HavKasterModel? hvaModel;
  List<dynamic> firstLevelValues = [];

  getHvaDetails() async {
    loader = true;

    final pref = await SharedPreferences.getInstance();

    String? zone = pref.getString('zone');
    if (zone != null) {
      final response = await HvaKasterServices().getHavKasterDetails(zone);
      if (response != null) {
        firstLevelValues.clear();
        firstLevelValues = response.values.toList();

        for (var element in firstLevelValues) {
          final value = element['details']['front_end_text'];
          final split = value.toString().split(' ');
          element['details']['front_end_text'] = split.first;
        }
      }
    }
    loader = false;
    notifyListeners();
  }
}

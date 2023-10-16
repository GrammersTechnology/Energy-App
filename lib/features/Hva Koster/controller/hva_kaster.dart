// ignore_for_file: avoid_print

import 'dart:developer';

import 'package:demo/features/Hva%20Koster/services/hav_koster_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final userRepositeryProvider = Provider((ref) => HvaController());

class HvaController {
  Future<List<dynamic>> getHvaDetails() async {
    final pref = await SharedPreferences.getInstance();

    // String? zone = pref.getString('zone');
    String? zone = "1";
    final response = await HvaKasterServices().getHavKasterDetails(zone);
    // print(response);
    print(response.runtimeType);
    List firstLevelValues = [];
    if (response != null) {
      firstLevelValues.clear();
      // hvaModel = response;
      // List<String> firstLevelKeys = response.keys.toList();
      firstLevelValues = response.values.toList();

      print('Values: $firstLevelValues');
      // print('key: $firstLevelKeys');

      // Map<String,dynamic>demo=
      // List<String> firstElements =
      //     firstLevelKeys.map((key) => response[key].toString()).toList();
      for (var element in firstLevelValues) {
        final value = element['details']['front_end_text'];
        final split = value.toString().split(' ');
        element['details']['front_end_text'] = split.first;
        log(element['details']['front_end_text'].toString());
        print("===========================================");
      }
      // log(data);
      return firstLevelValues;
    }

    return firstLevelValues;
  }
}

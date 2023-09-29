// ignore_for_file: avoid_print

import 'package:demo/riverpod/services/hav_koster_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/model.dart';

final userRepositeryProvider = Provider((ref) => HvaController());

class HvaController {
  Future<HavKasterModel?> getHvaDetails() async {
    final pref = await SharedPreferences.getInstance();
    late HavKasterModel? response;
    // String? zone = pref.getString('zone');
    String? zone = "1";
    if (zone != null) {
      response = await HvaKasterServices().getHavKasterDetails(zone);
      if (response != null) {
        dynamic value = response.dishWasher.details.frontEndText;
        List split = value.toString().split(' ');
        response.dishWasher.details.frontEndText = split.first;
        value = response.dishWasher.details.frontEndText;

        split = value.toString().split(' ');
        response.dishWasher.details.frontEndText = split.first;
        value = response.dishWasher.details.frontEndText;

        split = value.toString().split(' ');
        response.dishWasher.details.frontEndText = split.first;
        value = response.dishWasher.details.frontEndText;

        split = value.toString().split(' ');
        response.dishWasher.details.frontEndText = split.first;
        value = response.dishWasher.details.frontEndText;

        split = value.toString().split(' ');
        response.dishWasher.details.frontEndText = split.first;
        return response;
      }
      // if (response != null) {
      //   firstLevelValues.clear();
      //   firstLevelValues = response.values.toList();

      //   for (var element in firstLevelValues) {
      //     final value = element['details']['front_end_text'];
      //     final split = value.toString().split(' ');
      //     element['details']['front_end_text'] = split.first;
      //   }
      // }
         return null;
    }
 
  }
}

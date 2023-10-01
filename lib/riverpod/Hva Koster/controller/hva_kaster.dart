// ignore_for_file: avoid_print

import 'package:demo/riverpod/Hva%20Koster/services/hav_koster_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/kva_koster.dart';

final userRepositeryProvider = Provider((ref) => HvaController());

class HvaController {
  Future<HavKasterModel?> getHvaDetails() async {
    final pref = await SharedPreferences.getInstance();
    late HavKasterModel? response;
    // String? zone = pref.getString('zone');
    String? zone = "1";
    response = await HvaKasterServices().getHavKasterDetails(zone);
    if (response != null) {
      //dishWasher
      dynamic dishWasher = response.dishWasher.details.frontEndText;
      List splitdiShWasher = dishWasher.toString().split(' ');
      response.dishWasher.details.frontEndText = splitdiShWasher.first;

//dryer
      dynamic valueDryer = response.dryer.details.frontEndText;

      List splitValueDryer = valueDryer.toString().split(' ');
      response.dryer.details.frontEndText = splitValueDryer.first;

      // ev
      dynamic valueEv = response.ev.details.frontEndText;

      List splitEv = valueEv.toString().split(' ');
      response.ev.details.frontEndText = splitEv.first;
      // shower
      dynamic valueShower = response.shower.details.frontEndText;

      List splitShower = valueShower.toString().split(' ');
      response.shower.details.frontEndText = splitShower.first;
      // washingMachine
      dynamic valueWashingMachine =
          response.washingMachine.details.frontEndText;

      List splitWashingMachine = valueWashingMachine.toString().split(' ');
      response.washingMachine.details.frontEndText = splitWashingMachine.first;
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

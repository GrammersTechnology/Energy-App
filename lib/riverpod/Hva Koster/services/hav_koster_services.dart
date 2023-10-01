import 'dart:developer';

import 'package:demo/const/api_error_helper.dart';
import 'package:dio/dio.dart';

import '../model/kva_koster.dart';

class HvaKasterServices {
  // Future<HavKasterModel?>
  Future<HavKasterModel?> getHavKasterDetails(zone) async {
    // HavKasterModel? data;
    try {
      log('https://predictor-tdg24xwvka-ew.a.run.app/appliances_cost?price_area=NO$zone');
      Response response = await Dio().get(
          'https://predictor-tdg24xwvka-ew.a.run.app/appliances_cost?price_area=NO$zone');
      if (response.statusCode == 200) {
        final result = HavKasterModel.fromJson(response.data);
        log(result.toJson().toString());

        return result;
      }
    } catch (e) {
      ErrorHandlerCode().status401(e);
    }
    return null;
  }
}

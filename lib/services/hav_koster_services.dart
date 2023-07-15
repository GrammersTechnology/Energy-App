import 'dart:developer';

import 'package:demo/const/api_error_helper.dart';
import 'package:demo/controller/home_controller.dart';
import 'package:demo/model/model.dart';
import 'package:dio/dio.dart';

class HvaKasterServices {
  // Future<HavKasterModel?>
  Future<dynamic> getHavKasterDetails(zone) async {
    // HavKasterModel? data;
    try {
      Response response = await Dio().get(
          'https://predictor-tdg24xwvka-ew.a.run.app/appliances_cost?price_area=$zone');
      if (response.statusCode == 200) {
        // data = HavKasterModel.fromJson(response.data);
        final data = response.data;
        log(data.runtimeType.toString());
        HomeController().loader = false;
        HomeController().notifyListeners();
        return data;
      }
    } catch (e) {
      ErrorHandlerCode().status401(e);
      HomeController().loader = false;
      HomeController().notifyListeners();
    }
    return;
  }
}

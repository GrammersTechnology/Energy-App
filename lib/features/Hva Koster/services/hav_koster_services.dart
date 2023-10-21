import 'dart:developer';

import 'package:demo/utils/const/api_error_helper.dart';
import 'package:dio/dio.dart';

class HvaKasterServices {
  // Future<HavKasterModel?>
  getHavKasterDetails(zone) async {
    // HavKasterModel? data;
    try {
      // log('https://predictor-tdg24xwvka-ew.a.run.app/appliances_cost?price_area=NO$zone');
      Response response = await Dio()
          .get('https://api.byge.dev/device-costs/v1?priceArea=NO$zone');
      if (response.statusCode == 200) {
        // log(response.data.runtimeType.toString());

        return response.data;
      }
    } catch (e) {
      ErrorHandlerCode().status401(e);
    }
    return null;
  }
}

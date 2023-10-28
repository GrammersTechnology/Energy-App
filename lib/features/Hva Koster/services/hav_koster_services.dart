import 'package:demo/utils/const/api_error_helper.dart';
import 'package:dio/dio.dart';

import '../../../utils/const/api_urls.dart';

class HvaKasterServices {
  // Future<HavKasterModel?>
  getHavKasterDetails(zone) async {
    // HavKasterModel? data;
    try {
      Response response = await Dio().get(hvKosterUrl + zone);
      if (response.statusCode == 200) {
        return response.data;
      }
    } catch (e) {
      ErrorHandlerCode().status401(e);
      return null;
    }
  }
}

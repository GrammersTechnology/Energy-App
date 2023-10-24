// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:developer';

import 'package:dio/dio.dart';

import '../../../utils/const/api_error_helper.dart';

class HomeScreenServicesScreen {
  Future<List<dynamic>?> dataDetailsApi(zone) async {
    String url = 'https://www.hvakosterstrommen.no/api/v1/prices/';
    final date = DateTime.now();
    final currentDate =
        "${date.year}/${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
    log('${"$url${currentDate}_" + zone}.json');
    try {
      Response response =
          await Dio().get("${"$url${currentDate}_" + zone}.json");
      print(response.data);

      if (response.statusCode == 200) {
        // print(response.statusCode);
        final result = response.data;
        //  List<DataModel>.from(
        //         json.decode(response.data).map((e) => DataModel.fromJson(e)))
        //     .toList();
        // log(homeController.result.toString());
        return result;
      }
    } on DioException catch (e) {
      ErrorHandlerCode().status401(e);
      // print(e);
    }
    return null;
  }

  Future<dynamic> columnGraphDataApi(zone) async {
    String url =
        'https://predictor-tdg24xwvka-ew.a.run.app/predict_spotprice_seven_days?price_area=';

    try {
      Response response = await Dio().get(url + zone);
      if (response.statusCode == 200) {
        final result = response.data;

        return result;
      }
    } on DioException catch (e) {
      ErrorHandlerCode().status401(e);
      log("error" + e.toString());
    }
    return null;
  }
}

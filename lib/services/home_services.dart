// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:developer';

import 'package:demo/controller/home_controller.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';

import '../const/api_error_helper.dart';

class HomeScreenServicesScreen {
  Future<List<dynamic>?> dataDetailsApi(context, zone) async {
    final homeController = Provider.of<HomeController>(context, listen: false);
    homeController.loader = true;
    String url = 'https://www.hvakosterstrommen.no/api/v1/prices/';
    final date = DateTime.now();
    final currentDate =
        "${date.year}/${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
    // log('${"$url${currentDate}_" + zone}.json');
    try {
      Response response = await Dio().get(
          "${"$url${currentDate}_NO" + zone}.json"
          // 'https://www.hvakosterstrommen.no/api/v1/prices/2023/06-12_NO5.json',
          );
      if (response.statusCode == 200) {
        // print(response.data);
        // print(response.statusCode);
        final result = response.data;
        //  List<DataModel>.from(
        //         json.decode(response.data).map((e) => DataModel.fromJson(e)))
        //     .toList();
        // log(homeController.result.toString());
        homeController.loader = false;
        homeController.notifyListeners();
        return result;
      }
    } on DioException catch (e) {
      homeController.loader = false;
      homeController.notifyListeners();
      ErrorHandlerCode().status401(e);
      // print(e);
    }
    return null;
  }

  Future<List<dynamic>?> columnGraphDataApi(context, zone) async {
    final homeController = Provider.of<HomeController>(context, listen: false);
    homeController.loader = true;
    String url =
        'https://predictor-tdg24xwvka-ew.a.run.app/predict_spotprice_seven_days?price_area=NO';

    try {
      Response response = await Dio().get(url + zone);
      if (response.statusCode == 200) {
        final result = response.data;
        homeController.loader = false;

        homeController.notifyListeners();
        return result;
      }
    } on DioException catch (e) {
      homeController.loader = false;
      homeController.notifyListeners();
      ErrorHandlerCode().status401(e);
      log("error" + e.toString());
    }
    return null;
  }
}

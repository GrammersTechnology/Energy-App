// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:developer';

import 'package:demo/features/home/model/home_model.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/const/api_error_helper.dart';
import '../../../utils/const/api_urls.dart';

class HomeScreenServicesScreen {
  Future<List<dynamic>?> stepperGraphDetailsApi(zone) async {
    final date = DateTime.now();
    final currentDate =
        "${date.year}/${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
    log('${"$stepperGraphUrl${currentDate}_" + zone}.json');
    try {
      Response response =
          await Dio().get("${"$stepperGraphUrl${currentDate}_" + zone}.json");
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
    try {
      Response response = await Dio().get(columnGraphUrl + zone);
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

  Future<HomeScrnString?> getHomeString(zone) async {
    try {
      Response response = await Dio().get(homeScrString + zone);
      if (response.statusCode == 200) {
        final result = HomeScrnString.fromJson(response.data);
        return result;
      }
    } catch (e) {
      ErrorHandlerCode().status401(e);
    }
    return null;
  }
}

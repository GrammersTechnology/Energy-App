// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:developer';
import 'package:demo/controller/home_controller.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';

import '../const/api_error_helper.dart';

class HomeScreenServicesScreen {
  dataDetailsApi(context, zone) async {
    final homeController = Provider.of<HomeController>(context, listen: false);
    homeController.loader = true;
    String url = 'https://www.hvakosterstrommen.no/api/v1/prices/';
    final date = DateTime.now();
    final currentDate =
        "${date.year}/${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
    log('${"$url${currentDate}_" + zone}.json');
    try {
      Response response = await Dio().get("${"$url${currentDate}_" + zone}.json"
          // 'https://www.hvakosterstrommen.no/api/v1/prices/2023/06-12_NO5.json',
          );
      if (response.statusCode == 200) {
        // print(response.data);
        // print(response.statusCode);
        homeController.result = response.data;
        //  List<DataModel>.from(
        //         json.decode(response.data).map((e) => DataModel.fromJson(e)))
        //     .toList();
        log(homeController.result.toString());
        homeController.loader = false;
        homeController.notifyListeners();
      }
    } on DioException catch (e) {
      homeController.loader = false;
      homeController.notifyListeners();
      ErrorHandlerCode().status401(e);
      // print(e);
    }
  }
}

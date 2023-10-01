import 'dart:developer';

import 'package:demo/riverpod/profile/controller/profile_controller.dart';
import 'package:demo/riverpod/home/model/home_model.dart';
import 'package:demo/riverpod/home/services/home_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final stepperGraphControllerProvider = Provider((ref) => StepperController());

class StepperController {
  List<GraphData> stepLineGraph = [];
  Future<List<GraphData>> fecthData() async {
    GraphData temp = GraphData(x: 0, y: 0);
    final perf = await SharedPreferences.getInstance();
    // await AuthController().fetchZoneIdFromFirestore();
    // final zone = perf.getString("zone");
    final zone = "1";

    log("--------------------$zone");

    final result = (await HomeScreenServicesScreen().dataDetailsApi(zone))!;

    if (result.isNotEmpty) {
      stepLineGraph.clear();
      for (int i = 0; i < result.length; i++) {
        final starteDate = result[i]['time_start'];
        final endDate = result[i]['time_end'];
        DateTime dateTimeStart = DateTime.parse(starteDate);
        DateTime dateTimeEnd = DateTime.parse(endDate);

        result[i]['time_start'] =
            "${dateTimeStart.day}-${dateTimeStart.month}-${dateTimeStart.year}";
        result[i]['time_end'] =
            "${dateTimeEnd.day}-${dateTimeEnd.month}-${dateTimeEnd.year}";

        temp = GraphData(
            x: dateTimeStart.hour + dateTimeStart.minute + dateTimeStart.second,
            y: result[i]['NOK_per_kWh'] * 1.25);
        stepLineGraph.add(temp);
      }
      if (stepLineGraph.isNotEmpty) {
        for (int i = 0; i < stepLineGraph.length - 1; i++) {
          for (int j = i + 1; j < stepLineGraph.length; j++) {
            if (stepLineGraph[i].x > stepLineGraph[j].x) {
              GraphData temp = stepLineGraph[i];
              stepLineGraph[i] = stepLineGraph[j];
              stepLineGraph[j] = temp;
            }
          }
        }
        stepLineGraph.sort((a, b) {
          int timeA = a.x;
          int timeB = a.x;
          return timeB.compareTo(timeA);
        });
      }
      return stepLineGraph;
    }
    return stepLineGraph;
  }
}

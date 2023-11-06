// ignore_for_file: avoid_print

import 'dart:developer';

import 'package:demo/features/home/controller/home_controller.dart';
import 'package:demo/features/home/model/home_model.dart';
import 'package:demo/features/home/services/home_services.dart';
import 'package:demo/utils/controller/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final stepperGraphControllerProvider = Provider((ref) => StepperController());
final showStepperBarBoolStateProvider = StateProvider<bool>((ref) => false);

class StepperController {
  bool showStepparBool = false;
  List<GraphData> stepLineGraph = [];
  List<GraphData> stepLineNextDayGraph = [];

  changeStepperBarBool() {
    showStepparBool = !showStepparBool;
  }

  Future<List<GraphData>> stepperGrahData() async {
    GraphData temp = GraphData(x: 0, y: 0);
    final perf = await SharedPreferences.getInstance();
    final zone = perf.getString("zone");
    // const zone = "1";
    String? currentDate;
    final date = DateTime.now();

    currentDate =
        "${date.year}/${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
    final result = (await HomeScreenServicesScreen()
        .stepperGraphDetailsApi(zone, currentDate))!;
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

  Future<List<GraphData>> stepperGrahNextDayData() async {
    GraphData temp = GraphData(x: 0, y: 0);
    final perf = await SharedPreferences.getInstance();
    final zone = perf.getString("zone");
    // const zone = "1";
    String? currentDate;
    final date = DateTime.now();
    final nextDay = date.add(const Duration(days: 1));

    print("$nextDay this is the next day ");

    currentDate =
        "${nextDay.year}/${nextDay.month.toString().padLeft(2, '0')}-${nextDay.day.toString().padLeft(2, '0')}";

    final result = (await HomeScreenServicesScreen()
        .stepperGraphDetailsApi(zone, currentDate))!;
    if (result.isNotEmpty) {
      stepLineNextDayGraph.clear();
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
        stepLineNextDayGraph.add(temp);
      }
      if (stepLineNextDayGraph.isNotEmpty) {
        for (int i = 0; i < stepLineNextDayGraph.length - 1; i++) {
          for (int j = i + 1; j < stepLineNextDayGraph.length; j++) {
            if (stepLineNextDayGraph[i].x > stepLineNextDayGraph[j].x) {
              GraphData temp = stepLineNextDayGraph[i];
              stepLineNextDayGraph[i] = stepLineNextDayGraph[j];
              stepLineNextDayGraph[j] = temp;
            }
          }
        }
        stepLineNextDayGraph.sort((a, b) {
          int timeA = a.x;
          int timeB = a.x;
          return timeB.compareTo(timeA);
        });
      }
      return stepLineNextDayGraph;
    }

    return stepLineNextDayGraph;
  }

  Future<HomeScrnString?> homeStringGet() async {
    final perf = await SharedPreferences.getInstance();
    final zone = perf.getString("zone");
    final result = await HomeScreenServicesScreen().getHomeString(zone);
    if (result != null) {
      return result;
    }
    return null;
  }
}

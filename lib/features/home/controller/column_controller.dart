import 'dart:developer';

import 'package:demo/features/home/model/home_model.dart';
import 'package:demo/features/home/services/home_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final columnGraphControllerProvider =
    Provider((ref) => ColumnGraphController());
final showColumnBarBoolStateProvider = StateProvider<bool>((ref) => false);

class ColumnGraphController {
  List result = [];
  bool showColumnBool = false;
  List<GraphData> columnGraphData = [];

  changeColumnBarBool() {
    showColumnBool = !showColumnBool;
  }

  Future<List<GraphData>> feacthColumnGraphData() async {
    // await AuthController().fetchZoneIdFromFirestore();
    // final perf = await SharedPreferences.getInstance();

    // final zone = perf.getString("zone");
    const zone = "1";

    List result =
        await HomeScreenServicesScreen().columnGraphDataApi(zone.toString());
    if (result.isNotEmpty) {
      columnGraphData.clear();
      for (var element in result) {
        final x = element['date'];
        final y = element['day_average_price'];
        // log(y.toString());
        GraphData columnGraphDataelement = GraphData(
            x: x.toString(), y: y, color: Color.fromARGB(255, 212, 211, 211));
        columnGraphData.add(columnGraphDataelement);
        // log(columnGraphData.toString());
      }
      // log(columnGraphData.toString());
      if (columnGraphData.isNotEmpty) {
        final maxValue = columnGraphData
            .reduce((value, element) => value.y > element.y ? value : element)
            .y;
        final minValue = columnGraphData
            .reduce((value, element) => value.y < element.y ? value : element)
            .y;
        for (var element in columnGraphData) {
          if (element.y == maxValue) {
            element.color = Colors.orange;
          } else if (element.y == minValue) {
            element.color = Colors.green;
          }
        }
      }
      for (var element in columnGraphData) {
        // log(element.x.toString() + "__________________");

        log(element.y.toString() + "__________________");
      }
      return columnGraphData;
    } else {
      log("mot available now");
    }
    return columnGraphData;
  }
}

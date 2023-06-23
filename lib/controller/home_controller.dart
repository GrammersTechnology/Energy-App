import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/home_services.dart';

class HomeController extends ChangeNotifier {
  Stream<List<GraphData>> get graphDataStream => _graphDataController.stream;
  final _graphDataController = StreamController<List<GraphData>>();
  List result = [];

  List<GraphData> stepLineGraph = [];
  bool loader = false;
  fecthData(context) async {
    GraphData temp = GraphData(x: 1, y: 5);
    final perf = await SharedPreferences.getInstance();

    final zone = perf.getString("zone");
    log(zone.toString());
    result = (await HomeScreenServicesScreen().dataDetailsApi(context, zone))!;

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

        ///////// data for first graph//////

        temp = GraphData(
            x: dateTimeStart.hour + dateTimeStart.minute + dateTimeStart.second,
            y: result[i]['NOK_per_kWh']);
        stepLineGraph.add(temp);
        // log(stepLineGraph[i].x.toString());
        // log(stepLineGraph[i].x.runtimeType.toString());
        notifyListeners();
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
    }
    _graphDataController.sink.add(stepLineGraph); // Emit the updated graph data

    loader = false;
    notifyListeners();
  }

  @override
  void dispose() {
    _graphDataController.close(); // Close the stream controller
    super.dispose();
  }

  ///////////////////////// Column Graph/////////////////////////////////
  ///

  List<GraphData> columnGraphData = [];
  feacthColumnGraphData(context) async {
    loader = true;
    final perf = await SharedPreferences.getInstance();

    final zone = perf.getString("zone");
    final result =
        (await HomeScreenServicesScreen().columnGraphDataApi(context, zone))!;
    log(result.toString());
    if (result.isNotEmpty) {
      columnGraphData.clear();
      for (var element in result) {
        final x = element['date'];
        print(x.toString());
        final y = element['day_average_price'];
        print(y.toString());
        // log(y.runtimeType.toString());
        GraphData columnGraphDataelement = GraphData(x: x.toString(), y: y);
        columnGraphData.add(columnGraphDataelement);

        notifyListeners();
      }
    }
    loader = false;
  }
}

class GraphData {
  dynamic x;
  dynamic y;
  GraphData({required this.x, required this.y});
}

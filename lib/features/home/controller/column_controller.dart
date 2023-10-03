import 'dart:developer';

import 'package:demo/features/home/model/home_model.dart';
import 'package:demo/features/home/services/home_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final columnGraphControllerProvider =
    Provider((ref) => ColumnGraphController());

class ColumnGraphController {
  List result = [];

  List<GraphData> columnGraphData = [];
  Future<List<GraphData>> feacthColumnGraphData() async {
    // await AuthController().fetchZoneIdFromFirestore();
    final perf = await SharedPreferences.getInstance();

    final zone = perf.getString("zone");
    // const zone = "1";

    List result =
        await HomeScreenServicesScreen().columnGraphDataApi(zone.toString());
    if (result.isNotEmpty) {
      columnGraphData.clear();
      for (var element in result) {
        final x = element['date'];
        final y = element['day_average_price'];
        // log(y.toString());
        GraphData columnGraphDataelement = GraphData(x: x.toString(), y: y);
        columnGraphData.add(columnGraphDataelement);
        // log(columnGraphData.toString());
      }
      // log(columnGraphData.toString());
      return columnGraphData;
    } else {
      log("mot available now");
    }
    return columnGraphData;
  }
}

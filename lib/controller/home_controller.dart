import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/controller/auth_controller.dart';
import 'package:demo/controller/profile_controller.dart';
import 'package:demo/model/model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/home_services.dart';

class HomeController extends ChangeNotifier {
  FirebaseAuth fb = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;

  static StreamController<List<GraphData>> graphDataStream =
      StreamController<List<GraphData>>();
  List result = [];

  List<GraphData> stepLineGraph = [];
  bool loader = false;
  fecthData(context) async {
    loader = true;
    GraphData temp = GraphData(x: 1, y: 5);
    final perf = await SharedPreferences.getInstance();
    await AuthController().fetchZoneIdFromFirestore();
    final zone = perf.getString("zone");
    log("--------------------$zone");

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
        print(result[i]['NOK_per_kWh']);
        temp = GraphData(
            x: dateTimeStart.hour + dateTimeStart.minute + dateTimeStart.second,
            y: result[i]['NOK_per_kWh'] * 1.25);
        stepLineGraph.add(temp);
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
    savingTips.first.savingstips;
    graphDataStream.sink.add(stepLineGraph); // Emit the updated graph data
    loader = false;
    notifyListeners();
  }

  // dispose() {
  //   graphDataStream.close(); // Close the stream controller
  //   super.dispose();
  // }

  ///////////////////////// Column Graph/////////////////////////////////
  ///

  List<GraphData> columnGraphData = [];
  feacthColumnGraphData(context) async {
    loader = true;
    await AuthController().fetchZoneIdFromFirestore();
    final perf = await SharedPreferences.getInstance();

    final zone = perf.getString("zone");
    final result = await HomeScreenServicesScreen()
        .columnGraphDataApi(context, zone.toString());
    // log(result.toString());
    if (result!.isNotEmpty) {
      columnGraphData.clear();
      for (var element in result) {
        final x = element['date'];
        final y = element['day_average_price'];
        // log(y.runtimeType.toString());
        GraphData columnGraphDataelement = GraphData(x: x.toString(), y: y);
        columnGraphData.add(columnGraphDataelement);

        notifyListeners();
      }
    }
    loader = false;
  }

  getTips(context) async {
    final controller = Provider.of<ProfileController>(context, listen: false);
    await db.collection("savings_tips").get().then((value) {
      final data = value.docs;
      List<SavingTips> tempData = [];
      notifyListeners();
      if (data.isNotEmpty) {
        for (var element in data) {
          final singleData = SavingTips(
              readmoretxt: element.data()['ReadMoreTxt'],
              savingstips: element.data()['SavingsTips'],
              allItems: element.data()['All'],
              elCars: element.data()['ElCar'],
              heatPumps: element.data()['HeatPump'],
              solarPanels: element.data()['SolarPanels'],
              dateTIme: element.data()['TimeDate']);
          notifyListeners();
          tempData.add(singleData);
          notifyListeners();

          Future.delayed(const Duration(seconds: 5)).then((value) {
            notifyListeners();
          });
        }
      }
      // log(tempData.elementAt(0).savingstips.toString());
      savingTips.clear();

      if (tempData.isNotEmpty) {
        if (controller.hasElCarBool &&
            controller.hasEatPumpBool &&
            controller.hasSolarPanelBool) {
          for (var element in tempData) {
            if (element.allItems == true) {
              log(savingTips.toString());

              savingTips.add(element);
            }
          }
          // } else if (controller.hasElCarBool && controller.hasEatPumpBool) {
          //   savingTips.clear();
          //   for (var element in tempData) {
          //     if (element.HeatPump && element.ElCar == true) {
          //       savingTips.add(element);
          //       log(savingTips.first.savingstips.toString());
          //     }
          //   }
          // } else if (controller.hasEatPumpBool && controller.hasSolarPanelBool) {
          //   savingTips.clear();
          //   for (var element in tempData) {
          //     if (element.HeatPump && element.SolarPanels == true) {
          //       savingTips.add(element);
          //       log(savingTips.first.savingstips.toString());
          //     }
          //   }
          //   // for (var element in data.docs) {}
          // } else if (controller.hasElCarBool && controller.hasSolarPanelBool) {
          //   savingTips.clear();
          //   for (var element in tempData) {
          //     if (element.ElCar && element.SolarPanels == true) {
          //       savingTips.add(element);
          //       log(savingTips.first.savingstips.toString());
          //     }
          //   }
          // for (var element in data.docs) {}
        } else if (controller.hasElCarBool) {
          for (var element in tempData) {
            if (element.elCars == true) {
              savingTips.add(element);
              log(savingTips.first.savingstips.toString());
            }
          }
          // for (var element in data.docs) {}
        } else if (controller.hasEatPumpBool) {
          for (var element in tempData) {
            if (element.heatPumps == true) {
              savingTips.add(element);
              log(savingTips.first.savingstips.toString());
            }
          }
          // for (var element in data.docs) {}
        } else if (controller.hasSolarPanelBool) {
          for (var element in tempData) {
            if (element.solarPanels == true) {
              savingTips.add(element);
              log(savingTips.first.savingstips.toString());
            }
          }
        }
      } else {
        savingTips.clear();
      }
      log(savingTips.length.toString());

      //sorting//
      if (savingTips.length > 1) {
        for (var element in savingTips) {
          DateTime date = DateTime.parse(element.dateTIme.toString());
          log(date.runtimeType.toString());
        }
        savingTips.sort((a, b) => a.dateTIme.toString().compareTo(b.dateTIme));
      }
      notifyListeners();
    }).catchError((error) {});
  }
}

class GraphData {
  dynamic x;
  dynamic y;
  GraphData({required this.x, required this.y});
}

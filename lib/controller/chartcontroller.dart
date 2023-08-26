import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/chart_services.dart';

class ChartController extends ChangeNotifier {
  String? dropdowmValue;
  ChartDataModel? data;
  bool loader = false;
  List dropdwonList = ["NO1", "NO2", "NO3", "NO4", "NO5"];
  List result = [];
  changeDropDownValue(value) {
    dropdowmValue = value;
    notifyListeners();
    setChartData(result);
  }

  getChartDetails(context) async {
    loader = true;
    result = (await ChartService().chartGraphDataApi(context))!;
    if (result.isNotEmpty) {
      setChartData(result);
    }
    loader = false;
  }

  setChartData(List result) async {
    loader = true;
    if (dropdowmValue != null) {
      final response =
          dropdowmValue.toString().substring(dropdowmValue!.length - 1);
      for (var element in result) {
        if (element['omrType'].toString() == 'EL') {
          if (element['omrnr'].toString() == response) {
            // log("omnr ${element['omrnr'].toString()}");
            // log(element['fyllingsgrad'].toString());
            // log(element['kapasitet_TWh'].toString());
            // log(element['fylling_TWh'].toString());
            // log(element['fyllingsgrad_forrige_uke'].toString());
            // log(element['endring_fyllingsgrad'].toString());
            data = ChartDataModel(
                omrnr: element['omrnr'],
                isoAar: element["iso_aar"],
                isoUke: element['iso_uke'],
                fyllingsgrad: element['fyllingsgrad'] * 100,
                kapasitetTWh: element['kapasitet_TWh'],
                fyllingTWh: element['fylling_TWh'],
                fyllingsgradForrigeUke: element['fyllingsgrad_forrige_uke'],
                endringFyllingsgrad: element['endring_fyllingsgrad']);
          }
        }
      }
    } else {
      final perf = await SharedPreferences.getInstance();

      final zone = perf.getString("zone");

      final response = zone.toString().substring(zone!.length - 1);
      log(response.toString());
      for (var element in result) {
        if (element['omrType'].toString() == 'EL') {
          if (element['omrnr'].toString() == response) {
            // log("omnr ${element['omrnr'].toString()}");
            // log(element['fyllingsgrad'].toString());
            // log(element['kapasitet_TWh'].toString());
            // log(element['fylling_TWh'].toString());
            // log(element['fyllingsgrad_forrige_uke'].toString());
            // log(element['endring_fyllingsgrad'].toString());
            data = ChartDataModel(
                omrnr: element['omrnr'],
                isoAar: element["iso_aar"],
                isoUke: element['iso_uke'],
                fyllingsgrad: element['fyllingsgrad'],
                kapasitetTWh: element['kapasitet_TWh'],
                fyllingTWh: element['fylling_TWh'],
                fyllingsgradForrigeUke:
                    element['fyllingsgrad_forrige_uke'] * 100,
                endringFyllingsgrad: element['endring_fyllingsgrad'] * 100);
          }
        }
      }
    }
    loader = false;
    notifyListeners();
  }
}

class ChartDataModel {
  DateTime? datoId;
  String? omrType;
  int? omrnr;
  int? isoAar;
  int? isoUke;
  double fyllingsgrad;
  double kapasitetTWh;
  double fyllingTWh;
  DateTime? nestePubliseringsdato;
  double fyllingsgradForrigeUke;
  double endringFyllingsgrad;

  ChartDataModel({
    this.datoId,
    this.omrType,
    this.omrnr,
    this.isoAar,
    this.isoUke,
    required this.fyllingsgrad,
    required this.kapasitetTWh,
    required this.fyllingTWh,
    this.nestePubliseringsdato,
    required this.fyllingsgradForrigeUke,
    required this.endringFyllingsgrad,
  });
}

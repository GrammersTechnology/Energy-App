import 'dart:convert';
import 'dart:developer';

import 'package:demo/riverpod/chart/services/chart_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final userChartProvider = Provider((ref) => ChartController());

final chartDropdownListProvider = StateProvider<String>((ref) {
  return 'Select From List';
});

class ChartController {
  String? dropdowmValue;
  ChartDataModel? data;
  bool loader = false;
  List dropdwonList = ["NO1", "NO2", "NO3", "NO4", "NO5"];
  List result = [];
  changeDropDownValue(value) {
    dropdowmValue = value;
    setChartData(result);
  }

  Future<ChartDataModel> getChartDetails() async {
    loader = true;
    result = (await ChartService().chartGraphDataApi())!;
    final data = json.encode(result);
    if (data.isEmpty) {
      log('this is empty');
    } else {
      log('not empty');
    }
    if (data.isNotEmpty) {
      final chartData = setChartData(result);

      log('$chartData----------chart Data-----------');
      return chartData;
    }
    loader = false;

    return ChartDataModel(
        fyllingsgrad: 0,
        kapasitetTWh: 0,
        fyllingTWh: 0,
        fyllingsgradForrigeUke: 0,
        endringFyllingsgrad: 0);
  }

  Future<ChartDataModel> setChartData(List result) async {
    loader = true;
    if (dropdowmValue != null) {
      final response =
          dropdowmValue.toString().substring(dropdowmValue!.length - 1);
      for (var element in result) {
        if (element['omrType'].toString() == 'EL') {
          if (element['omrnr'].toString() == response) {
            data = ChartDataModel(
                omrnr: element['omrnr'],
                isoAar: element["iso_aar"],
                isoUke: element['iso_uke'],
                fyllingsgrad: element['fyllingsgrad'] * 100,
                kapasitetTWh: element['kapasitet_TWh'],
                fyllingTWh: element['fylling_TWh'],
                fyllingsgradForrigeUke: element['fyllingsgrad_forrige_uke'],
                endringFyllingsgrad: element['endring_fyllingsgrad']);
            return data!;
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
            return data!;
          }
        }
      }
    }
    loader = false;

    return ChartDataModel(
        fyllingsgrad: 0,
        kapasitetTWh: 0,
        fyllingTWh: 0,
        fyllingsgradForrigeUke: 0,
        endringFyllingsgrad: 0);
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

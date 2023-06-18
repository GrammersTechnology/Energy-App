import 'dart:convert';

class DataModel {
  double? nokPerKWh;
  double? eurPerKWh;
  double? exr;
  String? timeStart;
  String? timeEnd;

  DataModel({
    this.nokPerKWh,
    this.eurPerKWh,
    this.exr,
    this.timeStart,
    this.timeEnd,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
        nokPerKWh: json["NOK_per_kWh"],
        eurPerKWh: json["EUR_per_kWh"],
        exr: json["EXR"],
        timeStart: json["time_start"].toString(),
        timeEnd: json["time_end"].toString(),
      );

  // Map<String, dynamic> toJson() => {
  //       "NOK_per_kWh": nokPerKWh,
  //       "EUR_per_kWh": eurPerKWh,
  //       "EXR": exr,
  //       "time_start": timeStart,
  //       "time_end": timeEnd,
  //     };
}

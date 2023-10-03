// To parse this JSON data, do
//
//     final chartModel = chartModelFromJson(jsonString);

import 'dart:convert';

List<ChartModel> chartModelFromJson(String str) =>
    List<ChartModel>.from(json.decode(str).map((x) => ChartModel.fromJson(x)));

String chartModelToJson(List<ChartModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ChartModel {
  DateTime? datoId;
  String? omrType;
  int? omrnr;
  int? isoAar;
  int? isoUke;
  double? fyllingsgrad;
  double? kapasitetTWh;
  double? fyllingTWh;
  DateTime? nestePubliseringsdato;
  double? fyllingsgradForrigeUke;
  double? endringFyllingsgrad;

  ChartModel({
    this.datoId,
    this.omrType,
    this.omrnr,
    this.isoAar,
    this.isoUke,
    this.fyllingsgrad,
    this.kapasitetTWh,
    this.fyllingTWh,
    this.nestePubliseringsdato,
    this.fyllingsgradForrigeUke,
    this.endringFyllingsgrad,
  });

  factory ChartModel.fromJson(Map<String, dynamic> json) => ChartModel(
        datoId:
            json["dato_Id"] == null ? null : DateTime.parse(json["dato_Id"]),
        omrType: json["omrType"],
        omrnr: json["omrnr"],
        isoAar: json["iso_aar"],
        isoUke: json["iso_uke"],
        fyllingsgrad: json["fyllingsgrad"]?.toDouble(),
        kapasitetTWh: json["kapasitet_TWh"]?.toDouble(),
        fyllingTWh: json["fylling_TWh"]?.toDouble(),
        nestePubliseringsdato: json["neste_Publiseringsdato"] == null
            ? null
            : DateTime.parse(json["neste_Publiseringsdato"]),
        fyllingsgradForrigeUke: json["fyllingsgrad_forrige_uke"]?.toDouble(),
        endringFyllingsgrad: json["endring_fyllingsgrad"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "dato_Id":
            "${datoId!.year.toString().padLeft(4, '0')}-${datoId!.month.toString().padLeft(2, '0')}-${datoId!.day.toString().padLeft(2, '0')}",
        "omrType": omrType,
        "omrnr": omrnr,
        "iso_aar": isoAar,
        "iso_uke": isoUke,
        "fyllingsgrad": fyllingsgrad,
        "kapasitet_TWh": kapasitetTWh,
        "fylling_TWh": fyllingTWh,
        "neste_Publiseringsdato": nestePubliseringsdato?.toIso8601String(),
        "fyllingsgrad_forrige_uke": fyllingsgradForrigeUke,
        "endring_fyllingsgrad": endringFyllingsgrad,
      };
}

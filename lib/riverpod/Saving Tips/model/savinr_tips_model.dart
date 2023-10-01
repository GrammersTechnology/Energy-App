class SavingTips {
  String readmoretxt;
  String savingstips;
  bool allItems;
  bool elCars;
  bool heatPumps;
  bool solarPanels;
  dynamic dateTIme;

  SavingTips(
      {required this.readmoretxt,
      required this.savingstips,
      required this.allItems,
      required this.elCars,
      required this.heatPumps,
      required this.solarPanels,
      required this.dateTIme});
  factory SavingTips.fromJson(Map<String, dynamic> json) => SavingTips(
      readmoretxt: json["ReadMoreTxt"],
      savingstips: json["SavingsTips"],
      allItems: json['All'],
      elCars: json['ElCar'],
      heatPumps: json['HeatPump'],
      solarPanels: json['SolarPanels'],
      dateTIme: json['TimeDate']);
}

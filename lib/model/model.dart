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

//profile model ///

class ProfileModel {
  String name;
  String email;
  String powerCompany, pricezone;
  String yearlyCosumption, numberOfPepole, powerPoint, powerCoins;
  bool hasSensor,
      hasElCar,
      hasEatPump,
      hasSolarPanel,
      wantPushWarning1,
      wantPushWarning2,
      all;

  ProfileModel({
    required this.email,
    required this.name,
    required this.powerCompany,
    required this.pricezone,
    required this.yearlyCosumption,
    required this.numberOfPepole,
    required this.powerCoins,
    required this.powerPoint,
    required this.hasSensor,
    required this.hasElCar,
    required this.hasEatPump,
    required this.hasSolarPanel,
    required this.wantPushWarning1,
    required this.wantPushWarning2,
    required this.all,
  });
  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
      email: json["email"],
      name: json["name"],
      powerCompany: json['powerCompany'],
      pricezone: json["pricezone"],
      yearlyCosumption: json["yearlyCosumption"],
      numberOfPepole: json["numberOfPepole"],
      powerCoins: json["powerCoins"],
      powerPoint: json["powerPoint"],
      hasSensor: json['hasSensor'],
      hasElCar: json['hasElCar'],
      all: json['all'],
      hasEatPump: json['hasEatPump'],
      hasSolarPanel: json['hasSolarPanel'],
      wantPushWarning1: json['wantPushWarning1'],
      wantPushWarning2: json['wantPushWarning2']);
  Map<String, dynamic> toJson() => {
        "email": email,
        "name": name,
        "powerCompany": powerCompany,
        "pricezone": pricezone,
        "yearlyCosumption": yearlyCosumption,
        "numberOfPepole": numberOfPepole,
        "powerCoins": powerCoins,
        "powerPoint": powerPoint,
        "hasSensor": hasSensor,
        "hasElCar": hasElCar,
        "hasEatPump": hasEatPump,
        "hasSolarPanel": hasSolarPanel,
        "wantPushWarning1": wantPushWarning1,
        "wantPushWarning2": wantPushWarning2,
        'all': all
      };
}

class SavingTips {
  String readmoretxt;
  String savingstips;
  bool All;
  bool ElCar;
  bool HeatPump;
  bool SolarPanels;
  dynamic dateTIme;

  SavingTips(
      {required this.readmoretxt,
      required this.savingstips,
      required this.All,
      required this.ElCar,
      required this.HeatPump,
      required this.SolarPanels,
      required this.dateTIme});
  factory SavingTips.fromJson(Map<String, dynamic> Json) => SavingTips(
      readmoretxt: Json["ReadMoreTxt"],
      savingstips: Json["SavingsTips"],
      All: Json['All'],
      ElCar: Json['ElCar'],
      HeatPump: Json['HeatPump'],
      SolarPanels: Json['SolarPanels'],
      dateTIme: Json['TimeDate']);
}

class HavKasterModel {
  HavKasterItem dishWasher;
  HavKasterItem dryer;
  HavKasterItem shower;
  HavKasterItem washingMachine;
  HavKasterItem ev;

  HavKasterModel({
    required this.dishWasher,
    required this.dryer,
    required this.shower,
    required this.washingMachine,
    required this.ev,
  });

  factory HavKasterModel.fromJson(Map<String, dynamic> json) => HavKasterModel(
        dishWasher: HavKasterItem.fromJson(json["dish_washer"]),
        dryer: HavKasterItem.fromJson(json["dryer"]),
        shower: HavKasterItem.fromJson(json["shower"]),
        washingMachine: HavKasterItem.fromJson(json["washing_machine"]),
        ev: HavKasterItem.fromJson(json["ev"]),
      );

  Map<String, dynamic> toJson() => {
        "dish_washer": dishWasher.toJson(),
        "dryer": dryer.toJson(),
        "shower": shower.toJson(),
        "washing_machine": washingMachine.toJson(),
        "ev": ev.toJson(),
      };
}

class HavKasterItem {
  Details details;
  Cost cost;

  HavKasterItem({
    required this.details,
    required this.cost,
  });

  factory HavKasterItem.fromJson(Map<String, dynamic> json) => HavKasterItem(
        details: Details.fromJson(json["details"]),
        cost: Cost.fromJson(json["cost"]),
      );

  Map<String, dynamic> toJson() => {
        "details": details.toJson(),
        "cost": cost.toJson(),
      };
}

class Cost {
  CostItem cheapest;
  CostItem current;
  CostItem mostExpensive;

  Cost({
    required this.cheapest,
    required this.current,
    required this.mostExpensive,
  });

  factory Cost.fromJson(Map<String, dynamic> json) => Cost(
        cheapest: CostItem.fromJson(json["cheapest"]),
        current: CostItem.fromJson(json["current"]),
        mostExpensive: CostItem.fromJson(json["most_expensive"]),
      );

  Map<String, dynamic> toJson() => {
        "cheapest": cheapest.toJson(),
        "current": current.toJson(),
        "most_expensive": mostExpensive.toJson(),
      };
}

class CostItem {
  double cost;
  String startTime;
  String endTime;
  String startHour;
  String endHour;

  CostItem({
    required this.cost,
    required this.startTime,
    required this.endTime,
    required this.startHour,
    required this.endHour,
  });

  factory CostItem.fromJson(Map<String, dynamic> json) => CostItem(
        cost: json["cost"].toDouble(),
        startTime: json["start_time"],
        endTime: json["end_time"],
        startHour: json["start_hour"],
        endHour: json["end_hour"],
      );

  Map<String, dynamic> toJson() => {
        "cost": cost,
        "start_time": startTime,
        "end_time": endTime,
        "start_hour": startHour,
        "end_hour": endHour,
      };
}

class Details {
  String frontEndText;
  String icon;
  int type;

  Details({
    required this.frontEndText,
    required this.icon,
    required this.type,
  });

  factory Details.fromJson(Map<String, dynamic> json) => Details(
        frontEndText: json["front_end_text"],
        icon: json["icon"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "front_end_text": frontEndText,
        "icon": icon,
        "type": type,
      };
}

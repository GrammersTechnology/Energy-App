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
      wantPushWarning2;

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
        "wantPushWarning2": wantPushWarning2
      };
}

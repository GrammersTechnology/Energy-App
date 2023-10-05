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
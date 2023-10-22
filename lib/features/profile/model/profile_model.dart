class ProfileModel {
  String email;
  String powerCompany, pricezone, count, storreise;
  bool hasSensor,
      hasElCar,
      hasEatPump,
      hasSolarPanel,
      wantPushWarning,
      all,
      oppvaskmaskin,
      torketrommel,
      vaskemaskin;

  ProfileModel(
      {required this.email,
      required this.count,
      required this.storreise,
      required this.powerCompany,
      required this.pricezone,
      required this.hasSensor,
      required this.hasElCar,
      required this.hasEatPump,
      required this.hasSolarPanel,
      required this.wantPushWarning,
      required this.all,
      required this.oppvaskmaskin,
      required this.torketrommel,
      required this.vaskemaskin});
  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
      email: json["email"],
      count: json['count'],
      storreise: json['storreise'],
      powerCompany: json['powerCompany'],
      pricezone: json["pricezone"],
      hasSensor: json['hasSensor'],
      hasElCar: json['hasElCar'],
      all: json['all'],
      hasEatPump: json['hasEatPump'],
      hasSolarPanel: json['hasSolarPanel'],
      wantPushWarning: json['wantPushWarning'],
      oppvaskmaskin: json['oppvaskmaskin'],
      torketrommel: json['torketrommel'],
      vaskemaskin: json['vaskemaskin']);
  Map<String, dynamic> toJson() => {
        "email": email,
        "storreise": storreise,
        "count": count,
        "powerCompany": powerCompany,
        "pricezone": pricezone,
        "hasSensor": hasSensor,
        "hasElCar": hasElCar,
        "hasEatPump": hasEatPump,
        "hasSolarPanel": hasSolarPanel,
        "wantPushWarning": wantPushWarning,
        'all': all
      };
}

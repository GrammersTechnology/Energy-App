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

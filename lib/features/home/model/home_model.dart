import 'package:flutter/material.dart';

class ColumnGraphData {
  DateTime date;
  double dayAveragePrice;
  int type;

  ColumnGraphData({
    required this.date,
    required this.dayAveragePrice,
    required this.type,
  });

  factory ColumnGraphData.fromJson(Map<String, dynamic> json) =>
      ColumnGraphData(
        date: DateTime.parse(json["date"]),
        dayAveragePrice: json["day_average_price"].toDouble(),
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "day_average_price": dayAveragePrice,
        "type": type,
      };
}

class GraphData {
  dynamic x;
  dynamic y;
  Color? color;
  GraphData({required this.x, required this.y, this.color});
}

class HomeScrnString {
  double price;
  int priceLevel;
  int priceVariation;

  HomeScrnString({
    required this.price,
    required this.priceLevel,
    required this.priceVariation,
  });

  factory HomeScrnString.fromJson(Map<String, dynamic> json) => HomeScrnString(
        price: json["price"].toDouble(),
        priceLevel: json["price_level"],
        priceVariation: json["price_variation"],
      );

  Map<String, dynamic> toJson() => {
        "price": price,
        "price_level": priceLevel,
        "price_variation": priceVariation,
      };
}

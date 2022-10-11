import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:restaurant_app/model/restaurant.dart';

import 'menus.dart';

Data restaurantFromJson(String str) => Data.fromJson(json.decode(str));
String restaurantToJson(Data data) => json.encode(data.toJson());
class Data {
  final List<Restaurants> restaurants;


  Data({required this.restaurants});

  factory Data.fromJson(Map<String, dynamic>json) =>
      Data(
        restaurants: List<Restaurants>.from(json['restaurants'].map((x) => Restaurants.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
  };
}



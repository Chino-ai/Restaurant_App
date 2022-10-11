import 'package:restaurant_app/model/foods.dart';

import 'drinks.dart';

class Menus {
  final List<Foods> foods;
  final List<Drinks> drinks;

  Menus({required this.foods, required this.drinks});

  factory Menus.fromJson(Map<String, dynamic> json) => Menus(
        foods: List<Foods>.from(json['foods'].map((foods){
          return Foods.fromJson(foods);
        })),
        drinks: List<Drinks>.from(json['drinks'].map((drinks){
          return Drinks.fromJson(drinks);
        })),
      );

  Map<String, dynamic> toJson() => {
    "foods": List<dynamic>.from(foods.map((x) => x.toJson())),
    "drinks": List<dynamic>.from(drinks.map((x) => x.toJson())),
  };
}

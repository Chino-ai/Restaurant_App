

import 'package:restaurant_app/data/model/restaurant.dart';

class SearchRestaurant {
  SearchRestaurant({
    required this.error,
    required this.founded,
    required this.restaurants,
  });

  bool error;
  int founded;
  List<Restaurant> restaurants;

  factory SearchRestaurant.fromJson(Map<String, dynamic> json) => SearchRestaurant(
    error: json["error"],
    founded: json["founded"],
    restaurants: List<Restaurant>.from(json["restaurants"].map((x) => Restaurant.fromJson(x))),
  );


}





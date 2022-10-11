import 'dart:convert';

import 'data.dart';
import 'menus.dart';

class Restaurants{
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final double rating;
  final Menus menus;


  Restaurants({required this.id, required this.name, required this.description, required this.pictureId, required this.city, required this.rating, required this.menus});

  factory Restaurants.fromJson(Map<String, dynamic> json) => Restaurants(
    id: json['id'],
    name: json['name'],
    description: json['description'],
    pictureId: json['pictureId'],
    city: json['city'],
    rating: json['rating'].toDouble(),
      menus: Menus.fromJson(json['menus'])
  );
  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "pictureId": pictureId,
    "city": city,
    "rating": rating,
    "menus": menus.toJson(),
  };

}

List<Restaurants> parseResto(String json) {
  final List parsed = jsonDecode(json);
  return parsed.map((json) => Restaurants.fromJson(json)).toList();
}
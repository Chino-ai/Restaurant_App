

class Restaurant {
  Restaurant({
    required this.error,
    required this.message,
    required this.count,
    required this.restaurants,
  });

  bool error;
  String message;
  int count;
  List<GRestaurant> restaurants;

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
    error: json["error"],
    message: json["message"],
    count: json["count"],
    restaurants: List<GRestaurant>.from(json["restaurants"].map((x) => GRestaurant.fromJson(x))),
  );

  Map<String,dynamic> toJson() =>{
    "error": error,
    "message": message,
    "count" : count,
    "restaurants": List<dynamic>.from(restaurants.map((x) => toJson()))
  };


}

class GRestaurant {
  GRestaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
  });

  String id;
  String name;
  String description;
  String pictureId;
  String city;
  String rating;

  factory GRestaurant.fromJson(Map<String, dynamic> json) => GRestaurant(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    pictureId: json["pictureId"],
    city: json["city"],
    rating:json["rating"].toString() ,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "pictureId": pictureId,
    "city": city,
    "rating": rating.toString(),

  };


}

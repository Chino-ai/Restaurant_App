class SearchRestaurant {
  SearchRestaurant({
    required this.error,
    required this.founded,
    required this.restaurants,
  });

  bool error;
  int founded;
  List<SRestaurant> restaurants;

  factory SearchRestaurant.fromJson(Map<String, dynamic> json) => SearchRestaurant(
    error: json["error"],
    founded: json["founded"],
    restaurants: List<SRestaurant>.from(json["restaurants"].map((x) => SRestaurant.fromJson(x))),
  );


}

class SRestaurant {
  SRestaurant({
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
  double rating;

  factory SRestaurant.fromJson(Map<String, dynamic> json) => SRestaurant(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    pictureId: json["pictureId"],
    city: json["city"],
    rating: json["rating"].toDouble(),
  );


}

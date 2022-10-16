import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/data/model/get_restaurants.dart';
void main() {
   const String _baseUrl = 'https://restaurant-api.dicoding.dev';
  test('should contain new item when module completed', () async {
    // arrange
    var response = await http.get(Uri.parse("$_baseUrl/list"));
    var testResponse = response.body;

    // act
    var testRestaurant = GetRestaurant.fromJson(jsonDecode(testResponse));
    // assert
    var result = testRestaurant;
    expect(result, testRestaurant);
  });
}
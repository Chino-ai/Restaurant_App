import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/data/model/get_restaurants.dart';

import 'json_reader.dart';
void main() {
  test('should contain new item when module completed', () async {
    // arrange
    // act
    var testRestaurant = GetRestaurant.fromJson(jsonDecode(readJson('restaurant.json')));
    // assert
    var result = testRestaurant;
    expect(result, testRestaurant);
  });
}
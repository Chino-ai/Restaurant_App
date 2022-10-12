import 'dart:convert';

import 'package:restaurant_app/data/model/detail_restaurants.dart';
import 'package:restaurant_app/data/model/get_restaurants.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/data/model/search_restaurants.dart';
class ApiService{
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev';


  Future<GetRestaurant> GetListResto() async {
    final response = await http.get(Uri.parse("$_baseUrl/list"));
    if (response.statusCode == 200) {
      return GetRestaurant.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load List Resto');
    }
  }

  Future<DetailRestaurant> GetDetailResto(String id) async {
    final response = await http.get(Uri.parse("$_baseUrl/detail/$id"));
    if (response.statusCode == 200) {
      return DetailRestaurant.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Detail Resto');
    }
  }

  Future<SearchRestaurant> GetSearchResto(String query) async {
    final response = await http.get(Uri.parse("$_baseUrl/search?q=$query"));
    if (response.statusCode == 200) {
      return SearchRestaurant.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Search Resto');
    }
  }
}



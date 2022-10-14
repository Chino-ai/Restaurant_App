import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/data/model/search_restaurants.dart';
import '../../utils/result_state.dart';
import '../api/api_service.dart';

class SearchProvider extends ChangeNotifier{
  final ApiService apiService;
  SearchProvider({required this.apiService});

  SearchRestaurant? _getRestaurant;
  ResultState? _state;
  String _message = '';

  String get message => _message;

  SearchRestaurant? get result => _getRestaurant;

  ResultState? get state => _state;

  Future<dynamic> fetchAllArticle(String query) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await apiService.GetSearchResto(query);
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _getRestaurant = restaurant;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
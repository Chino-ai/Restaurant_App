import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/data/model/get_restaurants.dart';
import '../../utils/result_state.dart';
import '../api/api_service.dart';




class ListProvider extends ChangeNotifier{
  final ApiService apiService;

  ListProvider({required this.apiService}){
    _fetchAllArticle();
  }

  late GetRestaurant _getRestaurant;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  GetRestaurant get result => _getRestaurant;

  ResultState get state => _state;

  Future<dynamic> _fetchAllArticle() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await apiService.GetListResto();
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
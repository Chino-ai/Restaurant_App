import 'package:flutter/cupertino.dart';
import '../../utils/result_state.dart';
import '../api/api_service.dart';
import '../model/detail_restaurants.dart';
class DetailProvider extends ChangeNotifier{
  final ApiService apiService;
  final String id;

  DetailProvider({required this.apiService, required this.id}){
    _fetchAllArticle(id);
  }

  late DetailRestaurant _detailRestaurant;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  DetailRestaurant get result => _detailRestaurant;

  ResultState get state => _state;

  Future<dynamic> _fetchAllArticle(String id) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await apiService.GetDetailResto(id);
      if (restaurant.restaurant.id.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _detailRestaurant = restaurant;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
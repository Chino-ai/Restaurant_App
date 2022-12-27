import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/data/model/restaurant.dart';

import '../../utils/result_state.dart';
import '../db/database_helper.dart';


class DatabaseProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  DatabaseProvider({required this.databaseHelper}){
    _getFavourite();
  }

  ResultState? _state;
  ResultState? get state => _state;

  String _message = '';
  String get message => _message;

  List<Restaurant> _favourites = [];
  List<Restaurant> get favourites => _favourites;

  void _getFavourite() async {
    _favourites = await databaseHelper.getResto();
    if (_favourites.length > 0) {
      _state = ResultState.hasData;
    } else {
      _state = ResultState.noData;
      _message = 'Empty Data';
    }
    notifyListeners();
  }

  void addFavourite(Restaurant restaurant) async {
    try {
      await databaseHelper.insertResto(restaurant);
      _getFavourite();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }

  Future<bool> isFavourite(String id) async {
    final bookmarkedArticle = await databaseHelper.getFavouriteById(id);
    return bookmarkedArticle.isNotEmpty;
  }

  void removeFavourite(String id) async {
    try {
      await databaseHelper.removeFavourite(id);
      _getFavourite();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }
}
import 'package:flutter/cupertino.dart';
import 'package:ykos_bbq_chicken/Service/fire_firestore.dart';
import 'package:ykos_bbq_chicken/model/food.dart';

class ViewmodelFire extends ChangeNotifier {
  final firestore = FireFirestore();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;


 void toggleFavorite(Food item) {
    item.isFavorited = !item.isFavorited;
    notifyListeners();

    if (item.isFavorited) {
      addFavorite(item);
      notifyListeners();
    } else {
      removeFromFavorite(item);
      notifyListeners();
    }
  }

  //Add Favorite Item
  Future<void> addFavorite(Food item) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      await firestore.addFavorite(item);
      // notifyListeners();
    } catch (e) {
      _error = e.toString();
      // notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  //Remove Favorite Item
  Future<void> removeFromFavorite(Food item) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      await firestore.removeFromFavorite(item);
      // notifyListeners();
    } catch (e) {
      _error = e.toString();
      // notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  List<Food> _favoriteList = [];
  List<Food> get favoriteList => _favoriteList;

    //fetch Favorites
  Future<void> fetchFavorites() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      final list = await firestore.fetchFavorites();
      _favoriteList = list;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

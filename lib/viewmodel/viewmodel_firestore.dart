import 'package:flutter/cupertino.dart';
import 'package:ykos_bbq_chicken/Error/app_error_handler.dart';
import 'package:ykos_bbq_chicken/Service/fire_firestore.dart';
import 'package:ykos_bbq_chicken/model/food.dart';

class ViewmodelFirestore extends ChangeNotifier {
  final firestore = FireFirestore();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

   void clearError() {
  _error = null;
  notifyListeners();
}

  Future<void> toggleFavorite(Food item) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final isCurrentlyFavorited = _favoriteList.any((f) => f.id == item.id);

      if (isCurrentlyFavorited) {
        await firestore.removeFromFavorite(item);
        _favoriteList.removeWhere((f) => f.id == item.id);
      } else {
        await firestore.addFavorite(item);
        _favoriteList.add(item);
      }

      notifyListeners();
    } on Exception catch (e) {
      final message = AppErrorHandler.getMessageFromException(e);
      _error = message;
      notifyListeners();
    } finally {
      _isLoading = false;
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
      notifyListeners();
    } on Exception catch (e) {
      final message = AppErrorHandler.getMessageFromException(e);
      _error = message;
      notifyListeners();
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
    } on Exception catch (e) {
      final message = AppErrorHandler.getMessageFromException(e);
      _error = message;
      // print(e.toString());
      notifyListeners();
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
    } on Exception catch (e) {
      final message = AppErrorHandler.getMessageFromException(e);
      _error = message;
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  bool isLiked(Food item) {
    return _favoriteList.any((f) => f.id == item.id);
  }
}

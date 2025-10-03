import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ykos_bbq_chicken/enum/category_enum.dart';
import 'package:ykos_bbq_chicken/model/category.dart';
import 'package:ykos_bbq_chicken/model/extra.dart';
import 'package:ykos_bbq_chicken/model/food.dart';
import 'package:ykos_bbq_chicken/repository/food_repository.dart';

class ViewmodelMenu extends ChangeNotifier {
  //FoodRepository
  final foodRepo = FoodRepository.instance;

  //Menu-Liste vom Repository
  late final List<Food> _menuList = foodRepo.getFoodsOrDrinks();
  List<Food> get menuList => _menuList;

  //Extra-Liste vom Repository
  late final List<Extra> _extraList = foodRepo.getExtras();
  List<Extra> get extraList => _extraList;

  List<Extra> _currentExtras = [];
  List<Extra> get currentExtras => _currentExtras;

  //Favorited List
  List<Food> _favoritedList = [];
  List<Food> get favoritedList => _favoritedList;

  //Nimmt die Kategorien von den ganzen Menu raus einmalig für die Kategorie-Liste
  List<Category> getCategoriesFromFoods(final List<Food> menuList) {
    List<Category> categories = [];

    for (var food in menuList) {
      // Prüfen, ob die Kategorie bereits existiert
      bool exists = categories.any(
        (element) => element.name == food.category.name,
      );

      // Wenn nicht, hinzufügen
      if (!exists) {
        categories.add(food.category);
      }
    }

    return categories;
  }

  //Load Extra's in DetailPage
  void loadExtrasForItem(String itemCategory) {
    _currentExtras =
        _extraList
            .where((extra) => extra.extraCategory.label == itemCategory)
            .toList();
    notifyListeners(); // damit das UI automatisch rebuildet
  }

  List<Food> _cartList = [];
  List<Food> get cartList => _cartList;

  //SECTION: FUNKTION'S
  void loadFavoritedList() {
    _favoritedList =
        _menuList.where((item) => item.isFavorited == true).toList();
    notifyListeners();
  }

  void toggleFavorite(Food item) {
    item.isFavorited = !item.isFavorited;
    notifyListeners();

    if (item.isFavorited) {
      _favoritedList.add(item);
      notifyListeners();
    } else {
      _favoritedList.remove(item);
      notifyListeners();
    }
  }

  List<Food> loadCartList() {
    return _cartList;
  }

  void addToCart(Food item) {
    _cartList.add(item);
    notifyListeners();
  }

  Food updateMeal(Food item) {
    final updatedFood = Food(
      artikelNr: item.artikelNr,
      name: item.name,
      description: item.description,
      category: item.category,
      imgAsset: item.imgAsset,
      price: item.price,
      labels: item.labels,
      allergens: item.allergens,
      extras: item.extras,
      count: item.count,
      isFavorited: item.isFavorited,
      note: item.note,
    );
    notifyListeners();
    return updatedFood;
  }
}

import 'package:flutter/material.dart';
import 'package:ykos_bbq_chicken/model/category.dart';
import 'package:ykos_bbq_chicken/model/food.dart';
import 'package:ykos_bbq_chicken/repository/food_repository.dart';

class ViewmodelMenu extends ChangeNotifier {
  //FoodRepository
  final foodRepo = FoodRepository.instance;

  late final List<Food> _menuList = foodRepo.getFoodsOrDrinks();
  List<Food> get menuList => _menuList;

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
}

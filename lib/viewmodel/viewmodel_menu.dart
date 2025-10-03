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


  void loadExtrasForItem(String itemCategory) {
    _currentExtras =
        _extraList
            .where((extra) => extra.extraCategory.label == itemCategory)
            .toList();
    notifyListeners(); // damit das UI automatisch rebuildet
  }

  // List<Extra> getExtraFromRepository(String itemCategory) {
  //   final List<Extra> newExtraList = [];

  //   for (var extra in _extraList) {
  //     if (extra.extraCategory.label == itemCategory) {
  //       print(extra.extraCategory);
  //       print(itemCategory);

  //       newExtraList.add(extra);
  //     }
  //   }

  //   return newExtraList;
  // }

}

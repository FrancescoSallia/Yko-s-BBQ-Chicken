import 'package:flutter/material.dart';
import 'package:ykos_bbq_chicken/enum/category_enum.dart';
import 'package:ykos_bbq_chicken/model/category.dart';
import 'package:ykos_bbq_chicken/model/extra.dart';
import 'package:ykos_bbq_chicken/model/food.dart';
import 'package:ykos_bbq_chicken/model/order_summary.dart';
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

  final List<Food> _cartList = [];
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
    final cartItem = Food(
      id: item.id, // gleiche ID, wenn du es eindeutig brauchst
      artikelNr: item.artikelNr,
      name: item.name,
      description: item.description,
      category: item.category,
      imgAsset: item.imgAsset,
      price: item.price,
      labels: item.labels,
      allergens: item.allergens,
      extras: List<Extra>.from(item.extras ?? []),
      count: item.count,
      isFavorited: item.isFavorited,
      note: item.note,
    );
    _cartList.add(cartItem);
    notifyListeners();
  }

  Food updateMeal(Food item) {
    final updatedFood = Food(
      id: item.id,
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

  Food resetMeal(Food item) {
    final resetFood = Food(
      id: item.id,
      artikelNr: item.artikelNr,
      name: item.name,
      description: item.description,
      category: item.category,
      imgAsset: item.imgAsset,
      price: item.price,
      labels: item.labels ?? [], // 👈 sichere Default-Liste
      allergens: item.allergens,
      extras: item.extras ?? [], // 👈 niemals null
      count: 1,
      isFavorited: item.isFavorited,
      note: item.note ?? "", // 👈 leere Notiz statt null
    );
    notifyListeners();
    return resetFood;
  }

  void countIncrease(final Extra extraItem, final Food item) {
    // Anzahl erhöhen
    extraItem.anzahl++;
    // Prüfen, ob dieses Extra schon in der Liste ist
    final existingIndex = item.extras?.indexWhere(
      (e) => e.name == extraItem.name,
    );

    if (existingIndex != -1 && existingIndex != null) {
      // Falls schon vorhanden, einfach die Anzahl dort erhöhen
      item.extras?[existingIndex].anzahl = extraItem.anzahl;
    } else {
      // Falls nicht vorhanden, neu hinzufügen
      item.extras?.add(
        Extra(
          name: extraItem.name,
          price: extraItem.price,
          extraCategory: extraItem.extraCategory,
          anzahl: extraItem.anzahl,
        ),
      );
    }
    notifyListeners();
  }

  void countDecrease(Extra extraItem, Food item) {
    if (extraItem.anzahl > 0) {
      extraItem.anzahl--;

      final existingIndex = item.extras?.indexWhere(
        (e) => e.name == extraItem.name,
      );

      if (existingIndex != -1 && existingIndex != null) {
        if (extraItem.anzahl == 0) {
          // Wenn 0 → aus Liste entfernen
          item.extras?.removeAt(existingIndex);
        } else {
          // Nur aktualisieren
          item.extras?[existingIndex].anzahl = extraItem.anzahl;
        }
      }
    }
    notifyListeners();
  }

  void removeFromList(List list, Object removeItem) {
    list.remove(removeItem);
    notifyListeners();
  }

  List<Food> _filtredList = [];
  List<Food> get filteredList => _filtredList;

  //Load Menu from Selected Category in HomePage
  void loadMenuFromCategory(String itemCategory) {
    _filtredList =
        _menuList
            .where((category) => category.category.name == itemCategory)
            .toList();
    notifyListeners(); // damit das UI automatisch rebuildet
  }

  int indexOfCategory(String itemCategory) {
    final index = getCategoriesFromFoods(
      _menuList,
    ).indexWhere((element) => element.name == itemCategory);
    notifyListeners();
    return index;
  }

  void resetExtras() {
    for (var extra in currentExtras) {
      extra.anzahl = 0;
    }
    notifyListeners();
  }

  double _currentDiscount = 0;
  double get currentDiscount => _currentDiscount;

  // ✅ Setter hinzufügen
  set currentDiscount(double? value) {
    _currentDiscount = value ?? 0.0; // Falls null übergeben wird
    notifyListeners(); // UI aktualisieren
  }

  OrderSummary orderSummeryBox() {
    final OrderSummary orderSummary = OrderSummary(
      foods: _cartList,
      discount: _currentDiscount,
      deliveryCharge: 1.50,
    );
    return orderSummary;
  }
}

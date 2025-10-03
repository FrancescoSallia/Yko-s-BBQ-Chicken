import 'package:ykos_bbq_chicken/enum/category_enum.dart';
import 'package:ykos_bbq_chicken/model/category.dart';
import 'package:ykos_bbq_chicken/model/extra.dart';
import 'package:ykos_bbq_chicken/model/food.dart';

class FoodRepository {
  // ✅ 1. Privater Konstruktor – verhindert, dass jemand versehentlich eine neue Instanz erstellt
  FoodRepository._privateConstructor();

  // ✅ 2. Statische Singleton-Instanz
  static final instance = FoodRepository._privateConstructor();

  List<Food> getFoodsOrDrinks() {
    final List<Food> _list = [
      Food(
        name: "Chicken Drumstick's",
        description:
            "Juicy, tender, and perfectly seasoned with a shattering crunch.",

        imgAsset: "lib/img/chicken_drumsticks.png",
        price: 12.90,
        artikelNr: null,
        labels: [],
        allergens: ["A", "F"],
        category: Category(
          name: CategoryEnum.recommend.label,
          categoryImg: "lib/img/category1.png",
        ),
        extras: [],
      ),
      // 1. Gegrillte Spieße
      Food(
        name: "Flame-Grilled Skewers",
        description:
            "Tender cubes of chicken breast, marinated in garlic-lime and flame-kissed.",
        category: Category(
          name: CategoryEnum.recommend.label,
          categoryImg: "lib/img/category1.png",
        ),
        imgAsset: "lib/img/food2.png",
        price: 13.50,
        artikelNr: null,
        labels: [],
        allergens: ["2", "1", "P"],
        extras: [],
      ),
      // 2. Scharf-Süße Flügel
      Food(
        name: "Sweet Chili Wings",
        description:
            "Crisp wings coated in a sticky, sweet-spicy chili glaze. Perfect for sharing.",
        category: Category(
          name: CategoryEnum.recommend.label,
          categoryImg: "lib/img/category1.png",
        ),
        imgAsset: "lib/img/food1.png",
        artikelNr: null,
        price: 9.90,
        labels: [],
        allergens: ["G", "S"],
        extras: [],
      ),
      Food(
        name: "Pizza Angela",
        description:
            "with tomatosauce, Mozzarella, spicy Salami, Mushroom's and Onion's.",
        category: Category(
          name: CategoryEnum.main.label,
          categoryImg: "lib/img/category2.png",
        ),
        imgAsset: "lib/img/pizza_angela1.png",
        artikelNr: null,
        price: 12.50,
        labels: [],
        allergens: ["2", "1", "P"],
        extras: [],
      ),
      Food(
        name: "Pizza Tonno",
        description: "with tomatosauce, Mozzarella, Tuna and Onion's.",
        category: Category(
          name: CategoryEnum.main.label,
          categoryImg: "lib/img/category2.png",
        ),
        imgAsset: "lib/img/pizza_tonno1.png",
        artikelNr: null,
        price: 14.90,
        labels: [],
        allergens: ["A", "F"],
        extras: [],
      ),
      Food(
        name: "Pizza della Nonna",
        description:
            "with tomatosauce, Mozzarella, black Olive's, caper's, anchovies and artichokes .",
        category: Category(
          name: CategoryEnum.main.label,
          categoryImg: "lib/img/category2.png",
        ),
        imgAsset: "lib/img/pizza_nonna.png",
        artikelNr: null,
        price: 15.90,
        labels: [],
        allergens: ["2", "LM", "P"],
        extras: [],
      ),

      Food(
        name: "Cocktail Sunrise",
        description: "Cocktail Sunrise with Orange slice and ice cubes",
        category: Category(
          name: CategoryEnum.drinks.label,
          categoryImg: "lib/img/category3.png",
        ),
        imgAsset: "lib/img/cocktail1.png",
        artikelNr: null,
        price: 15.90,
        labels: [],
        allergens: ["2", "LM", "P"],
        extras: [],
      ),
      Food(
        name: "Cocktail Orange Rum",
        description:
            "Cocktail Orange Rum with Orange slice and ice cubes and Orange juice",
        category: Category(
          name: CategoryEnum.drinks.label,
          categoryImg: "lib/img/category3.png",
        ),
        imgAsset: "lib/img/cocktail2.png",
        artikelNr: null,
        price: 15.90,
        labels: [],
        allergens: ["2", "LM", "P"],
        extras: [],
      ),
    ];

    return _list;
  }

  // Funktion: Liefert eine Liste von Extras
  List<Extra> getExtras() {
    return [
      // Pizza Extras
      Extra(
        name: "Extra Käse",
        price: 1.5,
        extraCategory: CategoryEnum.main,
        anzahl: 0,
      ),
      Extra(
        name: "Salami",
        price: 2.0,
        extraCategory: CategoryEnum.recommend,
        anzahl: 0,
      ),
      Extra(
        name: "Schinken",
        price: 2.0,
        extraCategory: CategoryEnum.recommend,
        anzahl: 0,
      ),
      Extra(
        name: "Pilze",
        price: 1.0,
        extraCategory: CategoryEnum.starters,
        anzahl: 0,
      ),

      // Salat Extras
      Extra(
        name: "Oliven",
        price: 0.8,
        extraCategory: CategoryEnum.main,
        anzahl: 0,
      ),
      Extra(
        name: "Tomaten",
        price: 0.7,
        extraCategory: CategoryEnum.recommend,
        anzahl: 0,
      ),
      Extra(name: "Gurken", price: 0.5, extraCategory: CategoryEnum.drinks),

      // Nudeln Extras
      Extra(
        name: "Parmesan",
        price: 1.0,
        extraCategory: CategoryEnum.drinks,
        anzahl: 0,
      ),
      Extra(name: "Basilikum", price: 0.5, extraCategory: CategoryEnum.pasta),
      Extra(name: "Knoblauch", price: 0.3, extraCategory: CategoryEnum.pasta),
    ];
  }
}

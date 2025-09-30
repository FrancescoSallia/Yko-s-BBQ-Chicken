import 'package:ykos_bbq_chicken/enum/category_enum.dart';
import 'package:ykos_bbq_chicken/model/food.dart';

class FoodRepository {
  void getFoodsOrDrinks() {
    Food(
      name: "Chicken Drumstick's",
      description:
          "Juicy, tender, and perfectly seasoned with a shattering crunch.",
      category: CategoryEnum.popular.label,
      imgAsset: "lib/img/chicken_drumsticks.png",
      price: 12.90,
    );
    // 1. Gegrillte Spieße
    Food(
      name: "Flame-Grilled Skewers",
      description:
          "Tender cubes of chicken breast, marinated in garlic-lime and flame-kissed.",
      category: CategoryEnum.popular.label,
      imgAsset: "lib/img/food2.png",
      price: 13.50,
    );

    // 2. Scharf-Süße Flügel
    Food(
      name: "Sweet Chili Wings",
      description:
          "Crisp wings coated in a sticky, sweet-spicy chili glaze. Perfect for sharing.",
      category: CategoryEnum.popular.label,
      imgAsset: "lib/img/food1.png",
      price: 9.90,
    );
    Food(
      name: "Pizza Angela",
      description:
          "with tomatosauce, Mozzarella, spicy Salami, Mushroom's and Onion's.",
      category: CategoryEnum.main.label,
      imgAsset: "lib/img/pizza_angela1",
      price: 12.50,
    );

    Food(
      name: "Pizza Tonno",
      description: "with tomatosauce, Mozzarella, Tuna and Onion's.",
      category: CategoryEnum.main.label,
      imgAsset: "lib/img/pizza_tonno.png",
      price: 14.90,
    );

    Food(
      name: "Pizza della Nonna",
      description:
          "with tomatosauce, Mozzarella, black Olive's, caper's, anchovies and artichokes .",
      category: CategoryEnum.main.label,
      imgAsset: "lib/img/pizza_nonna.png",
      price: 15.90,
    );
  }
}


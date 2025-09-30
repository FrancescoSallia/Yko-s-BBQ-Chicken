enum CategoryEnum<String> { popular, starters, menu, main, drinks }

extension CategoryName on CategoryEnum {
  String get label {
    switch (this) {
      case CategoryEnum.popular:
        return "Popular";
      case CategoryEnum.menu:
        return "Menu";
      case CategoryEnum.starters:
        return "Starter's";
      case CategoryEnum.drinks:
        return "Drink's";
      case CategoryEnum.main:
        return "Main";
    }
  }
}

enum CategoryEnum<String> { recommend, starters, menu, main, drinks }

extension CategoryName on CategoryEnum {
  String get label {
    switch (this) {
      case CategoryEnum.recommend:
        return "Recommand";
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

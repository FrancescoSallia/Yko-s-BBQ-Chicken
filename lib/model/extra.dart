import 'package:ykos_bbq_chicken/enum/category_enum.dart';

class Extra {
  final String name;
  final double price;
  final CategoryEnum extraCategory;
  int anzahl;

  Extra({
    required this.name,
    required this.price,
    required this.extraCategory,
    this.anzahl = 0,
  });
}

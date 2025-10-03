import 'package:uuid/uuid.dart';
import 'package:ykos_bbq_chicken/model/category.dart';
import 'package:ykos_bbq_chicken/model/extra.dart';

class Food {
  final String id = Uuid().v4();
  final String? artikelNr;
  final String name;
  final String description;
  final Category category;
  final String? imgAsset;
  final double price;
  int anzahl;
  bool isFavorited;
  final List<String>? labels;
  final List<String> allergens;
  final List<Extra>? extras;

  Food({
    required this.artikelNr,
    required this.name,
    required this.description,
    required this.category,
    required this.imgAsset,
    required this.price,
    this.anzahl = 1,
    this.isFavorited = false,
    required this.labels,
    required this.allergens,
    required this.extras,
  });
}

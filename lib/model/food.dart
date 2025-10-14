import 'package:uuid/uuid.dart';
import 'package:ykos_bbq_chicken/model/category.dart';
import 'package:ykos_bbq_chicken/model/extra.dart';

class Food {
  final String id;
  final String? artikelNr;
  final String name;
  final String description;
  final Category category;
  final String? imgAsset;
  final double price;
  String? note;
  int count;
  bool isFavorited;
  final List<String>? labels;
  final List<String> allergens;
  List<Extra>? extras;

  Food({
    String? id, // optional, wenn beim Update übergeben werden sollte
    required this.artikelNr,
    required this.name,
    required this.description,
    required this.category,
    required this.imgAsset,
    required this.price,
    this.count = 1,
    this.isFavorited = false,
    this.note = "",
    required this.labels,
    required this.allergens,
    List<Extra>? extras,
  }) : id =
           Uuid()
               .v4(), //ID wird nur einmal erstellt zufällig und ist nichtmehr wieder änderbar ,  erzeugt neue ID, wenn keine übergeben wurde
       extras = extras ?? [];

  //Firestore toJson funktion, um es in der Datenbank abzuspeichern!
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'price': price};
  }
}

extension FoodPriceExtension on Food {
  double get extrasTotal {
    if (extras == null || extras!.isEmpty) return 0.0;
    return extras!.fold(0.0, (sum, extra) => sum + extra.price * extra.anzahl);
  }

  double get totalWithExtras => (price + extrasTotal) * count;
}

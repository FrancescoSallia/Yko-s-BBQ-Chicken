import 'package:uuid/uuid.dart';

class Food {
  final String id = Uuid().v4();
  final String? artikelNr;
  final String name;
  final String description;
  final String category;
  final String imgAsset;
  final double price;

  Food({
    required this.artikelNr,
    required this.name,
    required this.description,
    required this.category,
    required this.imgAsset,
    required this.price,
  });
}

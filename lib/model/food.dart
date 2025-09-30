import 'package:uuid/uuid.dart';
import 'package:ykos_bbq_chicken/enum/category_enum.dart';

class Food {
  final String id = Uuid().v4();
  final String name;
  final String description;
  final String category;
  final String imgAsset;
  final double price;

  Food({
    required this.name,
    required this.description,
    required this.category,
    required this.imgAsset,
    required this.price,
  });
}

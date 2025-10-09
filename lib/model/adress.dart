import 'package:uuid/uuid.dart';
import 'package:ykos_bbq_chicken/model/adress_symbol.dart';

class Adress {
  final String id;
  final String name;
  final String street;
  final String houseNumber;
  final String plz;
  final String place;
  final AdressSymbol? icon;
  final String? information;
  final String telefon;

  Adress({
    String? id, // optionaler Parameter
    required this.name,
    required this.telefon,
    required this.street,
    required this.houseNumber,
    required this.plz,
    required this.place,
    required this.icon,
    required this.information,
  }) : id =
           id ??
           const Uuid()
               .v4(); // ✅ wenn kein id übergeben wird, automatisch generieren
}

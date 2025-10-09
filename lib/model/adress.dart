import 'package:ykos_bbq_chicken/model/adress_symbol.dart';

class Adress {
  final String name;
  final String street;
  final String houseNumber;
  final int plz;
  final String place;
  final AdressSymbol? icon;
  final String? information;
  final int telefon;

  Adress({
    required this.name,
    required this.telefon,
    required this.street,
    required this.houseNumber,
    required this.plz,
    required this.place,
    required this.icon,
    required this.information,
  });
}

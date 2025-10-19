import 'package:flutter/material.dart';

enum AdressEnum<String> { suit, house, office, outdoor }

extension AdressLabelText on AdressEnum {
  String get labelText {
    switch (this) {
      case AdressEnum.suit:
        return "Wohnung";
      case AdressEnum.house:
        return "Haus";
      case AdressEnum.office:
        return "Büro";
      case AdressEnum.outdoor:
        return "Draußen";
    }
  }
}

extension AdressLabel on AdressEnum {
  IconData get label {
    switch (this) {
      case AdressEnum.suit:
        return Icons.home_work_outlined;
      case AdressEnum.house:
        return Icons.home_outlined;
      case AdressEnum.office:
        return Icons.desk_outlined;
      case AdressEnum.outdoor:
        return Icons.forest_outlined;
    }
  }
}

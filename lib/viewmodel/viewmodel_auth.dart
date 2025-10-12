import 'package:flutter/material.dart';
import 'package:ykos_bbq_chicken/model/user.dart';

class ViewmodelAuth extends ChangeNotifier {
  User? _pickUpUser;
  User? get pickUpUser => _pickUpUser;

  void updatePickUpUser(String name, String lastName, String telefon) {
   if (name.isNotEmpty && lastName.isNotEmpty) {
     final User newUser = User(name: name, lastName: lastName, telefon: telefon);
    _pickUpUser = newUser;
    notifyListeners();
   } else { 
    _pickUpUser = null;
    notifyListeners();
   }
  }
}

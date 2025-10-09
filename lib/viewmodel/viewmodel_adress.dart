import 'package:flutter/cupertino.dart';
import 'package:ykos_bbq_chicken/model/adress.dart';

class ViewmodelAdress extends ChangeNotifier {
  final List<Adress> _adressList = [];
  List<Adress> get adressList => _adressList;

  List<Adress> fetchAdressList() {
    final list = _adressList;
    return list;
  }

  void addToAdressList(Adress adress) {
    _adressList.add(adress);
    notifyListeners();
  }

  void removeFromAdressList(int adressIndex) {
    final list = _adressList;
    list.removeAt(adressIndex);
    notifyListeners();
  }

  void updateAdress(Adress updatedAdress) {
    final index = _adressList.indexWhere(
      (adress) =>
          adress.id == updatedAdress.id 
    );

    if (index != -1) {
      // Update an derselben Position
      _adressList[index] = updatedAdress;
      notifyListeners();
    } else {
      print("Adresse nicht gefunden!");
    }
  }
}

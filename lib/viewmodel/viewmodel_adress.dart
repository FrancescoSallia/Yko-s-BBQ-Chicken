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

  void updateAdress(Adress adress) {
    final list = _adressList;
    final updatedAdress = Adress(
      street: adress.street,
      houseNumber: adress.houseNumber,
      plz: adress.plz,
      place: adress.place,
      icon: adress.icon,
      information: adress.information,
      name: adress.name,
      telefon: adress.telefon,
    );
    list.removeWhere(
      (currentAdress) => currentAdress.street == updatedAdress.street,
    );
    notifyListeners();
  }
}

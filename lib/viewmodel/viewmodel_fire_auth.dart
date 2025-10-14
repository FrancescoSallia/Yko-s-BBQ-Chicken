import 'package:flutter/cupertino.dart';
import 'package:ykos_bbq_chicken/Service/fire_auth.dart';

class ViewmodelFireAuth extends ChangeNotifier {
  final auth = FireAuth();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  Future<void> logIn(String email, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      await auth.logIn(email, password);
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    } finally {
      _isLoading = false;
      _error = null;
      notifyListeners();
    }
  }
}

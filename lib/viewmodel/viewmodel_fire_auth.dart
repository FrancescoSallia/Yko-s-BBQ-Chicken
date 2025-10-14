import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:ykos_bbq_chicken/Error/app_error_handler.dart';
import 'package:ykos_bbq_chicken/Service/fire_auth.dart';

class ViewmodelFireAuth extends ChangeNotifier {
  final auth = FireAuth();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  //Login
  Future<void> logIn(String email, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      await auth.logIn(email, password);
      notifyListeners();
    } on Exception catch (e) {
      final errorMessage = AppErrorHandler.getMessageFromException(e);
      _error = errorMessage;
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  //Register
  Future<void> register(String email, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      await auth.register(email, password);
      notifyListeners();
    } on Exception catch (e) {
      final errorMessage = AppErrorHandler.getMessageFromException(e);
      _error = errorMessage;
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  //resetPassword
  Future<void> resetPassword(String email) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      await auth.resetPasswort(email);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  //Re-Authentification
  Future<void> reAuth(String email, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      await auth.reAuth(email, password);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  //Delete User
  Future<void> deleteUser() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      await auth.deleteUser();
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

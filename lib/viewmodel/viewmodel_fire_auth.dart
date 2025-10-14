import 'package:flutter/cupertino.dart';
import 'package:ykos_bbq_chicken/Error/app_error_handler.dart';
import 'package:ykos_bbq_chicken/Service/fire_auth.dart';

class ViewmodelFireAuth extends ChangeNotifier {
  final auth = FireAuth();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? loginError;
  String? registrationError;
  String? successMessage;
  String? resetPasswortSuccessMessage;
  String? errorMessage;

  //Login
  Future<void> logIn(String email, String password) async {
    _isLoading = true;
    successMessage = null;
    loginError = null;
    notifyListeners();
    try {
      await auth.logIn(email, password);
      successMessage = "Succesfully logged in";
      notifyListeners();
    } on Exception catch (e) {
      final errorMessageFromHandler = AppErrorHandler.getMessageFromException(
        e,
      );
      loginError = errorMessageFromHandler;
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  //Register
  Future<void> register(String email, String password) async {
    _isLoading = true;
    registrationError = null;
    successMessage = null;
    notifyListeners();
    try {
      await auth.register(email, password);
      successMessage = "Registation Successful";
      notifyListeners();
    } on Exception catch (e) {
      final errorMessageFromHandler = AppErrorHandler.getMessageFromException(
        e,
      );
      registrationError = errorMessageFromHandler;
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  //resetPassword
  Future<void> resetPassword(String email) async {
    _isLoading = true;
    errorMessage = null;
    resetPasswortSuccessMessage = null;
    notifyListeners();
    try {
      await auth.resetPasswort(email);
      resetPasswortSuccessMessage = "if email exist, it will be send";
      notifyListeners();
    } on Exception catch (e) {
      final errorMessageFromHandler = AppErrorHandler.getMessageFromException(
        e,
      );
      errorMessage = errorMessageFromHandler;

      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  //Re-Authentification
  Future<void> reAuth(String email, String password) async {
    _isLoading = true;
    errorMessage = null;
    successMessage = null;
    notifyListeners();
    try {
      await auth.reAuth(email, password);
      successMessage = "Re-Authentification send";
      notifyListeners();
    } catch (e) {
      errorMessage = e.toString();
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  //Delete User
  Future<void> deleteUser() async {
    _isLoading = true;
    errorMessage = null;
    notifyListeners();
    try {
      await auth.deleteUser();
      notifyListeners();
    } catch (e) {
      errorMessage = e.toString();
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

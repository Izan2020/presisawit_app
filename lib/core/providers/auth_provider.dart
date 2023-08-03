import 'package:flutter/foundation.dart';
import 'package:presisawit_app/core/constants/enum.dart';
import 'package:presisawit_app/core/models/login_credentials.dart';
import 'package:presisawit_app/core/models/register_credentials.dart';
import 'package:presisawit_app/core/models/register_response.dart';
import 'package:presisawit_app/core/services/auth_repository.dart';
import 'package:presisawit_app/core/services/firebase_repository.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseRepository firebaseRepository;
  final AuthRepository authRepository;
  AuthProvider(this.firebaseRepository, this.authRepository);

  String? _message;
  String? get message => _message;

  ServiceState validateCompanyState = ServiceState.init;
  ServiceState registerUserState = ServiceState.init;
  ServiceState loginUserState = ServiceState.init;

  // O=========================================================================>
  // ? Additional Functions
  // <=========================================================================O

  _setMessage(String? value) {
    _message = value;
    notifyListeners();
  }

  _setValidateCompanyState(ServiceState value) {
    validateCompanyState = value;
    notifyListeners();
  }

  _setRegisterUserState(ServiceState value) {
    registerUserState = value;
    notifyListeners();
  }

  _setLoginUserState(ServiceState value) {
    loginUserState = value;
    notifyListeners();
  }

  clearAllAuthState() {
    _message = null;
    loginUserState = ServiceState.init;
    validateCompanyState = ServiceState.init;
    registerUserState = ServiceState.init;
    notifyListeners();
  }

  // O=========================================================================>
  // ? Sign in User
  // <=========================================================================O

  Future<bool> loginUser(LoginCredentials user) async {
    try {
      _setLoginUserState(ServiceState.loading);
      final snapshot = await authRepository.loginUser(user);

      if (snapshot == Success()) {
        _setLoginUserState(ServiceState.success);
        return true;
      } else {
        _setLoginUserState(ServiceState.error);
        return false;
      }
    } on Error catch (e) {
      _setLoginUserState(ServiceState.error);
      _setMessage(e.message);
      return false;
    }
  }

  // O=========================================================================>
  // ? Register User
  // <=========================================================================O

  Future<bool> registerUser(
    RegisterCredentials user,
  ) async {
    try {
      _setRegisterUserState(ServiceState.loading);
      final snapshot = await authRepository.registerUser(user);
      debugPrint(snapshot.toString());
      if (snapshot == Success()) {
        _setRegisterUserState(ServiceState.success);

        return true;
      } else {
        _setRegisterUserState(ServiceState.error);

        return false;
      }
    } on Error catch (e) {
      debugPrint('Authentication Error 2');
      _setRegisterUserState(ServiceState.error);
      _setMessage(e.message);
      return false;
    }
  }

  // O=========================================================================>
  // ? Validate Company ID
  // <=========================================================================O

  Future<bool> validateCompanyID(String companyId) async {
    try {
      if (companyId == "") return false;
      _setValidateCompanyState(ServiceState.loading);
      final snapshot = await firebaseRepository.getCompanyData(companyId);
      if (snapshot?.name != null) {
        _setValidateCompanyState(ServiceState.success);
        _setMessage('${snapshot?.name} ✓');
        return true;
      } else {
        _setValidateCompanyState(ServiceState.error);
        _setMessage('Company not Found');
        return false;
      }
    } catch (e) {
      _setValidateCompanyState(ServiceState.error);
      _setMessage(e.toString());
      return false;
    }
  }
}

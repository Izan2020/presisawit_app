import 'package:flutter/foundation.dart';
import 'package:presisawit_app/core/constants/enum.dart';
import 'package:presisawit_app/core/models/login_credentials.dart';
import 'package:presisawit_app/core/models/register_credentials.dart';
import 'package:presisawit_app/core/models/register_response.dart';
import 'package:presisawit_app/core/usecases/auth_usecases.dart';

import 'package:presisawit_app/core/usecases/firebase_usescases.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseUsecases firebaseUsecases;
  final AuthUsecases authUsecases;
  AuthProvider({required this.authUsecases, required this.firebaseUsecases});

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
      final snapshot = await authUsecases.loginUser(user);

      if (snapshot is DataSuccess) {
        _setLoginUserState(ServiceState.success);
        return true;
      } else {
        _setLoginUserState(ServiceState.error);
        return false;
      }
    } on DataError catch (e) {
      _setLoginUserState(ServiceState.error);
      _setMessage(e.error);
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
      final snapshot = await authUsecases.regsiterUser(user);
      debugPrint(snapshot.toString());
      if (snapshot is DataSuccess) {
        _setRegisterUserState(ServiceState.success);

        return true;
      } else {
        _setRegisterUserState(ServiceState.error);

        return false;
      }
    } on DataError catch (e) {
      debugPrint('Authentication Error 2');
      _setRegisterUserState(ServiceState.error);
      _setMessage(e.error);
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
      final snapshot = await firebaseUsecases.validateCompanyId(companyId);
      if (snapshot is DataSuccess) {
        _setValidateCompanyState(ServiceState.success);
        _setMessage('${snapshot.data?.name} ✓');
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

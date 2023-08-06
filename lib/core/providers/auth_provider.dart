import 'package:flutter/foundation.dart';
import 'package:presisawit_app/core/classes/models/credential_preferences.dart';
import 'package:presisawit_app/core/constants/enum.dart';
import 'package:presisawit_app/core/classes/login_credentials.dart';
import 'package:presisawit_app/core/classes/register_credentials.dart';
import 'package:presisawit_app/core/classes/logic/data_response.dart';
import 'package:presisawit_app/core/api/auth_repository.dart';
import 'package:presisawit_app/core/api/firebase_repository.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseRepository firebaseRepository;
  final AuthRepository authRepository;
  AuthProvider(
      {required this.firebaseRepository, required this.authRepository});

  String? _message;
  String? get message => _message;

  ServiceState validateCompanyState = ServiceState.init;
  ServiceState registerUserState = ServiceState.init;
  ServiceState loginUserState = ServiceState.init;

  CredentialPreferences? _currentUserCredentials;
  CredentialPreferences? get currentUserCredentials => _currentUserCredentials;

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
  // ? Get saved user Credentials
  // <=========================================================================O

  Future<void> getUserCredentials() async {
    final response = await authRepository.getSavedCredentials();
    if (response is DataSuccess) {
      _currentUserCredentials = response.data;
      notifyListeners();
    } else {
      throw Exception(response.error);
    }
  }

  // O=========================================================================>
  // ? Sign in User
  // <=========================================================================O

  Future<bool> loginUser(LoginCredentials user) async {
    try {
      _setLoginUserState(ServiceState.loading);
      final snapshot = await authRepository.loginUser(user);

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
      final snapshot = await authRepository.registerUser(user);
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
      final snapshot = await firebaseRepository.getCompanyData(companyId);
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

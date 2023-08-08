import 'package:flutter/foundation.dart';
import 'package:presisawit_app/core/api/firebase_repository.dart';
import 'package:presisawit_app/core/classes/logic/data_response.dart';
import 'package:presisawit_app/core/classes/models/company_details.dart';
import 'package:presisawit_app/core/classes/models/credential_preferences.dart';
import 'package:presisawit_app/core/constants/enum.dart';

class CompanyProvider extends ChangeNotifier {
  final FirebaseRepository firebaseRepository;
  CompanyProvider({required this.firebaseRepository});

  String? message;

  CompanyDetail? _currentCompanyDetail;
  CompanyDetail? get currentCompanyDetail => _currentCompanyDetail;

  ServiceState currentCompanyDetailState = ServiceState.init;

  // O=========================================================================>
  // ? Additional Functions
  // <=========================================================================O

  _setMessage(String value) {
    message = value;
    notifyListeners();
  }

  _setcurrentCompanyDetailState(ServiceState value) {
    currentCompanyDetailState = value;
    notifyListeners();
  }

  // O=========================================================================>
  // ? Set Current Company Detail
  // <=========================================================================O

  Future<void> setCurrentCompanyDetails() async {
    try {
      _setcurrentCompanyDetailState(ServiceState.loading);
      final savedCred = await firebaseRepository.getSavedCredentials();
      CredentialPreferences savedCreds = savedCred.data;
      final response = await firebaseRepository
          .getCompanyDetails(savedCreds.companyId ?? "");
      if (response is DataSuccess) {
        _setcurrentCompanyDetailState(ServiceState.success);
        _currentCompanyDetail = response.data;
      } else {
        _setMessage('Something went Wrong');
        _setcurrentCompanyDetailState(ServiceState.error);
      }
    } catch (e) {
      _setcurrentCompanyDetailState(ServiceState.error);
      _setMessage(e.toString());
    }
  }
}

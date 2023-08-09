import 'package:flutter/material.dart';
import 'package:presisawit_app/core/api/firebase_repository.dart';
import 'package:presisawit_app/core/classes/logic/data_response.dart';
import 'package:presisawit_app/core/classes/models/field.dart';
import 'package:presisawit_app/core/constants/enum.dart';

import '../classes/models/credential_preferences.dart';

class FieldsProvider extends ChangeNotifier {
  final FirebaseRepository firebaseRepository;
  FieldsProvider({required this.firebaseRepository});

  String? message;

  List<Field>? _listOfFields = [];
  List<Field>? get listOfFields => _listOfFields;

  ServiceState listOfFieldsState = ServiceState.init;

  // O=========================================================================>
  // ? Additional Functions
  // <=========================================================================O

  _setListOfFieldsState(ServiceState value) {
    listOfFieldsState = value;
    notifyListeners();
  }

  _setMessage(String value) {
    message = value;
    notifyListeners();
  }

  // O=========================================================================>
  // ? Get List of Fields
  // <=========================================================================O

  Future<void> getListOfFields() async {
    try {
      _setListOfFieldsState(ServiceState.loading);
      await Future.delayed(const Duration(milliseconds: 2500));
      final savedCred = await firebaseRepository.getSavedCredentials();
      CredentialPreferences savedCreds = savedCred.data;
      final response =
          await firebaseRepository.getListOfFields(savedCreds.companyId ?? "");
      if (response is DataSuccess) {
        _setListOfFieldsState(ServiceState.success);
        _listOfFields = response.data;
      } else {
        _setListOfFieldsState(ServiceState.error);
      }
    } catch (e) {
      _setListOfFieldsState(ServiceState.error);
      _setMessage(e.toString());
    }
  }
}

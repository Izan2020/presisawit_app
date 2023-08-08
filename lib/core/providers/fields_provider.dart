import 'package:flutter/material.dart';
import 'package:presisawit_app/core/api/firebase_repository.dart';
import 'package:presisawit_app/core/classes/logic/data_response.dart';
import 'package:presisawit_app/core/classes/models/field.dart';
import 'package:presisawit_app/core/constants/enum.dart';

class FieldsProvider extends ChangeNotifier {
  final FirebaseRepository firebaseRepository;
  FieldsProvider(this.firebaseRepository);

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

  Future<void> getListOfFields(String companyId) async {
    try {
      _setListOfFieldsState(ServiceState.loading);
      final response = await firebaseRepository.getListOfFields(companyId);
      if (response is DataSuccess) {
        _listOfFields = response.data;
      } else {
        _setListOfFieldsState(ServiceState.error);
      }
    } catch (e) {
      _setMessage(e.toString());
      _setListOfFieldsState(ServiceState.error);
    }
  }
}

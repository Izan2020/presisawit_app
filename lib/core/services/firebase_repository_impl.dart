import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/foundation.dart';
import 'package:presisawit_app/core/classes/login_credentials.dart';
import 'package:presisawit_app/core/classes/models/company_details.dart';
import 'package:presisawit_app/core/classes/models/company_validate.dart';
import 'package:presisawit_app/core/classes/logic/data_response.dart';
import 'package:presisawit_app/core/api/firebase_repository.dart';
import 'package:presisawit_app/core/classes/models/field.dart';
import 'package:presisawit_app/core/classes/register_credentials.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../classes/models/credential_preferences.dart';
import '../constants/shared_preferences.dart';
import '../utils/error_parser.dart';

class FirebaseRepositoryImpl implements FirebaseRepository {
  final usersCollection = FirebaseFirestore.instance.collection("users");
  final companyDb = FirebaseFirestore.instance.collection('company');
  final fieldDb = FirebaseFirestore.instance.collection('fields');
  final firebaseAuth = FirebaseAuth.instance;

  // O=========================================================================>
  // ? Additional Authentication Functions
  // <=========================================================================O

  @override
  Future<DataState<CredentialPreferences>> getSavedCredentials() async {
    final sp = await _sharedPref();
    final savedJSON = sp.getString(AppSharedKey.currentUserCredentials);
    if (savedJSON != null) {
      final decodedData = CredentialPreferences.fromJson(savedJSON);
      return DataSuccess(decodedData);
    } else {
      throw const DataError('Unable to get Saved Preferences');
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    await _delay(3500);
    final auth = await firebaseAuth.authStateChanges().first;

    return auth?.uid != null;
  }

  Future<void> logoutUser() async {
    return firebaseAuth.signOut();
  }

  // O=========================================================================>
  // ? Additional Functions
  // <=========================================================================O

  Future<void> _delay(int duration) async {
    return await Future.delayed(Duration(milliseconds: duration));
  }

  Future<SharedPreferences> _sharedPref() async {
    return await SharedPreferences.getInstance();
  }

  // O=========================================================================>
  // ? Validate Company Availability
  // <=========================================================================O

  @override
  Future<DataState<CompanyValidate?>> validateCompanyData(
      String companyToken) async {
    try {
      await _delay(1500);
      final snapshot = companyDb
          .where("token", isEqualTo: companyToken)
          .withConverter(
              fromFirestore: CompanyValidate.fromFirestore,
              toFirestore: (CompanyValidate company, _) =>
                  company.toFireStore());
      final querySnapshot = await snapshot.get();
      final document = querySnapshot.docs.first;
      final company = document.data();
      return DataSuccess(company);
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        debugPrint('( Validate Company Availability Exception )\n${e.message}');
      }
      throw const DataError('Periksa Koneksi Anda');
    }
  }

  // O=========================================================================>
  // ? Get Company Detail
  // <=========================================================================O

  @override
  Future<DataState<CompanyDetail>> getCompanyDetails(String companyId) async {
    try {
      debugPrint("Loading Company Detail...");
      await _delay(1500);
      final snapshot = companyDb.doc(companyId).withConverter(
          fromFirestore: CompanyDetail.fromFirestore,
          toFirestore: (CompanyDetail cd, _) => cd.toFireStore());
      final docSnap = await snapshot.get();
      final companyDetail = docSnap.data();
      if (companyDetail != null) {
        debugPrint("Success");
        return DataSuccess(companyDetail);
      } else {
        debugPrint("Error 1");
        return const DataError('Terjadi Kesalahan Server');
      }
    } on FirebaseException catch (e) {
      debugPrint("Error 2");
      if (kDebugMode) {
        debugPrint('( Get Company Detail Exception )\n${e.message}');
      }
      throw const DataError('Periksa Koneksi Anda');
    }
  }

  // O=========================================================================>
  // ? Login User
  // <=========================================================================O

  @override
  Future<DataState> loginUser(LoginCredentials user) async {
    final sp = await _sharedPref();
    try {
      final response = await firebaseAuth.signInWithEmailAndPassword(
          email: user.email, password: user.password);
      if (response.user?.email != null) {
        final credentialResponse = usersCollection
            .doc(response.user?.uid)
            .withConverter(
                fromFirestore: CredentialPreferences.fromFirestore,
                toFirestore: (CredentialPreferences creds, _) =>
                    creds.toFirestore());
        final docSnap = await credentialResponse.get();
        final data = docSnap.data();

        final savedCredentials = CredentialPreferences(
                userName: data?.userName,
                userId: response.user?.uid,
                companyId: data?.companyId,
                fieldId: data?.fieldId,
                role: data?.role)
            .toJson();
        if (kDebugMode) {
          debugPrint(savedCredentials);
        }
        sp.setString(AppSharedKey.currentUserCredentials, savedCredentials);
        return DataSuccess(response);
      } else {
        return const DataError("Terjadi Kesalahan Server");
      }
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        debugPrint('( Sign In User Exception )\n${e.message}');
      }
      throw authErrors(e.code);
    }
  }

  // O=========================================================================>
  // ? Register User
  // <=========================================================================O

  @override
  Future<DataState> registerUser(RegisterCredentials user) async {
    final sp = await _sharedPref();
    try {
      final response = await firebaseAuth.createUserWithEmailAndPassword(
          email: user.email, password: user.password);
      if (response.user?.email != null) {
        usersCollection.doc(response.user?.uid).set({
          "userId": response.user?.uid,
          "name": user.name,
          "email": user.email,
          "role": user.role,
          "phoneNumber": user.phoneNumber,
          "profilePicture": "",
          "aboutMe": "",
          "createdAt": FieldValue.serverTimestamp(),
          "ktpNumber": user.ktpNumber,
          "address": user.address,
          "companyId": user.companyId,
          "fieldId": user.fieldId
        });

        final savedCredentials = CredentialPreferences(
                userName: user.name,
                userId: response.user?.uid,
                companyId: user.companyId,
                fieldId: user.fieldId,
                role: user.role)
            .toJson();

        debugPrint(savedCredentials);

        sp.setString(AppSharedKey.currentUserCredentials, savedCredentials);

        return DataSuccess(response);
      } else {
        return const DataError('Terjadi Kesalahan Server');
      }
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        debugPrint('( Register User Exception )\n${e.message}');
      }
      throw authErrors(e.code);
    }
  }

  @override
  Future<DataState<List<Field>>> getListOfFields(String companyId) async {
    try {
      final snapshot = fieldDb
          .where("companyId", isEqualTo: companyId)
          .withConverter(
              fromFirestore: Field.fromFirestore,
              toFirestore: (Field field, _) => field.toFireStore());
      final docSnap = await snapshot.get();
      final docs = docSnap.docs;
      final fields = docs.map((doc) => doc.data()).toList();

      return DataSuccess(fields);
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        debugPrint('( Get listOfFields Exception )\n${e.message}');
      }
      throw const DataError('Periksa Koneksi Anda');
    }
  }
}

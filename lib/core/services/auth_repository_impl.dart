import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:presisawit_app/core/classes/models/credential_preferences.dart';
import 'package:presisawit_app/core/constants/shared_preferences.dart';
import 'package:presisawit_app/core/classes/login_credentials.dart';
import 'package:presisawit_app/core/classes/register_credentials.dart';
import 'package:presisawit_app/core/classes/logic/data_response.dart';
import 'package:presisawit_app/core/api/auth_repository.dart';
import 'package:presisawit_app/core/utils/error_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepositoryImpl implements AuthRepository {
  final firebaseAuth = FirebaseAuth.instance;
  final usersCollection = FirebaseFirestore.instance.collection("users");
  final companyCollection = FirebaseFirestore.instance.collection("company");

  // O=========================================================================>
  // ? Additional Functions
  // <=========================================================================O

  Future<SharedPreferences> _sharedPref() async {
    return await SharedPreferences.getInstance();
  }

  Future<void> _delay(int duration) async {
    return Future.delayed(Duration(milliseconds: duration));
  }

  // O=========================================================================>
  // ? Authentication Functions
  // <=========================================================================O

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
          "password": user.password,
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
                userName: response.user?.displayName,
                userId: response.user?.uid,
                companyId: user.companyId,
                fieldId: user.fieldId,
                role: user.role)
            .toJson();

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

  // O=========================================================================>
  // ? Sign in User
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
  // ? Get Saved Credentials
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
}

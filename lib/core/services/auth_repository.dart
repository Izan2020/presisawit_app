import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:presisawit_app/core/constants/shared_preferences.dart';

import 'package:presisawit_app/core/models/login_credentials.dart';
import 'package:presisawit_app/core/models/register_credentials.dart';
import 'package:presisawit_app/core/models/register_response.dart';
import 'package:presisawit_app/core/repository/auth_repository.dart';
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
    return await Future.delayed(Duration(milliseconds: duration));
  }

  // O=========================================================================>
  // ? Authentication Functions
  // <=========================================================================O

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

        sp.setString(AppSharedKey.currentUserRole, user.role!);
        sp.setString(AppSharedKey.currentUserId, response.user!.uid);
        sp.setString(AppSharedKey.currentUserCompanyId, user.companyId!);

        return DataSuccess(response);
      } else {
        return const DataError('Terjadi Kesalahan Server');
      }
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        debugPrint('( Register User Exception )\n${e.message}');
      }
      switch (e.code) {
        case 'weak-password':
          throw const DataError('Password terlalu Lemah');
        case 'email-already-in-use':
          throw DataError('Email ${user.email} telah digunakan');
        default:
          throw DataError(e.message.toString());
      }
    }
  }

  // O=========================================================================>
  // ? Sign in User
  // <=========================================================================O

  Future<DataState> loginUser(LoginCredentials user) async {
    try {
      final response = await firebaseAuth.signInWithEmailAndPassword(
          email: user.email, password: user.password);
      if (response.user?.email != null) {
        return DataSuccess(response);
      } else {
        return const DataError("Terjadi Kesalahan Server");
      }
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        debugPrint('( Sign In User Exception )\n${e.message}');
      }
      switch (e.code) {
        case 'user-not-found':
          throw const DataError('Pengguna tidak Terdaftar');
        case 'wrong-password':
          throw const DataError('Password salah!');
        case 'invalid-email':
          throw const DataError('Isi Format Email dengan Benar!');
        default:
          throw DataError(e.message.toString());
      }
    }
  }
}

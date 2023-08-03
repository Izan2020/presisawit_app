import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import 'package:presisawit_app/core/models/login_credentials.dart';
import 'package:presisawit_app/core/models/register_response.dart';
import 'package:presisawit_app/core/models/register_credentials.dart';

class AuthRepository {
  final firebaseAuth = FirebaseAuth.instance;
  final usersCollection = FirebaseFirestore.instance.collection("users");
  final companyCollection = FirebaseFirestore.instance.collection("company");

  // O=========================================================================>
  // ? Additional Functions
  // <=========================================================================O

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

  Future<AuthResponse> registerUser(RegisterCredentials user) async {
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

        return Success();
      } else {
        return Error(message: 'Terjadi Kesalahan Server');
      }
    } on FirebaseAuthException catch (e) {
      debugPrint('( Register User Exception )\n${e.message}');
      throw Error(message: e.message ?? "Unknown Error Occured");
    }
  }

  // O=========================================================================>
  // ? Sign in User
  // <=========================================================================O

  Future<AuthResponse> loginUser(LoginCredentials user) async {
    try {
      final response = await firebaseAuth.signInWithEmailAndPassword(
          email: user.email, password: user.password);
      if (response.credential != null) {
        return Success();
      } else {
        return Error(message: "Terjadi Kesalahan Server");
      }
    } on FirebaseAuthException catch (e) {
      debugPrint('( Sign In User Exception )\n${e.message}');
      throw Error(message: e.message ?? "Unknown Error Occured");
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:presisawit_app/data/models/company_detail_response.dart';
import 'package:presisawit_app/data/models/company_validate.dart';
import 'package:presisawit_app/data/models/credential_preferences.dart';

import 'package:presisawit_app/data/models/field_response.dart';

import 'package:presisawit_app/domain/entities/login.dart';
import 'package:presisawit_app/domain/entities/register.dart';

abstract class RemoteDataSource {
  Future<CompanyValidateResponse> validateCompanyData(String companyId);
  Future<CompanyDetailResponse> getCompanyDetails(String companyId);
  Future<bool> registerUser(Register user);
  Future<CredentialPreferences> loginUser(Login user);
  Future<bool> isLoggedIn();
  Future<List<FieldResponse>> getListOfFields(String companyId);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  RemoteDataSourceImpl({required this.firebaseAuth, required this.firestore});

  @override
  Future<CompanyValidateResponse> validateCompanyData(String companyId) async {
    final snapshot = firestore
        .collection('company')
        .where("token", isEqualTo: companyId)
        .withConverter(
            fromFirestore: CompanyValidateResponse.fromFirestore,
            toFirestore: (CompanyValidateResponse company, _) =>
                company.toFireStore());
    final querySnapshot = await snapshot.get();
    final document = querySnapshot.docs.first;
    final company = document.data();
    return company;
  }

  @override
  Future<CompanyDetailResponse> getCompanyDetails(String companyId) async {
    final snapshot = firestore
        .collection('fields')
        .doc(companyId)
        .withConverter(
            fromFirestore: CompanyDetailResponse.fromFirestore,
            toFirestore: (CompanyDetailResponse cd, _) => cd.toFireStore());
    final docSnap = await snapshot.get();
    final companyDetail = docSnap.data();
    return companyDetail!;
  }

  @override
  Future<List<FieldResponse>> getListOfFields(String companyId) async {
    final snapshot = firestore
        .collection('fields')
        .where("companyId", isEqualTo: companyId)
        .withConverter(
            fromFirestore: FieldResponse.fromFirestore,
            toFirestore: (FieldResponse field, _) => field.toFireStore());
    final docSnap = await snapshot.get();
    final docs = docSnap.docs;
    final fields = docs.map((doc) => doc.data()).toList();
    return fields;
  }

  @override
  Future<bool> isLoggedIn() async {
    final auth = await firebaseAuth.authStateChanges().first;
    return auth?.uid != null;
  }

  @override
  Future<bool> registerUser(Register user) async {
    final response = await firebaseAuth.createUserWithEmailAndPassword(
        email: user.email, password: user.password);
    if (response.user?.email != null) {
      firestore.collection('users').doc(response.user?.uid).set({
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
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<CredentialPreferences> loginUser(Login user) async {
    final response = await firebaseAuth.signInWithEmailAndPassword(
        email: user.email, password: user.password);
    if (response.user?.email != null) {
      final credentialResponse = firestore
          .collection('users')
          .doc(response.user?.uid)
          .withConverter(
              fromFirestore: CredentialPreferences.fromFirestore,
              toFirestore: (CredentialPreferences creds, _) =>
                  creds.toFirestore());
      final docSnap = await credentialResponse.get();
      final data = docSnap.data();
      return data!;
    } else {
      throw FirebaseException(plugin: 'Terjadi Kesalahan Server');
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/foundation.dart';
import 'package:presisawit_app/core/models/company_response.dart';
import 'package:presisawit_app/core/models/register_response.dart';
import 'package:presisawit_app/core/repository/firebase_repository.dart';

class FirebaseRepositoryImpl implements FirebaseRepository {
  final companyDb = FirebaseFirestore.instance.collection('company');

  Future<void> _delay(int duration) async {
    return await Future.delayed(Duration(milliseconds: duration));
  }

  // O=========================================================================>
  // ? Validate Company Availability
  // <=========================================================================O

  @override
  Future<DataState<CompanyValidate?>> getCompanyData(String companyId) async {
    try {
      await _delay(1500);
      final snapshot = companyDb.doc(companyId).withConverter(
          fromFirestore: CompanyValidate.fromFirestore,
          toFirestore: (CompanyValidate company, _) => company.toFireStore());
      final docSnap = await snapshot.get();
      final company = docSnap.data();
      if (company != null) {
        return DataSuccess(company);
      } else {
        return const DataError('Terjadi Kesalahan Server');
      }
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        debugPrint('( Validate Company Availability Exception )\n${e.message}');
      }
      throw const DataError('Periksa Koneksi Anda');
    }
  }
}

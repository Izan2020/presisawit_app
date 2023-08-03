import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:presisawit_app/core/models/company_response.dart';

class FirebaseRepository {
  final companyDb = FirebaseFirestore.instance.collection('company');

  Future<void> _delay(int duration) async {
    return await Future.delayed(Duration(milliseconds: duration));
  }

  // O=========================================================================>
  // ? Validate Company Availability
  // <=========================================================================O

  Future<CompanyValidate?> getCompanyData(String companyId) async {
    try {
      await _delay(1500);
      final snapshot = companyDb.doc(companyId).withConverter(
          fromFirestore: CompanyValidate.fromFirestore,
          toFirestore: (CompanyValidate company, _) => company.toFireStore());
      final docSnap = await snapshot.get();
      final company = docSnap.data();
      if (company != null) {
        return company;
      }
    } on FirebaseException catch (e) {
      debugPrint('( Validate Company Availability Exception )\n${e.message}');
      throw 'Periksa Koneksi Anda';
    }
    return null;
  }
}

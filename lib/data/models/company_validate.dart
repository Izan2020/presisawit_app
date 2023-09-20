import 'package:cloud_firestore/cloud_firestore.dart';

class CompanyValidateResponse {
  final String? name;
  final String? companyId;
  CompanyValidateResponse({
    this.name,
    this.companyId,
  });

  factory CompanyValidateResponse.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();
    return CompanyValidateResponse(
      name: data?['name'],
      companyId: data?['companyId'],
    );
  }

  Map<String, dynamic> toFireStore() {
    return {
      "name": name ?? "",
      "companyId": companyId ?? "",
    };
  }
}

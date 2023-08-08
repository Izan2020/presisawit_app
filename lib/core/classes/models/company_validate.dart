import 'package:cloud_firestore/cloud_firestore.dart';

class CompanyValidate {
  final String? name;
  final String? companyId;
  CompanyValidate({
    this.name,
    this.companyId,
  });

  factory CompanyValidate.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();
    return CompanyValidate(
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

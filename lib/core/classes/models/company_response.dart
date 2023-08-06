import 'package:cloud_firestore/cloud_firestore.dart';

class CompanyValidate {
  final String? name;
  CompanyValidate({
    this.name,
  });

  factory CompanyValidate.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();
    return CompanyValidate(
      name: data?['name'],
    );
  }

  Map<String, dynamic> toFireStore() {
    return {
      "name": name ?? "",
    };
  }
}

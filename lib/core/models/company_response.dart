import 'package:cloud_firestore/cloud_firestore.dart';

abstract class CompanyResponse {}

class Error extends CompanyResponse {
  final String message;

  Error({required this.message});
}

class CompanyValidate extends CompanyResponse {
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

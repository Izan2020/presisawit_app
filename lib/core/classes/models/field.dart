import 'package:cloud_firestore/cloud_firestore.dart';

class Field {
  final String? code;
  final String? companyId;
  final String? createdAt;
  final String? description;
  final String? fieldId;
  final String? name;
  final String? responsibleId;

  Field({
    this.code,
    this.companyId,
    this.createdAt,
    this.description,
    this.fieldId,
    this.name,
    this.responsibleId,
  });

  factory Field.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();
    return Field(
      code: data?['code'],
      companyId: data?['companyId'],
      createdAt: data?['createdAt'],
      description: data?['description'],
      fieldId: data?['fieldId'],
      name: data?['name'],
      responsibleId: data?['responsibleId'],
    );
  }

  Map<String, dynamic> toFireStore() {
    return {
      "code": code ?? "",
      "companyId": companyId ?? "",
      "createdAt": createdAt ?? "",
      "description": description ?? "",
      "fieldId": fieldId ?? "",
      "name": name ?? "",
      "responsibleId": responsibleId ?? "",
    };
  }
}

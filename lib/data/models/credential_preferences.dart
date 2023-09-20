// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class CredentialPreferences {
  String? userName;
  String? userId;
  String? companyId;
  String? fieldId;
  String? role;
  CredentialPreferences({
    this.userName,
    this.userId,
    this.companyId,
    this.fieldId,
    this.role,
  });

  CredentialPreferences copyWith({
    String? userName,
    String? userId,
    String? companyId,
    String? fieldId,
    String? role,
  }) {
    return CredentialPreferences(
      userName: userName ?? this.userName,
      userId: userId ?? this.userId,
      companyId: companyId ?? this.companyId,
      fieldId: fieldId ?? this.fieldId,
      role: role ?? this.role,
    );
  }

  factory CredentialPreferences.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();
    return CredentialPreferences(
      userName: data?['name'],
      userId: data?['id'],
      companyId: data?['companyId'],
      fieldId: data?['fieldId'],
      role: data?['role'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': userName,
      'userId': userId,
      'companyId': companyId,
      'fieldId': fieldId,
      'role': role,
    };
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userName': userName,
      'id': userId,
      'companyId': companyId,
      'fieldId': fieldId,
      'role': role,
    };
  }

  factory CredentialPreferences.fromMap(Map<String, dynamic> map) {
    return CredentialPreferences(
      userName: map['userName'] != null ? map['userName'] as String : null,
      userId: map['userId'] != null ? map['userId'] as String : null,
      companyId: map['companyId'] != null ? map['companyId'] as String : null,
      fieldId: map['fieldId'] != null ? map['fieldId'] as String : null,
      role: map['role'] != null ? map['role'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CredentialPreferences.fromJson(String source) =>
      CredentialPreferences.fromMap(
          json.decode(source) as Map<String, dynamic>);
}

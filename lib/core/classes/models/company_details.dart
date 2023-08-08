import 'package:cloud_firestore/cloud_firestore.dart';

class CompanyDetail {
  final String? name;
  final String? address;
  final String? description;
  final String? email;
  final String? latitude;
  final String? longitude;
  final String? profilePicture;
  final String? token;

  CompanyDetail({
    this.name,
    this.address,
    this.description,
    this.email,
    this.latitude,
    this.longitude,
    this.profilePicture,
    this.token,
  });

  factory CompanyDetail.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();
    return CompanyDetail(
      name: data?['name'],
      address: data?['address'],
      description: data?['description'],
      email: data?['email'],
      latitude: data?['latitude'],
      longitude: data?['longitude'],
      profilePicture: data?['profilePicture'],
      token: data?['token'],
    );
  }

  Map<String, dynamic> toFireStore() {
    return {
      "name": name ?? "",
      "address": address ?? "",
      "description": description ?? "",
      "email": email ?? "",
      "latitude": latitude ?? "",
      "longitude": longitude ?? "",
      "profilePicture": profilePicture ?? "",
      "token": token ?? "",
    };
  }
}

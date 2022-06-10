import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class StaffModel {
  StaffModel({
    required this.uid,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.displayName,
    required this.role,
    required this.category,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.pictures,
  });

  final String uid;
  final String email;
  final String firstName;
  final String lastName;
  final String phone;
  final String displayName;
  final String role;
  final String category;
  final int pictures;
  final String status;
  final Timestamp createdAt;
  final Timestamp updatedAt;

  factory StaffModel.fromRawJson(String str) =>
      StaffModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StaffModel.fromJson(Map<String, dynamic> json) => StaffModel(
        uid: json["uid"],
        email: json["email"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        phone: json["phone"],
        displayName: json["displayName"],
        role: json["role"],
        category: json["category"],
        pictures: json['pictures'],
        status: json["status"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
        "phone": phone,
        "displayName": displayName,
        "role": role,
        "category": category,
        "status": status,
        "pictures": pictures,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
      };
}

class StaffAtedAt {
  StaffAtedAt();

  factory StaffAtedAt.fromRawJson(String str) =>
      StaffAtedAt.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StaffAtedAt.fromJson(Map<String, dynamic> json) => StaffAtedAt();

  Map<String, dynamic> toJson() => {};
}

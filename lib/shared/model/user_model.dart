import 'dart:convert';

class UserModel {
  UserModel({
    required this.uid,
    required this.email,
    required this.phone,
    required this.displayName,
    required this.firstName,
    required this.lastName,
    required this.role,
    required this.category,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  final String uid;
  final String email;
  final String phone;
  final String displayName;
  final String firstName;
  final String lastName;
  final String role;
  final String category;
  final String status;
  final UserAtedAt createdAt;
  final UserAtedAt updatedAt;

  factory UserModel.fromRawJson(String str) =>
      UserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        uid: json["uid"],
        email: json["email"],
        phone: json["phone"],
        displayName: json["displayName"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        role: json["role"],
        category: json["category"],
        status: json["status"],
        createdAt: UserAtedAt.fromJson(json["createdAt"]),
        updatedAt: UserAtedAt.fromJson(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "email": email,
        "phone": phone,
        "displayName": displayName,
        "firstName": firstName,
        "lastName": lastName,
        "role": role,
        "category": category,
        "status": status,
        "createdAt": createdAt.toJson(),
        "updatedAt": updatedAt.toJson(),
      };
}

class UserAtedAt {
  UserAtedAt();

  factory UserAtedAt.fromRawJson(String str) =>
      UserAtedAt.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserAtedAt.fromJson(Map<String, dynamic> json) => UserAtedAt();

  Map<String, dynamic> toJson() => {};
}

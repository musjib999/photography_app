import 'dart:convert';

class ConnectionModel {
  ConnectionModel({
    required this.email,
    required this.displayName,
    required this.phone,
    required this.firstName,
    required this.lastName,
    required this.connection,
    required this.contractPeriod,
    required this.amountPaid,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  final String email;
  final String displayName;
  final String phone;
  final String firstName;
  final String lastName;
  final String connection;
  final String contractPeriod;
  final int amountPaid;
  final String status;
  final AtedAt createdAt;
  final AtedAt updatedAt;

  factory ConnectionModel.fromRawJson(String str) =>
      ConnectionModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ConnectionModel.fromJson(Map<String, dynamic> json) =>
      ConnectionModel(
        email: json["email"],
        displayName: json["displayName"],
        phone: json["phone"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        connection: json["connection"],
        contractPeriod: json["contractPeriod"],
        amountPaid: json["amountPaid"],
        status: json["status"],
        createdAt: AtedAt.fromJson(json["createdAt"]),
        updatedAt: AtedAt.fromJson(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "displayName": displayName,
        "phone": phone,
        "firstName": firstName,
        "lastName": lastName,
        "connection": connection,
        "contractPeriod": contractPeriod,
        "amountPaid": amountPaid,
        "status": status,
        "createdAt": createdAt.toJson(),
        "updatedAt": updatedAt.toJson(),
      };
}

class AtedAt {
  AtedAt();

  factory AtedAt.fromRawJson(String str) => AtedAt.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AtedAt.fromJson(Map<String, dynamic> json) => AtedAt();

  Map<String, dynamic> toJson() => {};
}

import 'dart:convert';

class MakeupModel {
  MakeupModel({
    required this.pendingBalance,
    required this.managerId,
    required this.userId,
    required this.amountPaid,
    required this.numberOfFaces,
    required this.price,
    required this.makeupType,
    required this.staffId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  final int pendingBalance;
  final String managerId;
  final String userId;
  final int amountPaid;
  final int numberOfFaces;
  final int price;
  final String makeupType;
  final String staffId;
  final String status;
  final MakeupAtedAt createdAt;
  final MakeupAtedAt updatedAt;

  factory MakeupModel.fromRawJson(String str) =>
      MakeupModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MakeupModel.fromJson(Map<String, dynamic> json) => MakeupModel(
        pendingBalance: json["pendingBalance"],
        managerId: json["managerId"],
        userId: json["userId"],
        amountPaid: json["amountPaid"],
        numberOfFaces: json["numberOfFaces"],
        price: json["price"],
        makeupType: json["makeupType"],
        staffId: json["staffId"],
        status: json["status"],
        createdAt: MakeupAtedAt.fromJson(json["createdAt"]),
        updatedAt: MakeupAtedAt.fromJson(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "pendingBalance": pendingBalance,
        "managerId": managerId,
        "userId": userId,
        "amountPaid": amountPaid,
        "numberOfFaces": numberOfFaces,
        "price": price,
        "makeupType": makeupType,
        "staffId": staffId,
        "status": status,
        "createdAt": createdAt.toJson(),
        "updatedAt": updatedAt.toJson(),
      };
}

class MakeupAtedAt {
  MakeupAtedAt({
    required this.seconds,
    required this.nanoseconds,
  });

  final int seconds;
  final int nanoseconds;

  factory MakeupAtedAt.fromRawJson(String str) =>
      MakeupAtedAt.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MakeupAtedAt.fromJson(Map<String, dynamic> json) => MakeupAtedAt(
        seconds: json["_seconds"],
        nanoseconds: json["_nanoseconds"],
      );

  Map<String, dynamic> toJson() => {
        "_seconds": seconds,
        "_nanoseconds": nanoseconds,
      };
}

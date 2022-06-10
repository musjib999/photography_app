import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class MediaModel {
  MediaModel({
    required this.pendingBalance,
    required this.quantity,
    required this.link,
    required this.managerId,
    required this.userId,
    required this.amountPaid,
    required this.category,
    required this.pictureType,
    required this.staffId,
    required this.status,
    required this.picturePrice,
    required this.createdAt,
    required this.updatedAt,
  });

  final int pendingBalance;
  final int quantity;
  final String link;
  final String managerId;
  final String userId;
  final int amountPaid;
  final String category;
  final String pictureType;
  final String staffId;
  final String status;
  final int picturePrice;
  final Timestamp createdAt;
  final Timestamp updatedAt;

  factory MediaModel.fromRawJson(String str) =>
      MediaModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MediaModel.fromJson(Map<String, dynamic> json) => MediaModel(
        pendingBalance: json["pendingBalance"],
        quantity: json["quantity"],
        link: json["link"],
        managerId: json["managerId"],
        userId: json["userId"],
        amountPaid: json["amountPaid"],
        category: json["category"],
        pictureType: json["pictureType"],
        staffId: json["staffId"],
        status: json["status"],
        picturePrice: json["picturePrice"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
      );

  Map<String, dynamic> toJson() => {
        "pendingBalance": pendingBalance,
        "quantity": quantity,
        "link": link,
        "managerId": managerId,
        "userId": userId,
        "amountPaid": amountPaid,
        "category": category,
        "pictureType": pictureType,
        "staffId": staffId,
        "status": status,
        "picturePrice": picturePrice,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
      };
}

class UpdateMediaModel {
  UpdateMediaModel({
    required this.writeTime,
  });

  final WriteTime writeTime;

  factory UpdateMediaModel.fromRawJson(String str) =>
      UpdateMediaModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UpdateMediaModel.fromJson(Map<String, dynamic> json) =>
      UpdateMediaModel(
        writeTime: WriteTime.fromJson(json["_writeTime"]),
      );

  Map<String, dynamic> toJson() => {
        "_writeTime": writeTime.toJson(),
      };
}

class WriteTime {
  WriteTime({
    required this.seconds,
    required this.nanoseconds,
  });

  final int seconds;
  final int nanoseconds;

  factory WriteTime.fromRawJson(String str) =>
      WriteTime.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory WriteTime.fromJson(Map<String, dynamic> json) => WriteTime(
        seconds: json["_seconds"],
        nanoseconds: json["_nanoseconds"],
      );

  Map<String, dynamic> toJson() => {
        "_seconds": seconds,
        "_nanoseconds": nanoseconds,
      };
}

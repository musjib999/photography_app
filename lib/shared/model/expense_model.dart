// To parse this JSON data, do
//
//     final ExpenseModel = ExpenseModelFromJson(jsonString);

import 'dart:convert';

import 'package:u_arewa_studio/shared/model/time_model.dart';

class ExpenseModel {
  ExpenseModel({
    required this.item,
    required this.cost,
    required this.quantity,
    required this.managerId,
    required this.category,
    required this.createdAt,
    required this.updatedAt,
  });

  final String item;
  final int cost;
  final int quantity;
  final String managerId;
  final String category;
  final AtedAt createdAt;
  final AtedAt updatedAt;

  factory ExpenseModel.fromRawJson(String str) =>
      ExpenseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ExpenseModel.fromJson(Map<String, dynamic> json) => ExpenseModel(
        item: json["item"],
        cost: json["cost"],
        quantity: json["quantity"],
        managerId: json["managerId"],
        category: json["category"],
        createdAt: AtedAt.fromJson(json["createdAt"]),
        updatedAt: AtedAt.fromJson(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "item": item,
        "cost": cost,
        "quantity": quantity,
        "managerId": managerId,
        "category": category,
        "createdAt": createdAt.toJson(),
        "updatedAt": updatedAt.toJson(),
      };
}

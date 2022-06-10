import 'dart:convert';

class ItemModel {
  ItemModel({
    required this.pendingBalance,
    required this.item,
    required this.quantity,
    required this.managerId,
    required this.userId,
    required this.amountPaid,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
  });

  final int pendingBalance;
  final String item;
  final int quantity;
  final String managerId;
  final String userId;
  final int amountPaid;
  final int price;
  final ItemAtedAt createdAt;
  final ItemAtedAt updatedAt;

  factory ItemModel.fromRawJson(String str) =>
      ItemModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ItemModel.fromJson(Map<String, dynamic> json) => ItemModel(
        pendingBalance: json["pendingBalance"],
        item: json["item"],
        quantity: json["quantity"],
        managerId: json["managerId"],
        userId: json["userId"],
        amountPaid: json["amountPaid"],
        price: json["price"],
        createdAt: ItemAtedAt.fromJson(json["createdAt"]),
        updatedAt: ItemAtedAt.fromJson(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "pendingBalance": pendingBalance,
        "item": item,
        "quantity": quantity,
        "managerId": managerId,
        "userId": userId,
        "amountPaid": amountPaid,
        "price": price,
        "createdAt": createdAt.toJson(),
        "updatedAt": updatedAt.toJson(),
      };
}

class ItemAtedAt {
  ItemAtedAt({
    required this.seconds,
    required this.nanoseconds,
  });

  final int seconds;
  final int nanoseconds;

  factory ItemAtedAt.fromRawJson(String str) =>
      ItemAtedAt.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ItemAtedAt.fromJson(Map<String, dynamic> json) => ItemAtedAt(
        seconds: json["_seconds"],
        nanoseconds: json["_nanoseconds"],
      );

  Map<String, dynamic> toJson() => {
        "_seconds": seconds,
        "_nanoseconds": nanoseconds,
      };
}

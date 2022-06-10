import 'dart:convert';

class AtedAt {
  AtedAt({
    required this.seconds,
    required this.nanoseconds,
  });

  final int seconds;
  final int nanoseconds;

  factory AtedAt.fromRawJson(String str) => AtedAt.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AtedAt.fromJson(Map<String, dynamic> json) => AtedAt(
        seconds: json["_seconds"],
        nanoseconds: json["_nanoseconds"],
      );

  Map<String, dynamic> toJson() => {
        "_seconds": seconds,
        "_nanoseconds": nanoseconds,
      };
}

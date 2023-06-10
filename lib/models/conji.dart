// To parse this JSON data, do
//
//     final conji = conjiFromJson(jsonString);

import 'dart:convert';

List<Conji> conjiFromJson(String str) =>
    List<Conji>.from(json.decode(str).map((x) => Conji.fromJson(x)));

String conjiToJson(List<Conji> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Conji {
  int id;
  String name;
  String reason;
  String nbrjr;
  String dateconji;
  String etat;
  String userId;
  String entrepriseId;
  DateTime createdAt;
  DateTime updatedAt;

  Conji({
    required this.id,
    required this.name,
    required this.reason,
    required this.nbrjr,
    required this.dateconji,
    required this.etat,
    required this.userId,
    required this.entrepriseId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Conji.fromJson(Map<String, dynamic> json) => Conji(
        id: json["id"],
        name: json["name"],
        reason: json["reason"],
        nbrjr: json["nbrjr"],
        dateconji: json["dateconji"],
        etat: json["etat"],
        userId: json["user_id"],
        entrepriseId: json["entreprise_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "reason": reason,
        "nbrjr": nbrjr,
        "dateconji": dateconji,
        "etat": etat,
        "user_id": userId,
        "entreprise_id": entrepriseId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

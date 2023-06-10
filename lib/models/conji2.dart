// To parse this JSON data, do
//
//     final conji2 = conji2FromJson(jsonString);

import 'dart:convert';

List<Conji2> conji2FromJson(String str) =>
    List<Conji2>.from(json.decode(str).map((x) => Conji2.fromJson(x)));

String conji2ToJson(List<Conji2> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Conji2 {
  int? id;
  String? name;
  String? reason;
  String? nbrjr;
  String? dateconji;
  String? etat;
  int? userId;
  int? entrepriseId;
  DateTime? createdAt;
  DateTime? updatedAt;

  Conji2({
    this.id,
    this.name,
    this.reason,
    this.nbrjr,
    this.dateconji,
    this.etat,
    this.userId,
    this.entrepriseId,
    this.createdAt,
    this.updatedAt,
  });

  factory Conji2.fromJson(Map<String, dynamic> json) => Conji2(
        id: json["id"],
        name: json["name"],
        reason: json["reason"],
        nbrjr: json["nbrjr"],
        dateconji: json["dateconji"],
        etat: json["etat"],
        userId: json["user_id"],
        entrepriseId: json["entreprise_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
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
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

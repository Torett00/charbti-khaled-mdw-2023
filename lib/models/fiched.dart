// To parse this JSON data, do
//
//     final fichede = fichedeFromJson(jsonString);

import 'dart:convert';

List<Fichede> fichedeFromJson(String str) =>
    List<Fichede>.from(json.decode(str).map((x) => Fichede.fromJson(x)));

String fichedeToJson(List<Fichede> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Fichede {
  int? id;
  dynamic createdAt;
  dynamic updatedAt;
  int? nombredejour;
  int? conjirestant;
  String? salaire;
  int? entrepriseId;
  int? userId;

  Fichede({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.nombredejour,
    this.conjirestant,
    this.salaire,
    this.entrepriseId,
    this.userId,
  });

  factory Fichede.fromJson(Map<String, dynamic> json) => Fichede(
        id: json["id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        nombredejour: json["nombredejour"],
        conjirestant: json["conjirestant"],
        salaire: json["salaire"],
        entrepriseId: json["entreprise_id"],
        userId: json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "nombredejour": nombredejour,
        "conjirestant": conjirestant,
        "salaire": salaire,
        "entreprise_id": entrepriseId,
        "user_id": userId,
      };
}

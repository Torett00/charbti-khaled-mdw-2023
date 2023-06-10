// To parse this JSON data, do
//
//     final pointage = pointageFromJson(jsonString);

import 'dart:convert';

List<Pointage> pointageFromJson(String str) =>
    List<Pointage>.from(json.decode(str).map((x) => Pointage.fromJson(x)));

String pointageToJson(List<Pointage> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Pointage {
  int? id;
  dynamic createdAt;
  dynamic updatedAt;
  int? nombredejour;
  int? currentjour;
  String? currentmois;
  int? conjirestant;
  int? entrepriseId;
  int? userId;

  Pointage({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.nombredejour,
    this.currentjour,
    this.currentmois,
    this.conjirestant,
    this.entrepriseId,
    this.userId,
  });

  factory Pointage.fromJson(Map<String, dynamic> json) => Pointage(
        id: json["id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        nombredejour: json["nombredejour"],
        currentjour: json["currentjour"],
        currentmois: json["currentmois"],
        conjirestant: json["conjirestant"],
        entrepriseId: json["entreprise_id"],
        userId: json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "nombredejour": nombredejour,
        "currentjour": currentjour,
        "currentmois": currentmois,
        "conjirestant": conjirestant,
        "entreprise_id": entrepriseId,
        "user_id": userId,
      };
}

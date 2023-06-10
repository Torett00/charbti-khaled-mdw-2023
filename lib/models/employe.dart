// To parse this JSON data, do
//
//     final employe = employeFromJson(jsonString);

import 'dart:convert';

List<Employe> employeFromJson(String str) =>
    List<Employe>.from(json.decode(str).map((x) => Employe.fromJson(x)));

String employeToJson(List<Employe> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Employe {
  int? id;
  dynamic createdAt;
  dynamic updatedAt;
  String? name;
  String? telephone;
  String? adresse;
  String? poste;
  String? salaire;
  int? userId;
  int? entrepriseId;

  Employe({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.telephone,
    this.adresse,
    this.poste,
    this.salaire,
    this.userId,
    this.entrepriseId,
  });

  factory Employe.fromJson(Map<String, dynamic> json) => Employe(
        id: json["id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        name: json["name"],
        telephone: json["telephone"],
        adresse: json["adresse"],
        poste: json["poste"],
        salaire: json["salaire"],
        userId: json["user_id"],
        entrepriseId: json["entreprise_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "name": name,
        "telephone": telephone,
        "adresse": adresse,
        "poste": poste,
        "salaire": salaire,
        "user_id": userId,
        "entreprise_id": entrepriseId,
      };
}

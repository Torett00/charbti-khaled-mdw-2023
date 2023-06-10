// To parse this JSON data, do
//
//     final entreprise = entrepriseFromJson(jsonString);

import 'dart:convert';

List<Entreprise> entrepriseFromJson(String str) =>
    List<Entreprise>.from(json.decode(str).map((x) => Entreprise.fromJson(x)));

String entrepriseToJson(List<Entreprise> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Entreprise {
  int id;
  String name;
  String pays;
  String telephone;
  String adresse;
  int userId;

  Entreprise({
    required this.id,
    required this.name,
    required this.pays,
    required this.telephone,
    required this.adresse,
    required this.userId,
  });

  factory Entreprise.fromJson(Map<String, dynamic> json) => Entreprise(
        id: json["id"],
        name: json["name"],
        pays: json["pays"],
        telephone: json["telephone"],
        adresse: json["adresse"],
        userId: json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "pays": pays,
        "telephone": telephone,
        "adresse": adresse,
        "user_id": userId,
      };
}

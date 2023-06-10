// To parse this JSON data, do
//
//     final ligne = ligneFromJson(jsonString);

import 'dart:convert';

List<Ligne> ligneFromJson(String str) =>
    List<Ligne>.from(json.decode(str).map((x) => Ligne.fromJson(x)));

String ligneToJson(List<Ligne> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Ligne {
  int id;
  String numero;
  String depart;
  String arrive;
  String distance;
  String prix;

  Ligne({
    required this.id,
    required this.numero,
    required this.depart,
    required this.arrive,
    required this.distance,
    required this.prix,
  });

  factory Ligne.fromJson(Map<String, dynamic> json) => Ligne(
        id: json["id"],
        numero: json["numero"],
        depart: json["depart"],
        arrive: json["arrive"],
        distance: json["distance"],
        prix: json["prix"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "numero": numero,
        "depart": depart,
        "arrive": arrive,
        "distance": distance,
        "prix": prix,
      };
}

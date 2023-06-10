// To parse this JSON data, do
//
//     final voyage = voyageFromJson(jsonString);

import 'dart:convert';

List<Voyage> voyageFromJson(String str) =>
    List<Voyage>.from(json.decode(str).map((x) => Voyage.fromJson(x)));

String voyageToJson(List<Voyage> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Voyage {
  int id;
  String temps;
  int lignesId;
  int entrepriseId;

  Voyage({
    required this.id,
    required this.temps,
    required this.lignesId,
    required this.entrepriseId,
  });

  factory Voyage.fromJson(Map<String, dynamic> json) => Voyage(
        id: json["id"],
        temps: json["temps"],
        lignesId: json["lignes_id"],
        entrepriseId: json["entreprise_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "temps": temps,
        "lignes_id": lignesId,
        "entreprise_id": entrepriseId,
      };
}

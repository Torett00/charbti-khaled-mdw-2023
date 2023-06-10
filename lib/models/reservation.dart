// To parse this JSON data, do
//
//     final reservation = reservationFromJson(jsonString);

import 'dart:convert';

List<Reservation> reservationFromJson(String str) => List<Reservation>.from(
    json.decode(str).map((x) => Reservation.fromJson(x)));

String reservationToJson(List<Reservation> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Reservation {
  int id;
  DateTime voyagedate;
  int nbrptotal;
  int nbrpoccupe;
  String etat;
  int voyageId;
  int entrepriseId;

  Reservation({
    required this.id,
    required this.voyagedate,
    required this.nbrptotal,
    required this.nbrpoccupe,
    required this.etat,
    required this.voyageId,
    required this.entrepriseId,
  });

  factory Reservation.fromJson(Map<String, dynamic> json) => Reservation(
        id: json["id"],
        voyagedate: DateTime.parse(json["voyagedate"]),
        nbrptotal: json["nbrptotal"],
        nbrpoccupe: json["nbrpoccupe"],
        etat: json["etat"],
        voyageId: json["voyage_id"],
        entrepriseId: json["entreprise_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "voyagedate":
            "${voyagedate!.year.toString().padLeft(4, '0')}-${voyagedate!.month.toString().padLeft(2, '0')}-${voyagedate!.day.toString().padLeft(2, '0')}",
        "nbrptotal": nbrptotal,
        "nbrpoccupe": nbrpoccupe,
        "etat": etat,
        "voyage_id": voyageId,
        "entreprise_id": entrepriseId,
      };
}

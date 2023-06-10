// To parse this JSON data, do
//
//     final user2 = user2FromJson(jsonString);

import 'dart:convert';

User2 user2FromJson(String str) => User2.fromJson(json.decode(str));

String user2ToJson(User2 data) => json.encode(data.toJson());

class User2 {
  Userr userr;
  String token;

  User2({
    required this.userr,
    required this.token,
  });

  factory User2.fromJson(Map<String, dynamic> json) => User2(
        userr: Userr.fromJson(json["userr"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "userr": userr.toJson(),
        "token": token,
      };
}

class Userr {
  int id;
  String name;
  String email;
  dynamic emailVerifiedAt;
  DateTime createdAt;
  DateTime updatedAt;
  int roleId;
  Role role;

  Userr({
    required this.id,
    required this.name,
    required this.email,
    this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.roleId,
    required this.role,
  });

  factory Userr.fromJson(Map<String, dynamic> json) => Userr(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        roleId: json["role_id"],
        role: Role.fromJson(json["role"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "role_id": roleId,
        "role": role.toJson(),
      };
}

class Role {
  int id;
  String name;
  dynamic createdAt;
  dynamic updatedAt;

  Role({
    required this.id,
    required this.name,
    this.createdAt,
    this.updatedAt,
  });

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        id: json["id"],
        name: json["name"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

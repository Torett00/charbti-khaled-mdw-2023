// To parse this JSON data, do
//
//     final user3 = user3FromJson(jsonString);

import 'dart:convert';

User3 user3FromJson(String str) => User3.fromJson(json.decode(str));

String user3ToJson(User3 data) => json.encode(data.toJson());

class User3 {
  Userr user;
  String token;

  User3({
    required this.user,
    required this.token,
  });

  factory User3.fromJson(Map<String, dynamic> json) => User3(
        user: Userr.fromJson(json["user"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
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

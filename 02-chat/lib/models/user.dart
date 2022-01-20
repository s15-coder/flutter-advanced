// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    required this.name,
    required this.email,
    required this.uuid,
    this.online = false,
  });

  String name;
  String email;
  String uuid;
  bool online;

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"],
        email: json["email"],
        uuid: json["uuid"],
        online: json.containsKey("online") ? json["online"] : false,
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "uuid": uuid,
        "online": online,
      };
}



import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String? userName;
  String? password;
  String? email;
  String? profile;

  UserModel({
    this.userName,
    this.password,
    this.email,
    this.profile
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    userName: json["user_name"],
    password: json["password"],
    email: json["email"],
    profile: json["profile"]
  );

  Map<String, dynamic> toJson() => {
    "user_name": userName,
    "password": password,
    "email": email,
    "profile":profile
  };
}

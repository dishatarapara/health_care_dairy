// To parse this JSON data, do
//
//     final login = loginFromJson(jsonString);

import 'dart:convert';

Login loginFromJson(String str) => Login.fromJson(json.decode(str));

String loginToJson(Login data) => json.encode(data.toJson());

class Login {
  String message;
  int messageCode;
  String status;
  List<UserLogin> data;

  Login({
    required this.message,
    required this.messageCode,
    required this.status,
    required this.data,
  });

  factory Login.fromJson(Map<String, dynamic> json) => Login(
    message: json["Message"],
    messageCode: json["MessageCode"],
    status: json["Status"],
    data: List<UserLogin>.from(json["Data"].map((x) => UserLogin.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Message": message,
    "MessageCode": messageCode,
    "Status": status,
    "Data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class UserLogin {
  int id;
  String name;
  String email;
  dynamic passWord;

  UserLogin({
    required this.id,
    required this.name,
    required this.email,
    required this.passWord,
  });

  factory UserLogin.fromJson(Map<String, dynamic> json) => UserLogin(
    id: json["Id"],
    name: json["Name"],
    email: json["Email"],
    passWord: json["PassWord"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "Name": name,
    "Email": email,
    "PassWord": passWord,
  };
}

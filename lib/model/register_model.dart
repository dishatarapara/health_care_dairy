// To parse this JSON data, do
//
//     final register = registerFromJson(jsonString);

import 'dart:convert';

Register registerFromJson(String str) => Register.fromJson(json.decode(str));

String registerToJson(Register data) => json.encode(data.toJson());

class Register {
  String message;
  int messageCode;
  String status;
  dynamic data;

  Register({
    required this.message,
    required this.messageCode,
    required this.status,
    required this.data,
  });

  factory Register.fromJson(Map<String, dynamic> json) => Register(
    message: json["Message"],
    messageCode: json["MessageCode"],
    status: json["Status"],
    data: json["Data"],
  );

  Map<String, dynamic> toJson() => {
    "Message": message,
    "MessageCode": messageCode,
    "Status": status,
    "Data": data,
  };
}

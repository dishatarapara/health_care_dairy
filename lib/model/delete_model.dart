// To parse this JSON data, do
//
//     final delete = deleteFromJson(jsonString);

import 'dart:convert';

Delete deleteFromJson(String str) => Delete.fromJson(json.decode(str));

String deleteToJson(Delete data) => json.encode(data.toJson());

class Delete {
  String message;
  int messageCode;
  String status;
  String data;

  Delete({
    required this.message,
    required this.messageCode,
    required this.status,
    required this.data,
  });

  factory Delete.fromJson(Map<String, dynamic> json) => Delete(
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

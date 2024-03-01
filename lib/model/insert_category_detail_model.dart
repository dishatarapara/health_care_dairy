// To parse this JSON data, do
//
//     final updateCategoryDetail = updateCategoryDetailFromJson(jsonString);

import 'dart:convert';

InsertCategoryDetail insertCategoryDetailFromJson(String str) => InsertCategoryDetail.fromJson(json.decode(str));

String insertCategoryDetailToJson(InsertCategoryDetail data) => json.encode(data.toJson());

class InsertCategoryDetail {
  String message;
  int messageCode;
  String status;
  String data;

  InsertCategoryDetail({
    required this.message,
    required this.messageCode,
    required this.status,
    required this.data,
  });

  factory InsertCategoryDetail.fromJson(Map<String, dynamic> json) => InsertCategoryDetail(
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
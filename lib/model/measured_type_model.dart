// To parse this JSON data, do
//
//     final measuredType = measuredTypeFromJson(jsonString);

import 'dart:convert';

MeasuredType measuredTypeFromJson(String str) => MeasuredType.fromJson(json.decode(str));

String measuredTypeToJson(MeasuredType data) => json.encode(data.toJson());

class MeasuredType {
  String message;
  int messageCode;
  String status;
  List<MeasuredTypesList> data;

  MeasuredType({
    required this.message,
    required this.messageCode,
    required this.status,
    required this.data,
  });

  factory MeasuredType.fromJson(Map<String, dynamic> json) => MeasuredType(
    message: json["Message"],
    messageCode: json["MessageCode"],
    status: json["Status"],
    data: List<MeasuredTypesList>.from(json["Data"].map((x) => MeasuredTypesList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Message": message,
    "MessageCode": messageCode,
    "Status": status,
    "Data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class MeasuredTypesList {
  int id;
  String name;

  MeasuredTypesList({
    required this.id,
    required this.name,
  });

  factory MeasuredTypesList.fromJson(Map<String, dynamic> json) => MeasuredTypesList(
    id: json["Id"],
    name: json["Name"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "Name": name,
  };
}

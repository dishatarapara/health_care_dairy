

import 'dart:convert';

HealthCareDetail healthCareDetailFromJson(String str) => HealthCareDetail.fromJson(json.decode(str));

String healthCareDetailToJson(HealthCareDetail data) => json.encode(data.toJson());

class HealthCareDetail {
  String message;
  int messageCode;
  String status;
  List<Data> data;

  HealthCareDetail({
    required this.message,
    required this.messageCode,
    required this.status,
    required this.data,
  });

  factory HealthCareDetail.fromJson(Map<String, dynamic> json) => HealthCareDetail(
    message: json["Message"],
    messageCode: json["MessageCode"],
    status: json["Status"],
    data: List<Data>.from(json["Data"].map((x) => Data.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Message": message,
    "MessageCode": messageCode,
    "Status": status,
    "Data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Data {
  int id;
  String name;
  String icon;

  Data({
    required this.id,
    required this.name,
    required this.icon,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["Id"],
    name: json["Name"],
    icon: json["Icon"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "Name": name,
    "Icon": icon,
  };
}

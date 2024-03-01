// To parse this JSON data, do
//
//     final selectedData = selectedDataFromJson(jsonString);

import 'dart:convert';

SelectedData selectedDataFromJson(String str) => SelectedData.fromJson(json.decode(str));

String selectedDataToJson(SelectedData data) => json.encode(data.toJson());

class SelectedData {
  String message;
  int messageCode;
  String status;
  List<SelectData> data;

  SelectedData({
    required this.message,
    required this.messageCode,
    required this.status,
    required this.data,
  });

  factory SelectedData.fromJson(Map<String, dynamic> json) => SelectedData(
    message: json["Message"],
    messageCode: json["MessageCode"],
    status: json["Status"],
    data: List<SelectData>.from(json["Data"].map((x) => SelectData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Message": message,
    "MessageCode": messageCode,
    "Status": status,
    "Data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class SelectData {
  int id;
  String name;

  SelectData({
    required this.id,
    required this.name,
  });

  factory SelectData.fromJson(Map<String, dynamic> json) => SelectData(
    id: json["Id"],
    name: json["Name"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "Name": name,
  };
}

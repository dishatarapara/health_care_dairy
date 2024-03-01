// To parse this JSON data, do
//
//     final measurementType = measurementTypeFromJson(jsonString);

import 'dart:convert';

MeasurementType measurementTypeFromJson(String str) => MeasurementType.fromJson(json.decode(str));

String measurementTypeToJson(MeasurementType data) => json.encode(data.toJson());

class MeasurementType {
  String message;
  int messageCode;
  String status;
  List<MeasurementTypesList> data;

  MeasurementType({
    required this.message,
    required this.messageCode,
    required this.status,
    required this.data,
  });

  factory MeasurementType.fromJson(Map<String, dynamic> json) => MeasurementType(
    message: json["Message"],
    messageCode: json["MessageCode"],
    status: json["Status"],
    data: List<MeasurementTypesList>.from(json["Data"].map((x) => MeasurementTypesList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Message": message,
    "MessageCode": messageCode,
    "Status": status,
    "Data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class MeasurementTypesList {
  int id;
  String name;

  MeasurementTypesList({
    required this.id,
    required this.name,
  });

  factory MeasurementTypesList.fromJson(Map<String, dynamic> json) => MeasurementTypesList(
    id: json["Id"],
    name: json["Name"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "Name": name,
  };
}

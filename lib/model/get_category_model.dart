
// To parse this JSON data, do
//
//     final category = categoryFromJson(jsonString);

import 'dart:convert';

Category categoryFromJson(String str) => Category.fromJson(json.decode(str));

String categoryToJson(Category data) => json.encode(data.toJson());

class Category {
  String message;
  int messageCode;
  String status;
  List<CategoryList> data;

  Category({
    required this.message,
    required this.messageCode,
    required this.status,
    required this.data,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    message: json["Message"],
    messageCode: json["MessageCode"],
    status: json["Status"],
    data: List<CategoryList>.from(json["Data"].map((x) => CategoryList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Message": message,
    "MessageCode": messageCode,
    "Status": status,
    "Data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class CategoryList {
  int id;
  dynamic categoryName;
  String dateTime;
  double bloodGlucose;
  dynamic measuredTypeName;
  int systolicPressure;
  int diastolicPressure;
  int pulseRate;
  bool hand;
  double bodyTemperature;
  int bloodOxygenSaturation;
  dynamic measurementTypeName;
  double averageSugarConcentration;
  double weight;
  String medicationName;
  dynamic selectDataTypeName;
  int dosage;
  int timesAndDay;
  String color;
  String comments;
  String unit;
  String? time;

  CategoryList({
    required this.id,
    required this.categoryName,
    required this.dateTime,
    required this.bloodGlucose,
    required this.measuredTypeName,
    required this.systolicPressure,
    required this.diastolicPressure,
    required this.pulseRate,
    required this.hand,
    required this.bodyTemperature,
    required this.bloodOxygenSaturation,
    required this.measurementTypeName,
    required this.averageSugarConcentration,
    required this.weight,
    required this.medicationName,
    required this.selectDataTypeName,
    required this.dosage,
    required this.timesAndDay,
    required this.color,
    required this.comments,
    required this.unit,
    required this.time,
  });

  factory CategoryList.fromJson(Map<String, dynamic> json) => CategoryList(
    id: json["Id"],
    categoryName: json["CategoryName"],
    dateTime: json["DateTime"],
    bloodGlucose: json["BloodGlucose"],
    measuredTypeName: json["MeasuredTypeName"],
    systolicPressure: json["SystolicPressure"],
    diastolicPressure: json["DiastolicPressure"],
    pulseRate: json["PulseRate"],
    hand: json["Hand"],
    bodyTemperature: json["BodyTemperature"],
    bloodOxygenSaturation: json["BloodOxygenSaturation"],
    measurementTypeName: json["MeasurementTypeName"],
    averageSugarConcentration: json["AverageSugarConcentration"],
    weight: json["Weight"],
    medicationName: json["MedicationName"],
    selectDataTypeName: json["SelectDataTypeName"],
    dosage: json["Dosage"],
    timesAndDay: json["TimesAndDay"],
    color: json["Color"],
    comments: json["Comments"],
    unit: json["Unit"],
    time: json["Time"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "CategoryName": categoryName,
    "DateTime": dateTime,
    "BloodGlucose": bloodGlucose,
    "MeasuredTypeName": measuredTypeName,
    "SystolicPressure": systolicPressure,
    "DiastolicPressure": diastolicPressure,
    "PulseRate": pulseRate,
    "Hand": hand,
    "BodyTemperature": bodyTemperature,
    "BloodOxygenSaturation": bloodOxygenSaturation,
    "MeasurementTypeName": measurementTypeName,
    "AverageSugarConcentration": averageSugarConcentration,
    "Weight": weight,
    "MedicationName": medicationName,
    "SelectDataTypeName": selectDataTypeName,
    "Dosage": dosage,
    "TimesAndDay": timesAndDay,
    "Color": color,
    "Comments": comments,
    "Unit": unit,
    "Time": time,
  };
}



// // To parse this JSON data, do
// //
// //     final category = categoryFromJson(jsonString);
//
// import 'dart:convert';
//
// Category categoryFromJson(String str) => Category.fromJson(json.decode(str));
//
// String categoryToJson(Category data) => json.encode(data.toJson());
//
// class Category {
//   String message;
//   int messageCode;
//   String status;
//   List<CategoryList> data;
//
//   Category({
//     required this.message,
//     required this.messageCode,
//     required this.status,
//     required this.data,
//   });
//
//   factory Category.fromJson(Map<String, dynamic> json) => Category(
//     message: json["Message"],
//     messageCode: json["MessageCode"],
//     status: json["Status"],
//     data: List<CategoryList>.from(json["Data"].map((x) => CategoryList.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "Message": message,
//     "MessageCode": messageCode,
//     "Status": status,
//     "Data": List<dynamic>.from(data.map((x) => x.toJson())),
//   };
// }
//
// class CategoryList {
//   int id;
//   dynamic categoryName;
//   String dateTime;
//   double bloodGlucose;
//   dynamic measuredTypeName;
//   int systolicPressure;
//   int diastolicPressure;
//   int pulseRate;
//   bool hand;
//   double bodyTemperature;
//   int bloodOxygenSaturation;
//   dynamic measurementTypeName;
//   double averageSugarConcentration;
//   double weight;
//   String medicationName;
//   dynamic selectDataTypeName;
//   int dosage;
//   int timesAndDay;
//   String color;
//   String comments;
//   dynamic unit;
//   String? time;
//
//   CategoryList({
//     required this.id,
//     required this.categoryName,
//     required this.dateTime,
//     required this.bloodGlucose,
//     required this.measuredTypeName,
//     required this.systolicPressure,
//     required this.diastolicPressure,
//     required this.pulseRate,
//     required this.hand,
//     required this.bodyTemperature,
//     required this.bloodOxygenSaturation,
//     required this.measurementTypeName,
//     required this.averageSugarConcentration,
//     required this.weight,
//     required this.medicationName,
//     required this.selectDataTypeName,
//     required this.dosage,
//     required this.timesAndDay,
//     required this.color,
//     required this.comments,
//     required this.unit,
//     required this.time,
//   });
//
//   factory CategoryList.fromJson(Map<String, dynamic> json) => CategoryList(
//     id: json["Id"],
//     categoryName: json["CategoryName"],
//     dateTime: json["DateTime"],
//     bloodGlucose: json["BloodGlucose"],
//     measuredTypeName: json["MeasuredTypeName"],
//     systolicPressure: json["SystolicPressure"],
//     diastolicPressure: json["DiastolicPressure"],
//     pulseRate: json["PulseRate"],
//     hand: json["Hand"],
//     bodyTemperature: json["BodyTemperature"],
//     bloodOxygenSaturation: json["BloodOxygenSaturation"],
//     measurementTypeName: json["MeasurementTypeName"],
//     averageSugarConcentration: json["AverageSugarConcentration"],
//     weight: json["Weight"],
//     medicationName: json["MedicationName"],
//     selectDataTypeName: json["SelectDataTypeName"],
//     dosage: json["Dosage"],
//     timesAndDay: json["TimesAndDay"],
//     color: json["Color"],
//     comments: json["Comments"],
//     unit: json["Unit"],
//     time: json["Time"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "Id": id,
//     "CategoryName": categoryName,
//     "DateTime": dateTime,
//     "BloodGlucose": bloodGlucose,
//     "MeasuredTypeName": measuredTypeName,
//     "SystolicPressure": systolicPressure,
//     "DiastolicPressure": diastolicPressure,
//     "PulseRate": pulseRate,
//     "Hand": hand,
//     "BodyTemperature": bodyTemperature,
//     "BloodOxygenSaturation": bloodOxygenSaturation,
//     "MeasurementTypeName": measurementTypeName,
//     "AverageSugarConcentration": averageSugarConcentration,
//     "Weight": weight,
//     "MedicationName": medicationName,
//     "SelectDataTypeName": selectDataTypeName,
//     "Dosage": dosage,
//     "TimesAndDay": timesAndDay,
//     "Color": color,
//     "Comments": comments,
//     "Unit": unit,
//     "Time": time,
//   };
// }

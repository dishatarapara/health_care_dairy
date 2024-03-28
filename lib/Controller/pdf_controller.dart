import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../Common/bottom_button.dart';
import '../ConstFile/constColors.dart';
import '../ConstFile/constFonts.dart';
import 'blood_sugar_controller.dart';
import 'date_time_controller.dart';

class PdfController extends GetxController {

  BloodSugarController bloodSugarController = Get.put(BloodSugarController());
  DateTimeController dateTimeController = Get.put(DateTimeController());

  TextEditingController fileNameController = TextEditingController();

  RxInt selectedType = 0.obs;
  RxBool weekNameType = false.obs;


  setSelectedType(val) {
    selectedType.value = val;
    if (selectedType.value == 1) {
      weekNameType.value = false;
    } else if (selectedType.value == 2) {
      weekNameType.value = false;
    } else if (selectedType.value == 3) {
      weekNameType.value = false;
    } else if (selectedType.value == 4) {
      weekNameType.value = false;
    } else {
      weekNameType.value = true;
    }
    debugPrint(selectedType.value.toString());
  }

  void applyFilter() {
    DateTime? startDate;
    DateTime? endDate;

    DateTime now = DateTime.now();
    switch(selectedType.value) {
      case 1:
        startDate = now.subtract(Duration(days: now.weekday - 0));
        endDate = startDate.add(Duration(days: 6));
        break;

      case 2:
        startDate = now.subtract(Duration(days: now.weekday + 7));
        endDate = startDate.add(Duration(days: 7));
        break;

      case 3:
        startDate = DateTime(now.year, now.month, 0);
        endDate = DateTime(now.year, now.month + 1, 0);
        break;

      case 4:
        startDate = DateTime(now.year, now.month - 1, 1);
        endDate = DateTime(now.year, now.month, 1);
        break;

      case 5:
        startDate = dateTimeController.selectedFromDate.value;
        endDate = dateTimeController.selectedToDate.value;
        break;

      default:
        startDate = null;
        endDate = null;
    }
    DateFormat dateFormat = DateFormat('dd/MM/yyyy');
    if(startDate != null && endDate != null) {
      bloodSugarController.filterLists.value = bloodSugarController.bloodSugarLists.where((item) => dateFormat.parse(item.dateTime).isAfter(startDate!) && dateFormat.parse(item.dateTime).isBefore(endDate!)).toList();
    }else{
      bloodSugarController.filterLists.value = bloodSugarController.bloodSugarLists;
    }
    print(bloodSugarController.filterLists);
  }

  // List<String> listName = <String>[
  //   "Blood Sugar",
  //   "Blood pressure",
  //   "Body Temperature",
  //   "Blood oxygen",
  //   "Hemoglobin (A1C)",
  //   "Weight"
  // ];

  List<DiaryList> diaryLists = <DiaryList>[
    DiaryList(name: "Blood Sugar", image: "assets/Icons/blood_sugar.png"),
    DiaryList(name: "Blood Pressure", image: "assets/Icons/blood_pressure.png"),
    DiaryList(name: "Body Temperature", image: "assets/Icons/body_temperature.png"),
    DiaryList(name: "Blood Oxygen Saturation", image: "assets/Icons/blood_oxygen_saturation.png"),
    DiaryList(name: "Hemoglobin (A1C)", image: "assets/Icons/hemoglobin.png"),
    DiaryList(name: "Weight", image: "assets/Icons/weight.png"),
  ];

  // List<String> imagesList = <String>[
  //   "assets/Icons/blood_sugar.png",
  //   "assets/Icons/blood_pressure.png",
  //   "assets/Icons/body_temperature.png",
  //   "assets/Icons/blood_oxygen_saturation.png",
  //   "assets/Icons/hemoglobin.png",
  //   "assets/Icons/weight.png"
  // ];

  void pdfDialog() {
    showDialog(
      barrierDismissible: false,
      context: Get.context!,
      builder: (context) {
        var deviceHeight = MediaQuery.of(context).size.height;
        var deviceWidth = MediaQuery.of(context).size.width;
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              insetAnimationCurve: Curves.linear,
              backgroundColor: ConstColour.appColor,
              child: WillPopScope(
                onWillPop: () async {
                  SystemNavigator.pop();
                  return true;
                },
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: ConstColour.appColor,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: ConstColour.appColor,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.4),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: deviceWidth * 0.03
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: deviceHeight * 0.03),
                          child: Image.asset(
                            'assets/Icons/no_data_pdf.png',
                            fit: BoxFit.cover,
                            height: deviceHeight * 0.07,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: deviceHeight * 0.02),
                          child: Text(
                            "Report Name",
                            style: TextStyle(
                                fontSize: 23,
                                color: ConstColour.textColor,
                                fontFamily: ConstFont.bold
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: deviceHeight * 0.02,
                          ),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Name",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: ConstColour.textColor,
                                  fontFamily: ConstFont.regular
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: deviceHeight * 0.01
                          ),
                          child: TextFormField(
                            controller: fileNameController,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            keyboardType: TextInputType.text,
                            autocorrect: true,
                            style: TextStyle(
                                fontSize: 18,
                                color: ConstColour.textColor
                            ),
                            cursorColor: ConstColour.buttonColor,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey[200],
                              isDense: true,
                              hintText: "Enter File Name",
                              hintStyle: TextStyle(
                                  fontSize: 18,
                                  fontFamily: ConstFont.regular,
                                  color: ConstColour.textColor
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide.none
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: deviceHeight * 0.02),
                          child: NextButton(
                            onPressed: () {
                                Get.back();
                            },
                            btnName: "Ok",
                          ),
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                elevation: 0.0,
                                shape: RoundedRectangleBorder(
                                    side: BorderSide.none,
                                    borderRadius: BorderRadius.circular(50)),
                                minimumSize: Size(deviceWidth * 0.9, deviceHeight * 0.06),
                                backgroundColor: ConstColour.appColor
                            ),
                            onPressed: () {
                              Get.back();
                            },
                            child: Text(
                              "Cancel",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: ConstColour.textColor
                              ),
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            )
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class DiaryList {
  DiaryList({required this.name, required this.image});

  final String name;
  final String image;
}
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:health_care_dairy/Controller/blood_sugar_controller.dart';
import 'package:health_care_dairy/Controller/medication_controller.dart';
import 'package:health_care_dairy/Controller/notification_controller.dart';
import 'package:health_care_dairy/model/get_category_model.dart';
import 'package:http/http.dart' as http;

import '../Common/bottom_button.dart';
import '../ConstFile/constApi.dart';
import '../ConstFile/constColors.dart';
import '../ConstFile/constFonts.dart';
import '../model/insert_category_detail_model.dart';

class DeleteController extends GetxController {
  MedicationController medicationController = Get.put(MedicationController());
  BloodSugarController bloodSugarController = Get.put(BloodSugarController());
  NotificationController notificationController = Get.put(NotificationController());

  RxBool flag = false.obs;
  // int selectedIndex = -1;

  final selectedIndices = Set<int>().obs;
  final deleteRecordList = Set<int>().obs;
 // List<String> deleteRecordList = [];

  int? messageCode;
  Future<void> deleteApi() async {
    //deleteRecordList = selectedIndices.map((int value) => value.toString()).toList();
    // String formattedString = deleteRecordList.map((int value) => '"$value"').join(',');
    String stringWithCommas = deleteRecordList.join(',');
    final response = await http.post(Uri.parse(ConstApi.deleteList),
        body: {
          "Ids": stringWithCommas.toString()
        });
    var data = response.body;
    debugPrint(data.toString());

    if (response.statusCode == 200) {
      final responseData = deleteFromJson(response.body);
      debugPrint(responseData.toString());
      messageCode = responseData.messageCode;
      debugPrint(messageCode.toString());

      if (messageCode == 1) {
        flag.value = false;
        selectedIndices.clear();
        deleteRecordList.clear();
        // bloodSugarController.getCategoryList();
        debugPrint("Deleted Successfully");
        // Get.back();
      } else {
        debugPrint("Error");
      }
    } else {}
  }

  void deleteSelected() {

    List<CategoryList> tempList = [];

    for (int i = 0; i < bloodSugarController.filterLists.length; i++) {
      if (!selectedIndices.contains(i)) {
        tempList.add(bloodSugarController.filterLists[i]);
      }
    }
    bloodSugarController.filterLists.assignAll(tempList);
    medicationController.bloodSugarLists.assignAll(tempList);
    selectedIndices.clear();
  }

  void deleteDialog(String title) {
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
                            'assets/Images/delete.png',
                            fit: BoxFit.cover,
                            height: deviceHeight * 0.07,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: deviceHeight * 0.02),
                          child: Text(
                            "Delete",
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
                          child: Text(
                            title,
                            // "Are you sure, you want to delete this Blood Sugar Record?",
                            style: TextStyle(
                                fontSize: 18,
                                color: ConstColour.greyTextColor,
                                fontFamily: ConstFont.regular
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: deviceHeight * 0.02),
                          child: NextButton(
                            onPressed: () {
                              if (selectedIndices.isEmpty) {
                                Get.back();
                              } else {
                                // deleteApi(
                                //   bloodSugarController.sugarId.value.toString(),
                                // );
                                deleteApi();
                                deleteSelected();
                                Get.back();
                              }
                            },
                            btnName: "Yes, sure",
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
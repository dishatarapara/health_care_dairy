import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import '../ConstFile/constColors.dart';
import '../ConstFile/constFonts.dart';

class SettingScreenController extends GetxController {

  RxInt selectedNumberType = 1.obs;
  RxBool numType = false.obs;
  setSelectedNumberRadio(value) {
    selectedNumberType.value = value;
    debugPrint(selectedNumberType.value.toString());
  }

  RxInt selectedTimeType = 3.obs;
  setSelectedTimeRadio(value) {
    selectedTimeType.value = value;
    debugPrint(selectedTimeType.value.toString());
  }

  RxInt selectedDateType = 6.obs;
  setSelectedDateRadio(value) {
    selectedDateType.value = value;
    debugPrint(selectedDateType.value.toString());
  }

  List<String> dateTypes = <String> [
    "28/01/2024",
    "01/28/2024",
    "2024/01/28",
    "28-01-2024",
    "01-28-2024",
    "2024-01-28",
    "2024/28/01",
    "28/01/24"
  ];

  void showDateFormat() {
    showDialog(
      context: Get.context!,
      builder: (context) {
        var deviceHeight = MediaQuery.of(context).size.height;
        var deviceWidth = MediaQuery.of(context).size.width;
        return StatefulBuilder(
            builder: (context, setState) {
              return Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  insetAnimationCurve: Curves.linear,
                  backgroundColor: ConstColour.appColor,
                  child: Container(
                      decoration: BoxDecoration(
                        color: ConstColour.appColor,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: ConstColour.appColor,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.4),
                            spreadRadius: 2,
                            blurRadius: 2,
                            // offset: const Offset(0, 2),
                          ),
                        ],
                      ) ,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  top: deviceHeight * 0.02,
                                  left: deviceWidth * 0.04),
                              child: Text(
                                "Date Format",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: ConstColour.textColor,
                                  fontFamily: ConstFont.bold,
                                ),
                              ),
                            ),
                            ListTile(
                              dense: true,
                              title: Text(
                                  '28/01/2024',
                                style: TextStyle(
                                  fontSize: 15
                                ),
                              ),
                              leading: Obx(() => InkWell(
                                onTap: () {
                                  Get.back();
                                  setSelectedDateRadio(7);
                                },
                                child: Radio(
                                  value: 7,
                                  groupValue: selectedDateType.value,
                                  onChanged: setSelectedDateRadio,
                                  activeColor: ConstColour.buttonColor,),
                              ),
                              ),
                            ),
                            ListTile(
                              dense: true,
                              title: Text('01/28/2024',
                                style: TextStyle(
                                    fontSize: 15
                                ),
                              ),
                              leading: Obx(() => InkWell(
                                onTap: () {
                                  setSelectedDateRadio(8);
                                  Get.back();
                                },
                                child: Radio(
                                  value: 8,
                                  groupValue: selectedDateType.value,
                                  onChanged: setSelectedDateRadio,
                                  activeColor: ConstColour.buttonColor,
                                )),
                              ),
                            ),
                            ListTile(
                              dense: true,
                              title: Text('2024/01/28',
                                style: TextStyle(
                                    fontSize: 15
                                ),
                              ),
                              leading: Obx(() => InkWell(
                                onTap: () {
                                  setSelectedDateRadio(9);
                                  Get.back();
                                },
                                child: Radio(
                                  value: 9,
                                  groupValue: selectedDateType.value,
                                  onChanged: setSelectedDateRadio,
                                  activeColor: ConstColour.buttonColor,),
                              ),
                              ),
                            ),
                            ListTile(
                              dense: true,
                              title: Text('28-01-2024',
                                style: TextStyle(
                                    fontSize: 15
                                ),
                              ),
                              leading: Obx(() => InkWell(
                                onTap: () {
                                  setSelectedDateRadio(10);
                                  Get.back();
                                },
                                child: Radio(
                                  value: 10,
                                  groupValue: selectedDateType.value,
                                  onChanged: setSelectedDateRadio,
                                  activeColor: ConstColour.buttonColor),
                              ),
                              ),
                            ),
                            ListTile(
                              dense: true,
                              title: Text('01-28-2024',
                                style: TextStyle(
                                    fontSize: 15
                                ),
                              ),
                              leading: Obx(() =>
                                  InkWell(
                                    onTap: () {
                                      setSelectedDateRadio(11);
                                      Get.back();
                                      },
                                    child: Radio(
                                        value: 11,
                                        groupValue: selectedDateType.value,
                                        onChanged: setSelectedDateRadio,
                                        activeColor: ConstColour.buttonColor),
                                  ),
                              ),
                            ),
                            ListTile(
                              dense: true,
                              title: Text('2024-01-28',
                                style: TextStyle(
                                    fontSize: 15
                                ),
                              ),
                              leading: Obx(() =>
                                  InkWell(
                                    onTap: () {
                                      setSelectedDateRadio(12);
                                      Get.back();
                                    },
                                    child: Radio(
                                        value: 12,
                                        groupValue: selectedDateType.value,
                                        onChanged: setSelectedDateRadio,
                                        activeColor: ConstColour.buttonColor),
                                  ),
                              ),
                            ),
                            ListTile(
                              dense: true,
                              title: Text('2024/28/01',
                                style: TextStyle(
                                    fontSize: 15
                                ),
                              ),
                              leading: Obx(() =>
                                  InkWell(
                                    onTap: () {
                                      setSelectedDateRadio(13);
                                      Get.back();
                                    },
                                    child: Radio(
                                        value: 13,
                                        groupValue: selectedDateType.value,
                                        onChanged: setSelectedDateRadio,
                                        activeColor: ConstColour.buttonColor),
                                  ),
                              ),
                            ),
                            ListTile(
                              dense: true,
                              title: Text('28/01/24',
                                style: TextStyle(
                                    fontSize: 15
                                ),
                              ),
                              leading: Obx(() =>
                                  InkWell(
                                    onTap: () {
                                      setSelectedDateRadio(14);
                                      Get.back();
                                    },
                                    child: Radio(
                                        value: 14,
                                        groupValue: selectedDateType.value,
                                        onChanged: setSelectedDateRadio,
                                        activeColor: ConstColour.buttonColor),
                                  ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: deviceWidth * 0.03),
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: TextButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: Text(
                                      "CANCEL",
                                      style: TextStyle(
                                        color: ConstColour.buttonColor,
                                      ),
                                    )
                                ),
                              ),
                            ),
                          ]
                      )
                  )
              );
            }
        );
      },
    );
  }

  void showTimeFormat() {
    showDialog(
      context: Get.context!,
      builder: (context) {
        var deviceHeight = MediaQuery.of(context).size.height;
        var deviceWidth = MediaQuery.of(context).size.width;
        return StatefulBuilder(
            builder: (context, setState) {
              return Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  insetAnimationCurve: Curves.linear,
                  backgroundColor: ConstColour.appColor,
                  child: Container(
                      decoration: BoxDecoration(
                        color: ConstColour.appColor,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: ConstColour.appColor,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.4),
                            spreadRadius: 2,
                            blurRadius: 2,
                            // offset: const Offset(0, 2),
                          ),
                        ],
                      ) ,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  top: deviceHeight * 0.02,
                                  left: deviceWidth * 0.04),
                              child: Text(
                                "Time Format",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: ConstColour.textColor,
                                  fontFamily: ConstFont.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: deviceHeight * 0.02),
                              child: ListTile(
                                title: Text('12:00'),
                                leading: Obx(() => InkWell(
                                  onTap: () {
                                    Get.back();
                                    setSelectedTimeRadio(3);
                                  },
                                  child: Radio(
                                    value: 3,
                                    groupValue: selectedTimeType.value,
                                    onChanged: setSelectedTimeRadio,
                                    activeColor: ConstColour.buttonColor,),
                                ),
                                ),
                              ),
                            ),
                            ListTile(
                              title: Text('24:00'),
                              leading: Obx(() => InkWell(
                                onTap: () {
                                  setSelectedTimeRadio(4);
                                  Get.back();
                                },
                                child: Radio(
                                  value: 4,
                                  groupValue: selectedTimeType.value,
                                  onChanged: setSelectedTimeRadio,
                                  activeColor: ConstColour.buttonColor,),
                              ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: deviceWidth * 0.03),
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: TextButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: Text(
                                      "CANCEL",
                                      style: TextStyle(
                                        color: ConstColour.buttonColor,
                                      ),
                                    )
                                ),
                              ),
                            ),
                          ]
                      )
                  )
              );
            }
        );
      },
    );
  }

  void showNumberFormat() {
    showDialog(
      context: Get.context!,
      builder: (context) {
        var deviceHeight = MediaQuery.of(context).size.height;
        var deviceWidth = MediaQuery.of(context).size.width;
        return StatefulBuilder(
            builder: (context, setState) {
              return Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  insetAnimationCurve: Curves.linear,
                  backgroundColor: ConstColour.appColor,
                  child: Container(
                      decoration: BoxDecoration(
                        color: ConstColour.appColor,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: ConstColour.appColor,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.4),
                            spreadRadius: 2,
                            blurRadius: 2,
                            // offset: const Offset(0, 2),
                          ),
                        ],
                      ) ,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  top: deviceHeight * 0.02,
                                  left: deviceWidth * 0.04),
                              child: Text(
                                "Number Format",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: ConstColour.textColor,
                                  fontFamily: ConstFont.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: deviceHeight * 0.02),
                              child: ListTile(
                                title: Text('123456.00'),
                                leading: Obx(() => InkWell(
                                  onTap: () {
                                    Get.back();
                                    setSelectedNumberRadio(1);
                                  },
                                  child: Radio(
                                    value: 1,
                                    groupValue: selectedNumberType.value,
                                    onChanged: setSelectedNumberRadio,
                                    activeColor: ConstColour.buttonColor,),
                                ),
                                ),
                              ),
                            ),
                            ListTile(
                              title: Text('123456'),
                              leading: Obx(() => InkWell(
                                onTap: () {
                                  setSelectedNumberRadio(2);
                                  Get.back();
                                },
                                child: Radio(
                                  value: 2,
                                  groupValue: selectedNumberType.value,
                                  onChanged: setSelectedNumberRadio,
                                  activeColor: ConstColour.buttonColor,),
                              ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: deviceWidth * 0.03),
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: TextButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: Text(
                                        "CANCEL",
                                      style: TextStyle(
                                        color: ConstColour.buttonColor,
                                      ),
                                    )
                                ),
                              ),
                            ),
                          ]
                      )
                  )
              );
            }
          );
      },
    );
  }

  void shareWithFriends(String contentToShare) {
    Share.share(contentToShare);
  }

  void showRateUsDialogBox() {
    showDialog(
      context: Get.context!,
      builder: (context) {
        var deviceHeight = MediaQuery.of(context).size.height;
        var deviceWidth = MediaQuery.of(context).size.width;
        return StatefulBuilder(
            builder: (context, setState) {
              return Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  insetAnimationCurve: Curves.linear,
                  backgroundColor: ConstColour.appColor,
                  child: Container(
                      decoration: BoxDecoration(
                        color: ConstColour.appColor,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: ConstColour.appColor,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.4),
                            spreadRadius: 2,
                            blurRadius: 2,
                            // offset: const Offset(0, 2),
                          ),
                        ],
                      ) ,
                      child: Padding(
                        padding: EdgeInsets.only(top: deviceHeight * 0.02),
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                'assets/Images/health_image.png' ,
                                fit: BoxFit.cover,
                                height: deviceHeight * 0.15,
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: deviceHeight * 0.01),
                                child: Text(
                                  "Enjoying My Health?",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: ConstColour.textColor,
                                    fontFamily: ConstFont.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: deviceHeight * 0.01),
                                child: Text(
                                  "Support us by giving rate and your \n precious review!!\nit will take few seconds only.",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: ConstColour.textColor,
                                    fontFamily: ConstFont.regular,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Padding(
                                padding:EdgeInsets.only(top: deviceHeight * 0.01),
                                child: RatingBar.builder(
                                  initialRating: 0,
                                  minRating: 0,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  onRatingUpdate: (rating) {
                                  },
                                ),
                              ),
                              SizedBox(height: deviceHeight * 0.02)
                            ]
                        ),
                      )
                  )
              );
            } );
      },
    );
  }
}
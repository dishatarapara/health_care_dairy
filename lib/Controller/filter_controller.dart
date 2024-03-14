import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Common/bottom_button.dart';
import '../ConstFile/constColors.dart';
import '../ConstFile/constFonts.dart';

class FilterController extends GetxController {
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

  void showDialogBox() {
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
                  padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.03),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: deviceHeight * 0.01),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            onPressed: () {
                              Get.back();
                              // Navigator.pop(context);
                            },
                            icon: Icon(Icons.close),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: deviceHeight * 0.01),
                        child: Image.asset(
                          'assets/Icons/filter.png',
                          fit: BoxFit.cover,
                          height: deviceHeight * 0.08,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: deviceHeight * 0.01),
                        child: Text(
                          "Filter",
                          style: TextStyle(
                            fontSize: 23,
                            color: ConstColour.textColor,
                            fontFamily: ConstFont.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: deviceHeight * 0.01,
                          left: deviceWidth * 0.01,
                        ),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Type",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              fontFamily: ConstFont.regular,
                            ),
                          ),
                        ),
                      ),
                      Obx(() => Padding(
                        padding: EdgeInsets.only(top: deviceHeight * 0.02),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: deviceWidth * 0.35,
                              decoration: BoxDecoration(
                                border: Border.all(width: 0.3),
                                color: ConstColour.appColor,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Row(
                                children: [
                                  Radio(
                                    value: 1,
                                    groupValue: selectedType.value,
                                    onChanged: setSelectedType,
                                    activeColor: ConstColour.buttonColor,
                                  ),
                                  Text(
                                    "This Week",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: ConstFont.regular,
                                      color: selectedType.value == 1
                                          ? ConstColour.textColor
                                          : ConstColour.greyTextColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: deviceWidth * 0.35,
                              decoration: BoxDecoration(
                                border: Border.all(width: 0.3),
                                color: ConstColour.appColor,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Row(
                                children: [
                                  Radio(
                                    value: 2,
                                    groupValue: selectedType.value,
                                    onChanged: setSelectedType,
                                    activeColor: ConstColour.buttonColor,
                                  ),
                                  Text(
                                    "Last Week",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: ConstFont.regular,
                                      color: selectedType.value == 2
                                          ? ConstColour.textColor
                                          : ConstColour.greyTextColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      ),
                      Obx(() => Padding(
                        padding: EdgeInsets.only(top: deviceHeight * 0.02),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: deviceWidth * 0.35,
                              decoration: BoxDecoration(
                                border: Border.all(width: 0.3),
                                color: ConstColour.appColor,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Row(
                                children: [
                                  Radio(
                                    value: 3,
                                    groupValue: selectedType.value,
                                    onChanged: setSelectedType,
                                    activeColor: ConstColour.buttonColor,
                                  ),
                                  Text(
                                    "This Month",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: ConstFont.regular,
                                      color: selectedType.value == 3
                                          ? ConstColour.textColor
                                          : ConstColour.greyTextColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: deviceWidth * 0.35,
                              decoration: BoxDecoration(
                                border: Border.all(width: 0.3),
                                color: ConstColour.appColor,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Row(
                                children: [
                                  Radio(
                                    value: 4,
                                    groupValue: selectedType.value,
                                    onChanged: setSelectedType,
                                    activeColor: ConstColour.buttonColor,
                                  ),
                                  Text(
                                    "Last Month",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: ConstFont.regular,
                                      color: selectedType.value == 4
                                          ? ConstColour.textColor
                                          : ConstColour.greyTextColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      ),
                      Obx(() => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Custom Filter",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              fontFamily: ConstFont.regular,
                              color: ConstColour.textColor,
                            ),
                          ),
                          Radio(
                            value: 5,
                            groupValue: selectedType.value,
                            onChanged: setSelectedType,
                            activeColor: ConstColour.buttonColor,
                          ),
                        ],
                      ),
                      ),
                      Obx(() => Visibility(
                        visible: weekNameType.value,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: deviceHeight * 0.055,
                              width: deviceWidth * 0.35,
                              decoration: BoxDecoration(
                                border: Border.all(width: 0.3),
                                color: ConstColour.appColor,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(
                                    Icons.calendar_today,
                                    size: 20,
                                    color: Colors.black,
                                  ),
                                  Text(
                                    "Calendar",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: ConstFont.regular,
                                      color: ConstColour.textColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: deviceHeight * 0.055,
                              width: deviceWidth * 0.35,
                              decoration: BoxDecoration(
                                border: Border.all(width: 0.3),
                                color: ConstColour.appColor,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(
                                    Icons.calendar_today,
                                    size: 20,
                                    color: Colors.black,
                                  ),
                                  Text(
                                    "Calendar",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: ConstFont.regular,
                                      color: ConstColour.textColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: deviceHeight * 0.02),
                        child: NextButton(
                          onPressed: () {
                            Get.back();
                            // Navigator.pop(context);
                          },
                          btnName: "Save",
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: deviceHeight * 0.01),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0.0,
                            shape: RoundedRectangleBorder(
                              side: BorderSide.none,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            minimumSize: Size(deviceWidth * 0.9, deviceHeight * 0.06),
                            backgroundColor: ConstColour.appColor,
                          ),
                          onPressed: () {},
                          child: Text(
                            "Clear",
                            style: TextStyle(
                              fontSize: 20,
                              color: ConstColour.textColor,
                            ),
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: deviceHeight * 0.01,
                      ),
                    ],
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
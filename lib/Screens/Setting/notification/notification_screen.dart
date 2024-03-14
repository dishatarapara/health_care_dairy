import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_care_dairy/Controller/notification_controller.dart';
import 'package:health_care_dairy/Screens/Setting/setting_screen.dart';
import 'package:intl/intl.dart';

import '../../../Common/bottom_button.dart';
import '../../../ConstFile/constColors.dart';
import '../../../ConstFile/constFonts.dart';
import '../../../Controller/date_time_controller.dart';
import '../../../DatabaseHandler/dbhelper.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  NotificationController notificationController = Get.put(NotificationController());
  DateTimeController dateTimeController = Get.put(DateTimeController());
  DateTime current_Datetime = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, DateTime.now().hour, DateTime.now().minute);
  DateFormat formatter = DateFormat('h:mm a');

  final _formKey = new GlobalKey<FormState>();
  var dbhelper;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbhelper = Dbhelper();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ConstColour.appColor,
        elevation: 0.0,
        title: Text(
          "Notification",
          style: TextStyle(
              color: ConstColour.textColor,
              fontFamily: ConstFont.regular,
              fontWeight: FontWeight.w800,
              overflow: TextOverflow.ellipsis
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Get.to(() => SettingScreen());
          },
          icon: Icon(Icons.arrow_back),
          color: ConstColour.textColor,
        ),
      ),
      backgroundColor: ConstColour.bgColor,
      body: Column(
        // children: [
        // Container(
        // color: ConstColour.appColor,
        // height: deviceHeight * 0.05,
        // child: ListView.builder(
        //     itemCount: notificationController.weekNames.length,
        //     scrollDirection: Axis.horizontal,
        //     itemBuilder: (BuildContext context, int index) {
        //       return Padding(
        //         padding: EdgeInsets.symmetric(
        //             horizontal: deviceWidth * 0.015
        //         ),
        //         child: Container(
        //           width: deviceWidth * 0.11,
        //           decoration: BoxDecoration(
        //             borderRadius: BorderRadius.circular(8),
        //             color: notificationController.selectedDays.value == 1
        //                 ? ConstColour.appColor
        //                 : ConstColour.buttonColor,
        //           ),
        //           child: InkWell(
        //             onTap: () {
        //               notificationController.selectedDays.value = 2;
        //             },
        //             child: Center(
        //               child: Text(
        //                 notificationController.weekNames[index],
        //                 style: TextStyle(
        //                     fontSize: 15,
        //                     fontFamily: ConstFont.bold,
        //                     color: notificationController.selectedDays.value == 1
        //                         ? ConstColour.greyTextColor
        //                         : ConstColour.appColor,
        //                 ),
        //               ),
        //             ),
        //           ),
        //         ),
        //       );
        //     }
        // ),
        //       ),
        // ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: FloatingActionButton(
            onPressed: () {
              showDialog(
                  context: context,
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
                              padding: EdgeInsets.symmetric(
                                horizontal: deviceWidth * 0.03
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: deviceHeight * 0.03),
                                    child: Image.asset(
                                        'assets/images/notifications_setting.png',
                                      fit: BoxFit.cover,
                                      height: deviceHeight * 0.08,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: deviceHeight * 0.02),
                                    child: Text(
                                        "Add Notification",
                                      style: TextStyle(
                                        fontSize: 23,
                                        color: ConstColour.textColor,
                                        fontFamily: ConstFont.bold
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: deviceHeight * 0.02
                                    ),
                                    child: TextFormField(
                                      controller: notificationController.notificationNameController,
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
                                        hintText: "Notification Name",
                                        hintStyle: TextStyle(
                                            fontSize: 18,
                                            fontFamily: ConstFont.regular,
                                            color: ConstColour.greyTextColor
                                        ),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8),
                                            borderSide: BorderSide.none
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: deviceHeight * 0.01),
                                    child: InkWell(
                                      onTap: () => dateTimeController.pickTime(),
                                      child: Text(dateTimeController.formattedTime.value.isEmpty
                                          ? formatter.format(current_Datetime)
                                          : dateTimeController.formattedTime.value,
                                        style: TextStyle(
                                            fontSize: 35,
                                            fontFamily: ConstFont.bold,
                                          color: ConstColour.buttonColor
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: deviceHeight * 0.01),
                                    child: Text(
                                      "Notification Time",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: ConstColour.greyTextColor,
                                          fontFamily: ConstFont.regular,
                                        fontWeight: FontWeight.w500
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: deviceHeight * 0.01,
                                        left: deviceWidth * 0.01
                                    ),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                          "Type",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: ConstFont.regular
                                        ),
                                      ),
                                    ),
                                  ),
                                  Obx(() => Padding(
                                    padding: EdgeInsets.only(top: deviceHeight * 0.01),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Expanded(
                                            child: Row(
                                              children: [
                                                Radio(
                                                  value: 1,
                                                  groupValue: notificationController.selectedType.value,
                                                  onChanged: notificationController.setSelectedType,
                                                  activeColor: ConstColour.buttonColor,
                                                ),
                                                Text(
                                                  "Everyday",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontFamily: ConstFont.regular,
                                                      color: notificationController.selectedType.value == 1
                                                          ? ConstColour.textColor
                                                          : ConstColour.greyTextColor
                                                  ),
                                                ),
                                              ],
                                            )
                                        ),
                                        Expanded(
                                            child: Row(
                                              children: [
                                                Radio(
                                                  value: 2,
                                                  groupValue: notificationController.selectedType.value,
                                                  onChanged: notificationController.setSelectedType,
                                                  activeColor: ConstColour.buttonColor,
                                                ),
                                                Text(
                                                  "On Certain Days",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontFamily: ConstFont.regular,
                                                      color: notificationController.selectedType.value == 2
                                                          ? ConstColour.textColor
                                                          : ConstColour.greyTextColor
                                                  ),
                                                ),
                                              ],
                                            )
                                        ),
                                      ],
                                    ),
                                  ),
                                  ),
                              Obx(() => Visibility(
                                  visible: notificationController.weekNameType.value,
                                  child: Container(
                                    color: ConstColour.appColor,
                                    height: deviceHeight * 0.05,
                                    child: ListView.builder(
                                        itemCount: notificationController.weekNames.length,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (BuildContext context, int index) {
                                          return Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: deviceWidth * 0.015
                                            ),
                                            child: Container(
                                              width: deviceWidth * 0.11,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(8),
                                                color: notificationController.weekNameType.value
                                                    ? ConstColour.buttonColor
                                                    : ConstColour.appColor
                                              ),
                                              child: Center(
                                                child: Text(
                                                  notificationController.weekNames[index],
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: notificationController.weekNameType.value
                                                          ? ConstColour.appColor
                                                          : ConstColour.greyTextColor
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                    ),
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
                                                borderRadius: BorderRadius.circular(50)),
                                            minimumSize: Size(deviceWidth * 0.9, deviceHeight * 0.06),
                                            backgroundColor: ConstColour.appColor
                                        ),
                                        onPressed: () {
                                          Get.back();
                                          // Navigator.pop(context);
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
                                    )
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
            },
            child: Icon(Icons.add),
            backgroundColor: ConstColour.buttonColor,
          ),
        ),
      ),
    );
  }
}

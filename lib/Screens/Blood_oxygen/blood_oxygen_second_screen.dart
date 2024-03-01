import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../Common/bottom_button.dart';
import '../../Common/snackbar.dart';
import '../../ConstFile/constColors.dart';
import '../../ConstFile/constFonts.dart';
import '../../Controller/blood_oxygen_controller.dart';
import '../../Controller/date_time_controller.dart';

class BloodOxygenScreen extends StatefulWidget {
  const BloodOxygenScreen({super.key});

  @override
  State<BloodOxygenScreen> createState() => _BloodOxygenScreenState();
}

class _BloodOxygenScreenState extends State<BloodOxygenScreen> {
  BloodOxygenController bloodOxygenController = Get.put(BloodOxygenController());
  DateTimeController dateTimeController = Get.put(DateTimeController());
  DateTime current_Datetime = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, DateTime.now().hour, DateTime.now().minute);
  DateFormat formatter = DateFormat('h:mm a');

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ConstColour.appColor,
        elevation: 0.0,
        title: Text(
          "Add Blood Oxygen",
          style: TextStyle(
              color: ConstColour.textColor,
              fontFamily: ConstFont.regular,
              fontWeight: FontWeight.w800,
              overflow: TextOverflow.ellipsis
          ),
        ),
        leading: IconButton(
          onPressed: () {
            // Get.to(() => BloodOxygen());
            Get.back();
          },
          icon: Icon(Icons.arrow_back),
          color: ConstColour.textColor,
        ),
      ),
      backgroundColor: ConstColour.bgColor,
      body: Obx(() => Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: deviceWidth * 0.02,
                vertical: deviceHeight * 0.02
            ),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  InkWell(
                    onTap: () => dateTimeController.pickDate(),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: deviceWidth * 0.03,
                          vertical: deviceHeight * 0.015
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Date',
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: ConstFont.bold
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                DateFormat('dd/MM/yyyy').format(dateTimeController.selectedDate.value),
                                style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: ConstFont.regular
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: deviceWidth * 0.03
                                ),
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  size: 20,
                                  color: ConstColour.textColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => dateTimeController.pickTime(),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: deviceWidth * 0.03,
                          vertical: deviceHeight * 0.015
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Time',
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: ConstFont.bold
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(dateTimeController.formattedTime.value.isEmpty
                                  ? formatter.format(current_Datetime)
                                  : dateTimeController.formattedTime.value,
                                style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: ConstFont.regular
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: deviceWidth * 0.03
                                ),
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  size: 20,
                                  color: ConstColour.textColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: deviceWidth * 0.03,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Blood Oxygen Saturation',
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: ConstFont.bold
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Expanded(
                                child: TextFormField(
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  controller: bloodOxygenController.oxygenController,
                                  cursorColor: ConstColour.buttonColor,
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: ConstColour.textColor,
                                      fontFamily: ConstFont.regular
                                  ),
                                  autocorrect: true,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(6)
                                  ],
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "0",
                                    hintStyle: TextStyle(
                                        fontSize: 20,
                                        color: ConstColour.greyTextColor,
                                        fontFamily: ConstFont.regular
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: deviceWidth * 0.03
                                ),
                                child: Text(
                                  '%',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: ConstColour.greyTextColor,
                                      fontFamily: ConstFont.regular
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: deviceWidth * 0.03,
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Comments',
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: ConstFont.bold
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: deviceWidth * 0.02
                            ),
                            child: TextFormField(
                              cursorColor: ConstColour.buttonColor,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              controller: bloodOxygenController.oxygenCommentController,
                              style: TextStyle(
                                  fontSize: 18,
                                  color: ConstColour.textColor,
                                  fontFamily: ConstFont.regular
                              ),
                              autocorrect: true,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Enter your comments",
                                hintStyle: TextStyle(
                                    fontSize: 20,
                                    color: ConstColour.greyTextColor,
                                    fontFamily: ConstFont.regular
                                ),
                              ),
                            ),
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
            padding: EdgeInsets.only(top: deviceHeight * 0.01),
            child: NextButton(
              onPressed: () {
                if (bloodOxygenController.oxygenController.text.isEmpty) {
                  Utils().snackBar('Blood Oxygen Saturation', "Please Enter Blood Oxygen Saturation");
                } else {
                  var date =  DateFormat('dd/MM/yyyy').format(dateTimeController.selectedDate.value);
                  var time = dateTimeController.formattedTime.value.isEmpty ? formatter.format(current_Datetime) : dateTimeController.formattedTime.value;
                  bloodOxygenController.BloodOxygenList(
                      date.toString(),
                      bloodOxygenController.oxygenController.text,
                      bloodOxygenController.oxygenCommentController.text,
                      time.toString());
                }
                // bloodSugarController.BloodSugarList();
                // Get.to(() => BloodOxygen());
              },
              btnName: "Save",
            ),
          )
        ],
      )),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_care_dairy/Controller/date_time_controller.dart';
import 'package:health_care_dairy/Screens/Blood_pressure/blood_pressure_second_screen.dart';
import 'package:health_care_dairy/Screens/Blood_pressure/edit_blood_pressure_screen.dart';

import '../../ConstFile/constColors.dart';
import '../../ConstFile/constFonts.dart';
import '../../Controller/blood_pressure_controller.dart';
import '../../Controller/blood_sugar_controller.dart';
import '../home_screen.dart';

class BloodPressure extends StatefulWidget {
  final String id;
  BloodPressure({super.key, required this.id});

  @override
  State<BloodPressure> createState() => _BloodPressureState();
}

class _BloodPressureState extends State<BloodPressure> {
  DateTimeController dateTimeController = Get.put(DateTimeController());
  BloodPressureController bloodPressureController = Get.put(BloodPressureController());
  BloodSugarController bloodSugarController = Get.put(BloodSugarController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloodSugarController.updateCatId(widget.id.toString());
    bloodPressureController.updateCatId(widget.id.toString());
    print("pressureScreen catid"+widget.id.toString());
    setState(() {
      bloodSugarController.getCategoryList();
    });
  }

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ConstColour.appColor,
        elevation: 0.0,
        title: Text(
          "Blood Pressure",
          style: TextStyle(
              color: ConstColour.textColor,
              fontFamily: ConstFont.regular,
              fontWeight: FontWeight.w800,
              overflow: TextOverflow.ellipsis
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Get.to(() => HomeScreen());
          },
          icon: Icon(Icons.arrow_back),
          color: ConstColour.textColor,
        ),
      ),
      backgroundColor: ConstColour.bgColor,
      body: RefreshIndicator(
        color: ConstColour.buttonColor,
        onRefresh: () async {
          await bloodSugarController.getCategoryList();
        },
        child: Obx(() => SingleChildScrollView(
            scrollDirection: Axis.vertical,
            controller: ScrollController(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Visibility(
                visible: bloodSugarController.isLoading.value,
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: ConstColour.appColor
                      ),
                      child: bloodSugarController.bloodSugarLists.isEmpty
                          ? Center(
                        child: CircularProgressIndicator(
                          color: ConstColour.buttonColor,
                        ),
                      ) : ListView.builder(
                        reverse: true,
                        controller: ScrollController(),
                        shrinkWrap: true,
                        itemCount: bloodSugarController.bloodSugarLists.length,
                        itemBuilder: (context, index) {
                          return
                          //   Padding(
                          //   padding: EdgeInsets.symmetric(
                          //     vertical: deviceHeight * 0.01,
                          //     horizontal: deviceWidth * 0.02
                          //   ),
                          //   child: Column(
                          //     children: [
                          //       Row(
                          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //         children: [
                          //           Text(
                          //             bloodSugarController.bloodSugarLists[index].hand == null ? "No data found" : bloodSugarController.bloodSugarLists[index].hand.toString(),
                          //             style: TextStyle(
                          //                 fontSize: 20,
                          //                 color: ConstColour.textColor,
                          //                 fontFamily: ConstFont.regular
                          //             ),
                          //           ),
                          //           Padding(
                          //             padding: EdgeInsets.only(left: deviceWidth * 0.45),
                          //             child: Text(
                          //               "Diastolic",
                          //               style: TextStyle(
                          //                   fontSize: 15,
                          //                   color: ConstColour.greyTextColor,
                          //                   fontFamily: ConstFont.regular
                          //               ),
                          //             ),
                          //           ),
                          //           Text(
                          //             bloodSugarController.bloodSugarLists[index].diastolicPressure.toString(),
                          //             style: TextStyle(
                          //                 fontSize: 30,
                          //                 color: ConstColour.textColor,
                          //                 fontFamily: ConstFont.bold
                          //             ),
                          //           ),
                          //         ],
                          //       ),
                          //       Row(
                          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //         children: [
                          //           Text(
                          //             bloodSugarController.bloodSugarLists[index].dateTime,
                          //             style: TextStyle(
                          //                 fontSize: 16,
                          //                 color: ConstColour.greyTextColor,
                          //                 fontFamily: ConstFont.regular
                          //             ),
                          //           ),
                          //           Padding(
                          //             padding: EdgeInsets.only(left: deviceWidth * 0.02),
                          //             child: Text(
                          //               bloodSugarController.bloodSugarLists[index].dateTime,
                          //               style: TextStyle(
                          //                   fontSize: 16,
                          //                   color: ConstColour.greyTextColor,
                          //                   fontFamily: ConstFont.regular
                          //               ),
                          //             ),
                          //           ),
                          //           Padding(
                          //             padding: EdgeInsets.only(left: deviceWidth * 0.1),
                          //             child: Text(
                          //               "Systolic",
                          //               style: TextStyle(
                          //                   fontSize: 15,
                          //                   color: ConstColour.greyTextColor,
                          //                   fontFamily: ConstFont.regular
                          //               ),
                          //             ),
                          //           ),
                          //           Text(
                          //             bloodSugarController.bloodSugarLists[index].systolicPressure.toString(),
                          //             style: TextStyle(
                          //                 fontSize: 30,
                          //                 color: ConstColour.textColor,
                          //                 fontFamily: ConstFont.bold
                          //             ),
                          //           ),
                          //         ],
                          //       ),
                          //     ],
                          //   ),
                          // );
                            ListTile(
                              onTap: () {
                                bloodPressureController.pressureId.value = bloodSugarController.bloodSugarLists[index].id.toInt();
                                // bloodSugarController.getEditBloodSugarList(widget.id.toString());
                                Get.to(() => UpdateBloodPressureScreen(
                                  catId: bloodSugarController.bloodSugarLists[index].id.toString(),
                                ));
                              },
                              leading: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Image.asset(
                                      "assets/Icons/line.png",
                                    ),
                                    Image.asset(
                                      "assets/Icons/circle.png",
                                      height: deviceHeight * 0.02,
                                    ),
                                  ]
                              ),
                            title: Text(
                              bloodSugarController.bloodSugarLists[index].hand == null
                                  ? "No data"
                                  : (bloodSugarController.bloodSugarLists[index].hand == true ? "Left Hand" : "Right Hand"),
                              style: TextStyle(
                                  fontSize: 20,
                                  color: ConstColour.textColor,
                                  fontFamily: ConstFont.regular
                              ),
                            ),
                            subtitle: Row(
                              children: [
                                Text(
                                  bloodSugarController.bloodSugarLists[index].dateTime,
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: ConstColour.greyTextColor,
                                      fontFamily: ConstFont.regular
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: deviceWidth * 0.03),
                                  child: Text(
                                    bloodSugarController.bloodSugarLists[index].time.toString(),
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: ConstColour.greyTextColor,
                                        fontFamily: ConstFont.regular
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            trailing: Column(
                              children: [
                                RichText(
                                  text: TextSpan(
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: 'Diastolic  ',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: ConstColour.greyTextColor,
                                            fontFamily: ConstFont.regular
                                        ),
                                      ),
                                      TextSpan(
                                        text: bloodSugarController.bloodSugarLists[index].diastolicPressure.toString(),
                                        style: TextStyle(
                                            fontSize: 22,
                                            color: ConstColour.textColor,
                                            fontFamily: ConstFont.bold
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: 'Systolic  ',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: ConstColour.greyTextColor,
                                            fontFamily: ConstFont.regular
                                        ),
                                      ),
                                      TextSpan(
                                        text: bloodSugarController.bloodSugarLists[index].systolicPressure.toString(),
                                        style: TextStyle(
                                            fontSize: 22,
                                            color: ConstColour.textColor,
                                            fontFamily: ConstFont.bold
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          onPressed: navigateToAddPage,
          child: Icon(Icons.add),
          backgroundColor: ConstColour.buttonColor,
        ),
      ),
    );
  }

  Future<void> navigateToAddPage() async {
    dateTimeController.selectedDate.value =  DateTime.now();
    dateTimeController.formattedTime.value = dateTimeController.formatTimeOfDay(TimeOfDay.now());
    bloodPressureController.systolicPressureController.text = "";
    bloodPressureController.diastolicPressureController.text = "";
    bloodPressureController.pulesRateController.text = "";
    bloodPressureController.pressureCommentController.text = "";
    Get.to(() => BloodPressureScreen());
  }
}
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:health_care_dairy/Controller/date_time_controller.dart';
import 'package:health_care_dairy/Controller/unit_controller.dart';
import 'package:health_care_dairy/Screens/Body_Temperature/body_temperature_second_screen.dart';
import 'package:health_care_dairy/Screens/Body_Temperature/edit_body_temperature_screen.dart';

import '../../ConstFile/constColors.dart';
import '../../ConstFile/constFonts.dart';
import '../../ConstFile/constPreferences.dart';
import '../../Controller/blood_sugar_controller.dart';
import '../../Controller/body_temperature_controller.dart';
import '../../Controller/delete_controller.dart';
import '../../Controller/filter_controller.dart';
import '../../model/get_category_model.dart';
import '../home/discription_screen.dart';
import '../home_screen.dart';
import '../../Common/loader.dart';

class BodyTemperature extends StatefulWidget {
  final String id;
  const BodyTemperature({super.key, required this.id});

  @override
  State<BodyTemperature> createState() => _BodyTemperatureState();
}

class _BodyTemperatureState extends State<BodyTemperature> {
  FilterController filterController = Get.put(FilterController());
  DeleteController deleteController = Get.put(DeleteController());
  DateTimeController dateTimeController = Get.put(DateTimeController());
  UnitController unitController = Get.put(UnitController());
  BodyTemperatureController bodyTemperatureController = Get.put(BodyTemperatureController());
  BloodSugarController bloodSugarController = Get.put(BloodSugarController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // bloodSugarController.updateCatId(widget.id.toString());
    // bodyTemperatureController.updateCatId(widget.id.toString());
    // print("bodyTemperaturescreen catid"+widget.id.toString());
    //
    // setState(() {
    //   bloodSugarController.getCategoryList();
    // });
    SchedulerBinding.instance.addPostFrameCallback((_) {
      bloodSugarController.filterLists.clear();
    });
    setState(() {
      setBodyPref();
    });
    loadBodyTemperatureData();
  }

  void setBodyPref() async {
    var bodyTemperature = await ConstPreferences().getBodyTemperature();
    print("bodyTemperature "+bodyTemperature.toString());
    if (bodyTemperature != null) {
      bodyTemperatureController.newValue.value = bodyTemperature;
    } else {
      // Handle the case where otherUnit is null, maybe provide a default value or handle the error.
    }
  }

  Future<void> loadBodyTemperatureData() async {
    await Future.delayed(Duration(seconds: 3));
    if (mounted) {
      setState(() {
        bloodSugarController.isLoading.value = false;
      });

      bloodSugarController.updateCatId(widget.id.toString());
      bodyTemperatureController.updateCatId(widget.id.toString());
      print("bodyTemperaturescreen catid" + widget.id.toString());
      bloodSugarController.getCategoryList();
    }
  }

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ConstColour.appColor,
        elevation: 0.0,
        title: Obx(
          () => Text(deleteController.flag.value == true
              ? "${deleteController.selectedIndices.length} selected"
              : "Body Temperature",
            style: TextStyle(
                color: ConstColour.textColor,
                fontFamily: ConstFont.regular,
                fontWeight: FontWeight.w800,
                overflow: TextOverflow.ellipsis
            ),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
            // Get.to(() => HomeScreen());
          },
          icon: Icon(Icons.arrow_back),
          color: ConstColour.textColor,
        ),
        actions: [
          IconButton(
              onPressed: () {
                Get.to(() => DiscriptionScreen(
                  title: 'Body Temperature',
                  description: 'Normal human body-temperature (normothermia, euthermia) is the typical temperture range found in humans.  \n\n\nHuman body temperature varies, it depends on gender,age,time of day,exertion level,health status (such as illness and menstruation), what part of the body the measuremen is taken at, state of consciousness(waking,sleeping,sedated),and emotions',
                  detailedDescription: '• Hot : \n   - above 38°C(100.4°F) \n\n• Normal : \n   36.5-37.5°C (97.7-99.5°F) is typically reported range for normal body temperature. \n\n• Cold : \n   24-26°C (75.2-78.8°F) or less however, some patients have been known to survive with body temperature as low as 13.7°C (56.7°F).',
                ));
              },
              icon: Image.asset("assets/Icons/information.png")),
          Obx(() =>  IconButton(
              onPressed: () {
                if(deleteController.flag.value == true) {
                  deleteController.flag.value = false;
                  deleteController.deleteDialog("Are you sure, you want to delete this Body Temperature Record?");
                } else {
                  filterController.showDialogBox();
                }
              },
              icon: deleteController.flag.value == true
                  ? Icon(Icons.delete,
                  color: ConstColour.textColor
              )
                  : Image.asset(
                "assets/Icons/filter.png",
                width: deviceWidth * 0.07,
                height: deviceHeight * 0.028,)
          ),
          )
        ],
      ),
      backgroundColor: ConstColour.bgColor,
      body: Obx(() => RefreshIndicator(
        color: ConstColour.buttonColor,
        onRefresh: () async {
          await bloodSugarController.getCategoryList();
        },
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          controller: ScrollController(),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                bloodSugarController.filterLists.isEmpty
                ? ((bloodSugarController.isLoading.value == true))
                    ? Padding(
                  padding: EdgeInsets.symmetric(vertical: deviceHeight * 0.3),
                  child: Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Image.asset(
                            "assets/Icons/no_data_body_temperature.png",
                            height: deviceHeight * 0.1
                        ),
                        Text(
                          "No Record Found",
                          style: TextStyle(
                              fontSize: 15,
                              color: ConstColour.greyTextColor,
                              fontFamily: ConstFont.regular
                          ),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                )
                    : Loaders(
                  items: 10,
                  direction: LoaderDirection.ltr,
                  builder: Padding(
                    padding: EdgeInsets.only(
                        right: deviceWidth * 0.01),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6)),
                            title: Container(
                                width: deviceWidth * 0.2,
                                height: deviceHeight * 0.005,
                                color: Colors.grey),
                            tileColor: Colors.grey.shade100,
                            leading: Icon(
                              Icons.image,
                              size: 50,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
                    : ListView.builder(
                  reverse: false,
                  controller: ScrollController(),
                  shrinkWrap: true,
                  itemCount: bloodSugarController.filterLists.length,
                  itemBuilder: (context, index) {
                    String prvIndexDate = "";
                    String currentIndexDate = bloodSugarController.filterLists[index].dateTime.substring(3);
                    if(index > 0) {
                      prvIndexDate = bloodSugarController.filterLists[(index - 1)].dateTime.substring(3);
                    } else {
                      prvIndexDate = bloodSugarController.filterLists[index].dateTime.substring(3);
                    }
                    //  List<CategoryList> monthRecords = [];
                    String monthYear = "";
                    bool isHeader = false;
                    if(currentIndexDate != prvIndexDate || index == 0) {
                      isHeader =true;
                      monthYear = bloodSugarController.filterLists[index].dateTime.substring(3);
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        isHeader
                            ? Padding(
                          padding: EdgeInsets.only(
                              top: deviceHeight * 0.01,
                              bottom: deviceHeight * 0.01),
                          child: Text(
                            bloodSugarController.formatDate(monthYear),
                            style: TextStyle(
                                fontSize: 25,
                                color: ConstColour.buttonColor,
                                fontFamily: ConstFont.bold
                            ),
                          ),
                        )
                            : SizedBox(),
                        GestureDetector(
                          onLongPress: () {
                            setState(() {
                              if(deleteController.selectedIndices.isEmpty){
                                deleteController.flag.value = false;
                              }
                              if (deleteController.selectedIndices.contains(index)) {
                                deleteController.selectedIndices.remove(index);
                                deleteController.deleteRecordList.remove(bloodSugarController.filterLists[index].id.toString());
                                print("if");
                              } else {
                                deleteController.flag.value = true;
                                deleteController.selectedIndices.add(index);
                                deleteController.deleteRecordList.add(bloodSugarController.filterLists[index].id);
                                print("else");
                              }
                            });
                          },
                          child: Container(
                            color: deleteController.selectedIndices.contains(index) ? ConstColour.buttonColor.withOpacity(0.5) : ConstColour.appColor,
                            child: ListTile(
                              selected: deleteController.selectedIndices.contains(index),
                              onTap: () {
                                if(deleteController.selectedIndices.isEmpty){
                                  deleteController.flag.value = false;
                                }
                                if( deleteController.flag.value == true){
                                  if (deleteController.selectedIndices.contains(index)) {
                                    deleteController.selectedIndices.remove(index);
                                    deleteController.deleteRecordList.remove(bloodSugarController.filterLists[index].id.toString());
                                    print("if");
                                  } else {
                                    deleteController.flag.value = true;
                                    deleteController.selectedIndices.add(index);
                                    deleteController.deleteRecordList.add(bloodSugarController.filterLists[index].id);
                                    print("else");
                                  }
                                  setState(() {});
                                }else{
                                  bodyTemperatureController.temperatureId.value = bloodSugarController.filterLists[index].id.toInt();
                                  Get.to(() => UpdateBodyTemperatureScreen(
                                      catId: bloodSugarController.filterLists[index].id.toString()
                                  ));
                                }
                              },
                              leading: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Image.asset(
                                      "assets/Icons/line.png",
                                    ),
                                    Container(
                                      width: deviceWidth * 0.07,
                                      height: deviceHeight * 0.02,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            image: AssetImage(
                                              "assets/Icons/circle.png",
                                            ),)
                                      ),
                                    ),
                                  ]
                              ),
                              title: Row(
                                children: [
                                  Text(
                                    bloodSugarController.filterLists[index].dateTime,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: ConstColour.greyTextColor,
                                        fontFamily: ConstFont.regular
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: deviceWidth * 0.03),
                                    child: Text(
                                      bloodSugarController.filterLists[index].time.toString(),
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: ConstColour.greyTextColor,
                                          fontFamily: ConstFont.regular
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              trailing: RichText(
                                text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(
                                      // text: bloodSugarController.filterLists[index].bodyTemperature.toString(),
                                      //       text: '${unitController.bodyIndex.value == 4 ?
                                      // bloodSugarController.filterLists[index].bodyTemperature :
                                      // (bloodSugarController.filterLists[index].bodyTemperature * 9 / 5) + 32}',
                                      text: convertBodyTemperature(
                                        bloodSugarController.filterLists[index].bodyTemperature,
                                        bodyTemperatureController.newValue.value,
                                        // unitController.getGlucoseLevelPreference()
                                      ),
                                      style: TextStyle(
                                          fontSize: 28,
                                          color: ConstColour.textColor,
                                          fontFamily: ConstFont.bold
                                      ),
                                    ),
                                    TextSpan(
                                      // text: " ${unitController.bodyIndex.value == 4 ? '℃' : 'ºf'}",
                                      text: " ${bodyTemperatureController.newValue.value == true ? '℃' : 'ºf'}",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: ConstColour.greyTextColor,
                                          fontFamily: ConstFont.regular
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                // ListView.builder(
                //   controller: ScrollController(),
                //   shrinkWrap: true,
                //   itemCount:bloodSugarController.filterLists.length ,
                //   itemBuilder: (BuildContext context, int index) {
                //     String prvIndexDate = "";
                //     String currentIndexDate = bloodSugarController.filterLists[index].dateTime.substring(3);
                //     if(index > 0) {
                //       prvIndexDate = bloodSugarController.filterLists[(index - 1)].dateTime.substring(3);
                //     } else {
                //       prvIndexDate = bloodSugarController.filterLists[index].dateTime.substring(3);
                //     }
                //     List<CategoryList> monthRecords = [];
                //     String monthYear = "";
                //     if(currentIndexDate != prvIndexDate) {
                //       monthYear = bloodSugarController.filterLists[index].dateTime.substring(3);
                //       monthRecords = bloodSugarController.filterLists.where((record) => record.dateTime.substring(3) == monthYear).toList();
                //     } else {
                //       if(index == 0) {
                //         monthYear = bloodSugarController.filterLists[index].dateTime.substring(3);
                //         monthRecords = bloodSugarController.filterLists.where((record) => record.dateTime.substring(3) == monthYear).toList();
                //       }
                //     }
                //     return Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         monthYear.isNotEmpty
                //             ? Padding(
                //           padding: EdgeInsets.only(
                //               top: deviceHeight * 0.01,
                //               bottom: deviceHeight * 0.01),
                //           child: Text(
                //             bloodSugarController.formatDate(monthYear),
                //             style: TextStyle(
                //                 fontSize: 25,
                //                 color: ConstColour.buttonColor,
                //                 fontFamily: ConstFont.bold),
                //           ),
                //         ): SizedBox(),
                //         ListView.builder(
                //           reverse: false,
                //           controller: ScrollController(),
                //           shrinkWrap: true,
                //           itemCount: monthRecords.length,
                //           itemBuilder: (context, index) {
                //             return Container(
                //               color: deleteController.selectedIndices.contains(index) ? ConstColour.buttonColor.withOpacity(0.5) : ConstColour.appColor,
                //               child: ListTile(
                //                 onTap: () {
                //                   bodyTemperatureController.temperatureId.value = monthRecords[index].id.toInt();
                //                   // bloodSugarController.getEditBloodSugarList(widget.id.toString());
                //                   Get.to(() => UpdateBodyTemperatureScreen(
                //                     catId: monthRecords[index].id.toString(),
                //                   ));
                //                 },
                //                 onLongPress: () {
                //                   setState(() {
                //                     if (deleteController.selectedIndices.contains(index)) {
                //                       deleteController.selectedIndices.remove(index);
                //                       print("if");
                //                     } else {
                //                       deleteController.flag.value = true;
                //                       deleteController.selectedIndices.add(index);
                //                       print("else");
                //                     }
                //                   });
                //                 },
                //                 leading: Stack(
                //                     alignment: Alignment.center,
                //                     children: [
                //                       Image.asset(
                //                         "assets/Icons/line.png",
                //                       ),
                //                       Container(
                //                         width: deviceWidth * 0.07,
                //                         height: deviceHeight * 0.02,
                //                         decoration: BoxDecoration(
                //                             shape: BoxShape.circle,
                //                             image: DecorationImage(
                //                               image: AssetImage(
                //                                 "assets/Icons/circle.png",
                //                               ),)
                //                         ),
                //                       ),
                //                     ]
                //                 ),
                //                 title: Row(
                //                   children: [
                //                     Text(
                //                       monthRecords[index].dateTime,
                //                       style: TextStyle(
                //                           fontSize: 16,
                //                           color: ConstColour.greyTextColor,
                //                           fontFamily: ConstFont.regular
                //                       ),
                //                     ),
                //                     Padding(
                //                       padding: EdgeInsets.only(left: deviceWidth * 0.03),
                //                       child: Text(
                //                         monthRecords[index].time.toString(),
                //                         style: TextStyle(
                //                             fontSize: 16,
                //                             color: ConstColour.greyTextColor,
                //                             fontFamily: ConstFont.regular
                //                         ),
                //                       ),
                //                     ),
                //                   ],
                //                 ),
                //                 trailing: RichText(
                //                   text: TextSpan(
                //                     children: <TextSpan>[
                //                       TextSpan(
                //                         // text: bloodSugarController.filterLists[index].bodyTemperature.toString(),
                //                         //       text: '${unitController.bodyIndex.value == 4 ?
                //                         // bloodSugarController.filterLists[index].bodyTemperature :
                //                         // (bloodSugarController.filterLists[index].bodyTemperature * 9 / 5) + 32}',
                //                         text: convertBodyTemperature(
                //                           monthRecords[index].bodyTemperature,
                //                           bodyTemperatureController.newValue.value,
                //                           // unitController.getGlucoseLevelPreference()
                //                         ),
                //                         style: TextStyle(
                //                             fontSize: 28,
                //                             color: ConstColour.textColor,
                //                             fontFamily: ConstFont.bold
                //                         ),
                //                       ),
                //                       TextSpan(
                //                         // text: " ${unitController.bodyIndex.value == 4 ? '℃' : 'ºf'}",
                //                         text: " ${bodyTemperatureController.newValue.value == true ? '℃' : 'ºf'}",
                //                         style: TextStyle(
                //                             fontSize: 12,
                //                             color: ConstColour.greyTextColor,
                //                             fontFamily: ConstFont.regular
                //                         ),
                //                       ),
                //                     ],
                //                   ),
                //                 ),
                //               ),
                //             );
                //           },
                //         ),
                //       ],
                //     );
                //   },
                // ),
              ],
            ),
          ),
        ),
      )
      // {
      //   if(bloodSugarController.isLoading.value) {
      //     return Center(
      //       child: CircularProgressIndicator(
      //         color: ConstColour.buttonColor,
      //       ),
      //     );
      //   } else {
      //     return RefreshIndicator(
      //       color: ConstColour.buttonColor,
      //       onRefresh: () async {
      //         await bloodSugarController.getCategoryList();
      //       },
      //       child: SingleChildScrollView(
      //         scrollDirection: Axis.vertical,
      //         controller: ScrollController(),
      //         child: Padding(
      //           padding: const EdgeInsets.all(8.0),
      //           child: Column(
      //             children: [
      //               Container(
      //                 decoration: BoxDecoration(
      //                     color: ConstColour.appColor
      //                 ),
      //                 child: bloodSugarController.filterLists.isEmpty
      //                     ? Align(
      //                   alignment: Alignment.center,
      //                   child: Center(
      //                     child: CircularProgressIndicator(
      //                       color: ConstColour.buttonColor,
      //                     ),
      //                   ),
      //                 )
      //                     : ListView.builder(
      //                   reverse: true,
      //                   controller: ScrollController(),
      //                   shrinkWrap: true,
      //                   itemCount: bloodSugarController.filterLists.length,
      //                   itemBuilder: (context, index) {
      //                     return ListTile(
      //                       onTap: () {
      //                         bodyTemperatureController.temperatureId.value = bloodSugarController.filterLists[index].id.toInt();
      //                         // bloodSugarController.getEditBloodSugarList(widget.id.toString());
      //                         Get.to(() => UpdateBodyTemperatureScreen(
      //                           catId: bloodSugarController.filterLists[index].id.toString(),
      //                         ));
      //                       },
      //                       leading: Stack(
      //                           alignment: Alignment.center,
      //                           children: [
      //                             Image.asset(
      //                               "assets/Icons/line.png",
      //                             ),
      //                             Image.asset(
      //                               "assets/Icons/circle.png",
      //                               height: deviceHeight * 0.02,
      //                             ),
      //                           ]
      //                       ),
      //                       title: Row(
      //                         children: [
      //                           Text(
      //                             bloodSugarController.filterLists[index].dateTime,
      //                             style: TextStyle(
      //                                 fontSize: 16,
      //                                 color: ConstColour.greyTextColor,
      //                                 fontFamily: ConstFont.regular
      //                             ),
      //                           ),
      //                           Padding(
      //                             padding: EdgeInsets.only(left: deviceWidth * 0.03),
      //                             child: Text(
      //                               bloodSugarController.filterLists[index].time.toString(),
      //                               style: TextStyle(
      //                                   fontSize: 16,
      //                                   color: ConstColour.greyTextColor,
      //                                   fontFamily: ConstFont.regular
      //                               ),
      //                             ),
      //                           ),
      //                         ],
      //                       ),
      //                       trailing: RichText(
      //                         text: TextSpan(
      //                           children: <TextSpan>[
      //                             TextSpan(
      //                               // text: bloodSugarController.filterLists[index].bodyTemperature.toString(),
      //                               //       text: '${unitController.bodyIndex.value == 4 ?
      //                               // bloodSugarController.filterLists[index].bodyTemperature :
      //                               // (bloodSugarController.filterLists[index].bodyTemperature * 9 / 5) + 32}',
      //                               text: convertBodyTemperature(
      //                                 bloodSugarController.filterLists[index].bodyTemperature,
      //                                 bodyTemperatureController.newValue.value,
      //                                 // unitController.getGlucoseLevelPreference()
      //                               ),
      //                               style: TextStyle(
      //                                   fontSize: 28,
      //                                   color: ConstColour.textColor,
      //                                   fontFamily: ConstFont.bold
      //                               ),
      //                             ),
      //                             TextSpan(
      //                               // text: " ${unitController.bodyIndex.value == 4 ? '℃' : 'ºf'}",
      //                               text: " ${bodyTemperatureController.newValue.value == true ? '℃' : 'ºf'}",
      //                               style: TextStyle(
      //                                   fontSize: 12,
      //                                   color: ConstColour.greyTextColor,
      //                                   fontFamily: ConstFont.regular
      //                               ),
      //                             ),
      //                           ],
      //                         ),
      //                       ),
      //                     );
      //                   },
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ),
      //       ),
      //     );
      //   }},
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
    TimeOfDay currentTime = TimeOfDay.now();
    dateTimeController.selectedTime.value = currentTime;
    String formattedHour = currentTime.hourOfPeriod.toString();
    String formattedMinute = currentTime.minute.toString().padLeft(2, '0');
    String period = currentTime.period == DayPeriod.am ? 'AM' : 'PM';
    String formattedTime = '$formattedHour:$formattedMinute $period';
    dateTimeController.formattedTime.value = formattedTime;

    // dateTimeController.formattedTime.value = dateTimeController.formatTimeOfDay(TimeOfDay.now());
    bodyTemperatureController.temperatureController.text = "";
    bodyTemperatureController.temperatureCommentController.text = "";
    Get.to(() => BodyTemperatureScreen());
  }

  String convertBodyTemperature(double value, bool temperature) {
    if (temperature == false) {
    // °F = (9/5 × °C) + 32.
    // °C = (°F - 32) × 5/9
      double convertedValue = (9 / 5 * value) + 32; // Celsius to Fahrenheit
      print(convertedValue.toString() + "value");
      // double convertedValue = (value - 32) * 5 / 9; // Fahrenheit to Celsius
      return convertedValue.toStringAsFixed(2);
    } else {
      print(value.toString()+"else call");
      return value.toStringAsFixed(2);
    }
  }


}
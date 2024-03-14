import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_care_dairy/Controller/date_time_controller.dart';
import 'package:health_care_dairy/Screens/Blood_pressure/blood_pressure_second_screen.dart';
import 'package:health_care_dairy/Screens/Blood_pressure/edit_blood_pressure_screen.dart';

import '../../ConstFile/constColors.dart';
import '../../ConstFile/constFonts.dart';
import '../../Controller/blood_pressure_controller.dart';
import '../../Controller/blood_sugar_controller.dart';
import '../../Controller/delete_controller.dart';
import '../../Controller/filter_controller.dart';
import '../../model/get_category_model.dart';
import '../discription_screen.dart';
import '../home_screen.dart';
import '../loader.dart';

class BloodPressure extends StatefulWidget {
  final String id;
  BloodPressure({super.key, required this.id});

  @override
  State<BloodPressure> createState() => _BloodPressureState();
}

class _BloodPressureState extends State<BloodPressure> {
  FilterController filterController = Get.put(FilterController());
  DeleteController deleteController = Get.put(DeleteController());
  DateTimeController dateTimeController = Get.put(DateTimeController());
  BloodPressureController bloodPressureController = Get.put(BloodPressureController());
  BloodSugarController bloodSugarController = Get.put(BloodSugarController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // bloodSugarController.updateCatId(widget.id.toString());
    // bloodPressureController.updateCatId(widget.id.toString());
    // print("pressureScreen catid"+widget.id.toString());
    // setState(() {
    //   bloodSugarController.getCategoryList();
    // });
    loadBloodPressureData();
  }

  Future<void> loadBloodPressureData() async {
    await Future.delayed(Duration(seconds: 3));

    if (mounted) {
      setState(() {
        bloodSugarController.isLoading.value = false;
      });

      bloodSugarController.updateCatId(widget.id.toString());
      bloodPressureController.updateCatId(widget.id.toString());
      print("pressureScreen catid" + widget.id.toString());
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
          () => Text(
            deleteController.flag.value == true
                ? "${deleteController.selectedIndices.length} selected"
                : "Blood Pressure",
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
            // Get.to(() => HomeScreen());
            Get.back();
          },
          icon: Icon(Icons.arrow_back),
          color: ConstColour.textColor,
        ),
        actions: [
          IconButton(
              onPressed: () {
                Get.to(() => DiscriptionScreen(
                  title: 'Blood pressure',
                  description: 'Blood pressure (BP) is the pressure of circulating blood against the walls of blood vessels. \n\nBlood Pressure one of the vital signs - together with respiratory rate, heart rate, oxygen saturation, and body temperature - that healthcare professionals use in evaluating a patients health.\n\nBlood pressure below 120/80 mm Hg is considered to be normal.',
                  detailedDescription: '• Normal Blood Pressure : \n   - 127/79 mmHg in men \n   - 122/77 mmHg in women \n\n• High Blood Pressure : \n   - Range 140/90 mm Hg \n\n• Low Blood Pressure : \n   - 90/60 mm Hg or below.',
                ));
              },
              icon: Image.asset("assets/Icons/information.png")),
          Obx(() =>  IconButton(
              onPressed: () {
                if(deleteController.flag.value == true) {
                  deleteController.flag.value = false;
                  deleteController.deleteDialog("Are you sure, you want to delete this Blood Pressure Record?");
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
                height: deviceHeight * 0.03,)
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
                bloodSugarController.bloodSugarLists.isEmpty
                ? ((bloodSugarController.isLoading.value == true))
                    ? Center(
                  child: Column(
                    children: [
                      Text(
                        "No Record Found",
                        style: TextStyle(
                            fontSize: 30,
                            color: ConstColour.textColor,
                            fontFamily: ConstFont.regular
                        ),
                      )
                    ],
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
                            subtitle: Container(
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
                  controller: ScrollController(),
                  shrinkWrap: true,
                  itemCount:bloodSugarController.bloodSugarLists.length ,
                  itemBuilder: (BuildContext context, int index) {
                    String prvIndexDate = "";
                    String currentIndexDate = bloodSugarController.bloodSugarLists[index].dateTime.substring(3);
                    if(index > 0) {
                      prvIndexDate = bloodSugarController.bloodSugarLists[(index - 1)].dateTime.substring(3);
                    } else {
                      prvIndexDate = bloodSugarController.bloodSugarLists[index].dateTime.substring(3);
                    }
                    List<CategoryList> monthRecords = [];
                    String monthYear = "";
                    if(currentIndexDate != prvIndexDate) {
                      monthYear = bloodSugarController.bloodSugarLists[index].dateTime.substring(3);
                      monthRecords = bloodSugarController.bloodSugarLists.where((record) => record.dateTime.substring(3) == monthYear).toList();
                    } else {
                      if(index == 0) {
                        monthYear = bloodSugarController.bloodSugarLists[index].dateTime.substring(3);
                        monthRecords = bloodSugarController.bloodSugarLists.where((record) => record.dateTime.substring(3) == monthYear).toList();
                      }
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        monthYear.isNotEmpty
                            ? Padding(
                          padding: EdgeInsets.only(
                              top: deviceHeight * 0.01,
                              bottom: deviceHeight * 0.01),
                          child: Text(
                            bloodSugarController.formatDate(monthYear),
                            style: TextStyle(
                                fontSize: 25,
                                color: ConstColour.buttonColor,
                                fontFamily: ConstFont.bold),
                          ),
                        ): SizedBox(),
                        ListView.builder(
                          reverse: false,
                          controller: ScrollController(),
                          shrinkWrap: true,
                          itemCount: monthRecords.length,
                          itemBuilder: (context, index) {
                            return Container(
                              color: deleteController.selectedIndices.contains(index) ? ConstColour.buttonColor.withOpacity(0.5) : ConstColour.appColor,
                              child: ListTile(
                                onTap: () {
                                  bloodPressureController.pressureId.value = monthRecords[index].id.toInt();
                                  // bloodSugarController.getEditBloodSugarList(widget.id.toString());
                                  Get.to(() => UpdateBloodPressureScreen(
                                    catId: monthRecords[index].id.toString(),
                                  ));
                                },
                                onLongPress: () {
                                  setState(() {
                                    if (deleteController.selectedIndices.contains(index)) {
                                      deleteController.selectedIndices.remove(index);
                                      print("if");
                                    } else {
                                      deleteController.flag.value = true;
                                      deleteController.selectedIndices.add(index);
                                      print("else");
                                    }
                                  });
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
                                title: Text(
                                  monthRecords[index].hand == null
                                      ? "No data"
                                      : (monthRecords[index].hand == true ? "Left Hand" : "Right Hand"),
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: ConstColour.textColor,
                                      fontFamily: ConstFont.regular
                                  ),
                                ),
                                subtitle: Row(
                                  children: [
                                    Text(
                                      monthRecords[index].dateTime,
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: ConstColour.greyTextColor,
                                          fontFamily: ConstFont.regular
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: deviceWidth * 0.03),
                                      child: Text(
                                        monthRecords[index].time.toString(),
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
                                            text: monthRecords[index].diastolicPressure.toString(),
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
                                            text: monthRecords[index].systolicPressure.toString(),
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
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  },
                    ),
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
      //                 child: bloodSugarController.bloodSugarLists.isEmpty
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
      //                   itemCount: bloodSugarController.bloodSugarLists.length,
      //                   itemBuilder: (context, index) {
      //                     return ListTile(
      //                       onTap: () {
      //                         bloodPressureController.pressureId.value = bloodSugarController.bloodSugarLists[index].id.toInt();
      //                         // bloodSugarController.getEditBloodSugarList(widget.id.toString());
      //                         Get.to(() => UpdateBloodPressureScreen(
      //                           catId: bloodSugarController.bloodSugarLists[index].id.toString(),
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
      //                       title: Text(
      //                         bloodSugarController.bloodSugarLists[index].hand == null
      //                             ? "No data"
      //                             : (bloodSugarController.bloodSugarLists[index].hand == true ? "Left Hand" : "Right Hand"),
      //                         style: TextStyle(
      //                             fontSize: 20,
      //                             color: ConstColour.textColor,
      //                             fontFamily: ConstFont.regular
      //                         ),
      //                       ),
      //                       subtitle: Row(
      //                         children: [
      //                           Text(
      //                             bloodSugarController.bloodSugarLists[index].dateTime,
      //                             style: TextStyle(
      //                                 fontSize: 16,
      //                                 color: ConstColour.greyTextColor,
      //                                 fontFamily: ConstFont.regular
      //                             ),
      //                           ),
      //                           Padding(
      //                             padding: EdgeInsets.only(left: deviceWidth * 0.03),
      //                             child: Text(
      //                               bloodSugarController.bloodSugarLists[index].time.toString(),
      //                               style: TextStyle(
      //                                   fontSize: 16,
      //                                   color: ConstColour.greyTextColor,
      //                                   fontFamily: ConstFont.regular
      //                               ),
      //                             ),
      //                           ),
      //                         ],
      //                       ),
      //                       trailing: Column(
      //                         children: [
      //                           RichText(
      //                             text: TextSpan(
      //                               children: <TextSpan>[
      //                                 TextSpan(
      //                                   text: 'Diastolic  ',
      //                                   style: TextStyle(
      //                                       fontSize: 15,
      //                                       color: ConstColour.greyTextColor,
      //                                       fontFamily: ConstFont.regular
      //                                   ),
      //                                 ),
      //                                 TextSpan(
      //                                   text: bloodSugarController.bloodSugarLists[index].diastolicPressure.toString(),
      //                                   style: TextStyle(
      //                                       fontSize: 22,
      //                                       color: ConstColour.textColor,
      //                                       fontFamily: ConstFont.bold
      //                                   ),
      //                                 ),
      //                               ],
      //                             ),
      //                           ),
      //                           RichText(
      //                             text: TextSpan(
      //                               children: <TextSpan>[
      //                                 TextSpan(
      //                                   text: 'Systolic  ',
      //                                   style: TextStyle(
      //                                       fontSize: 15,
      //                                       color: ConstColour.greyTextColor,
      //                                       fontFamily: ConstFont.regular
      //                                   ),
      //                                 ),
      //                                 TextSpan(
      //                                   text: bloodSugarController.bloodSugarLists[index].systolicPressure.toString(),
      //                                   style: TextStyle(
      //                                       fontSize: 22,
      //                                       color: ConstColour.textColor,
      //                                       fontFamily: ConstFont.bold
      //                                   ),
      //                                 ),
      //                               ],
      //                             ),
      //                           ),
      //                         ],
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
      //   }
      // }
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
    bloodPressureController.systolicPressureController.text = "";
    bloodPressureController.diastolicPressureController.text = "";
    bloodPressureController.pulesRateController.text = "";
    bloodPressureController.pressureCommentController.text = "";
    Get.to(() => BloodPressureScreen());
  }
}
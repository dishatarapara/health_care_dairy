import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_care_dairy/ConstFile/constColors.dart';
import 'package:health_care_dairy/Controller/blood_sugar_controller.dart';
import 'package:health_care_dairy/Controller/date_time_controller.dart';
import 'package:health_care_dairy/Controller/delete_controller.dart';
import 'package:health_care_dairy/Controller/filter_controller.dart';
import 'package:health_care_dairy/Controller/unit_controller.dart';
import 'package:health_care_dairy/Screens/Blood_Sugar/blood_sugar_add_screen.dart';
import 'package:health_care_dairy/Screens/Blood_Sugar/edit_blood_sugar_screen.dart';
import 'package:health_care_dairy/model/get_category_model.dart';

import '../../Common/bottom_button.dart';
import '../../ConstFile/constFonts.dart';
import '../discription_screen.dart';
import '../loader.dart';

class BloodSugar extends StatefulWidget {
  final String id;
   BloodSugar( {super.key ,required this.id});

  @override
  State<BloodSugar> createState() => _BloodSugarState();
}

class _BloodSugarState extends State<BloodSugar> {
  FilterController filterController = Get.put(FilterController());
  DeleteController deleteController = Get.put(DeleteController());
  UnitController unitController = Get.put(UnitController());
  BloodSugarController bloodSugarController = Get.put(BloodSugarController());
  FilterController filterController = Get.put(FilterController());
  DateTimeController dateTimeController = Get.put(DateTimeController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // bloodSugarController.updateCatId(widget.id.toString());
    // print("sugarscreen catid"+widget.id.toString());
    // setState(() {
    //   bloodSugarController.getCategoryList();
    // });
    // setState(() {
    //   bloodSugarController.updateCatId(widget.id.toString());
    //   bloodSugarController.categoryIdDetails();
    // //  bloodSugarLists.addAll(bloodSugarController.bloodSugarLists.value);
    // });
    loadBloodSugarData();

  }

  Future<void> loadBloodSugarData() async {
    // bloodSugarController.isLoading.value = true;
    await Future.delayed(Duration(seconds: 3));

    if (mounted) {
      setState(() {
        bloodSugarController.isLoading.value = false;
      });

      bloodSugarController.updateCatId(widget.id.toString());
      print("sugarscreen catid" + widget.id.toString());
      // weightController.setPref();
      bloodSugarController.getCategoryList();

    }
  }

  // String formatDate(String dateString) {
  //   final dateTime = DateFormat('MM/yyyy').parse(dateString);
  //   final formattedDate = DateFormat('MMM, yyyy').format(dateTime);
  //   return formattedDate;
  // }

  @override
  Widget build(BuildContext context) {

    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ConstColour.appColor,
        elevation: 0.0,
        title: Obx(
          () =>  Text(deleteController.flag.value == true
              ? "${deleteController.selectedIndices.length} selected"
              : "Blood Sugar",
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
                  Get.to(() =>  DiscriptionScreen(
                    title: 'Blood Sugar',
                    description: 'The blood sugar level, blood sugar concentration, or blood glucose level is the measure of concentration of glucose present in the blood of humans or other animals. \n\nApproximately 4 grams of glucose, a simple sugar, is present in the blood of a 70 kg(154 lb) human at all times.',
                    detailedDescription:' • Normal Blood Sugar :\n   - 4.4 to 6.1 mmol/L (79 to 110 mg/dL) \n\n • High Blood Sugar :\n   - 16.7 mmol/L (300 mg/dL) \n\n • Low Blood Sugar :\n   - below 70 mg/dL (3.9 mmol/L).',
                  ));
                },
                icon: Image.asset("assets/Icons/information.png")
            ),
          Obx(() =>  IconButton(
                onPressed: () {
                  if(deleteController.flag.value == true) {
                    deleteController.flag.value = false;
                    deleteController.deleteDialog("Are you sure, you want to delete this Blood Sugar Record?");
                  } else {
                    filterController.showDialogBox();
                  }
                },
                icon: deleteController.flag.value == true
                    ? Icon(
                    Icons.delete,
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
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text(
                //   'May, 2024',
                //   style: TextStyle(
                //       fontSize: 25,
                //       color: ConstColour.buttonColor,
                //       fontFamily: ConstFont.bold
                //   ),
                // ),
                bloodSugarController.bloodSugarLists.isEmpty
                ? (bloodSugarController.isLoading.value == true)
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
                  itemCount:bloodSugarController.bloodSugarLists.length,
                  itemBuilder: (BuildContext context, int idx) {
                    String prvIndexDate = "";
                    String currentIndexDate = bloodSugarController.bloodSugarLists[idx].dateTime.substring(3);
                   if(idx > 0) {
                      prvIndexDate = bloodSugarController.bloodSugarLists[(idx - 1)].dateTime.substring(3);
                   } else {
                      prvIndexDate = bloodSugarController.bloodSugarLists[idx].dateTime.substring(3);
                   }
                    List<CategoryList> monthRecords = [];
                    String monthYear = "";
                   if(currentIndexDate != prvIndexDate) {
                      monthYear = bloodSugarController.bloodSugarLists[idx].dateTime.substring(3);
                     monthRecords = bloodSugarController.bloodSugarLists.where((record) => record.dateTime.substring(3) == monthYear).toList();
                   } else {
                     if(idx == 0) {
                       monthYear = bloodSugarController.bloodSugarLists[idx].dateTime.substring(3);
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
                        )
                            : SizedBox(),
                        ListView.builder(
                          reverse: false,
                          controller: ScrollController(),
                          shrinkWrap: true,
                          itemCount: monthRecords.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
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
                              child: Container(
                                color: deleteController.selectedIndices.contains(index)
                                    ? ConstColour.buttonColor.withOpacity(0.5)
                                    : ConstColour.appColor,
                                child: ListTile(
                                  selected: deleteController.selectedIndices.contains(index),
                                  onTap: () {
                                    bloodSugarController.sugarId.value = monthRecords[index].id.toInt();
                                    // bloodSugarController.getEditBloodSugarList(widget.id.toString());
                                    Get.to(() => UpdateBloodSugarScreen(
                                        catId: monthRecords[index].id.toString()
                                    ));
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
                                  title: Text(monthRecords[index].measuredTypeName == null
                                      ? "Before Breakfast"
                                      : monthRecords[index].measuredTypeName,
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: ConstColour.textColor,
                                        fontFamily: ConstFont.regular
                                    ),
                                  ),
                                  subtitle: Padding(
                                    padding: EdgeInsets.only(top: deviceHeight * 0.01),
                                    child: Row(
                                      children: [
                                        Text(monthRecords[index].dateTime,
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: ConstColour.greyTextColor,
                                              fontFamily: ConstFont.regular
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: deviceWidth * 0.02),
                                          child: Text(monthRecords[index].time.toString(),
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
                                  trailing: RichText(
                                    text: TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                          // text: bloodSugarController.bloodSugarLists[index].bloodGlucose.toString(),
                                          text: convertBloodSugarValue(
                                            monthRecords[index].bloodGlucose,
                                            unitController.getGlucoseLevelPreference(),
                                          ),
                                          style: TextStyle(
                                              fontSize: 25,
                                              color: ConstColour.textColor,
                                              fontFamily: ConstFont.bold
                                          ),
                                        ),
                                        TextSpan(
                                          text: unitController.getGlucoseLevelPreference() ? ' mmol/L' : ' mg/dL',
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
      //                       child: Center(
      //                           child: CircularProgressIndicator(
      //                             color: ConstColour.buttonColor,
      //                       )),
      //                     )
      //                     : ListView.builder(
      //                   reverse: true,
      //                   controller: ScrollController(),
      //                   shrinkWrap: true,
      //                   itemCount: bloodSugarController.bloodSugarLists.length,
      //                   itemBuilder: (context, index) {
      //                     return ListTile(
      //                       onTap: () {
      //                         bloodSugarController.sugarId.value = bloodSugarController.bloodSugarLists[index].id.toInt();
      //                         // bloodSugarController.getEditBloodSugarList(widget.id.toString());
      //                         Get.to(() => UpdateBloodSugarScreen(
      //                             catId: bloodSugarController.bloodSugarLists[index].id.toString()
      //                         ));
      //                       },
      //                       onLongPress: () {
      //                         showDialog(
      //                             context: context,
      //                             builder: (context) => AlertDialog(
      //                               backgroundColor: ConstColour.buttonColor,
      //                               actions: [
      //                                 IconButton(
      //                                     onPressed: () {
      //                                       bloodSugarController.bloodSugarLists.removeAt(index);
      //                                       setState(() {
      //                                         Navigator.pop(context);
      //                                       });
      //                                     },
      //                                     icon: Icon(
      //                                       Icons.check,
      //                                       color: ConstColour.appColor,
      //                                     )
      //                                 )
      //                               ],
      //                             ));
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
      //                       title: Text(bloodSugarController.bloodSugarLists[index].measuredTypeName == null
      //                           ? "Before Breakfast"
      //                           : bloodSugarController.bloodSugarLists[index].measuredTypeName,
      //                         style: TextStyle(
      //                             fontSize: 20,
      //                             color: ConstColour.textColor,
      //                             fontFamily: ConstFont.regular
      //                         ),
      //                       ),
      //                       subtitle: Padding(
      //                         padding: EdgeInsets.only(
      //                             top: deviceHeight * 0.01
      //                         ),
      //                         child: Row(
      //                           children: [
      //                             Text(bloodSugarController.bloodSugarLists[index].dateTime,
      //                               style: TextStyle(
      //                                   fontSize: 16,
      //                                   color: ConstColour.greyTextColor,
      //                                   fontFamily: ConstFont.regular
      //                               ),
      //                             ),
      //                             Padding(
      //                               padding: EdgeInsets.only(left: deviceWidth * 0.02),
      //                               child: Text(bloodSugarController.bloodSugarLists[index].time.toString(),
      //                                 style: TextStyle(
      //                                     fontSize: 16,
      //                                     color: ConstColour.greyTextColor,
      //                                     fontFamily: ConstFont.regular
      //                                 ),
      //                               ),
      //                             ),
      //                           ],
      //                         ),
      //                       ),
      //                       trailing: RichText(
      //                         text: TextSpan(
      //                           children: <TextSpan>[
      //                             TextSpan(
      //                               // text: bloodSugarController.bloodSugarLists[index].bloodGlucose.toString(),
      //                               text: convertBloodSugarValue(
      //                                 bloodSugarController.bloodSugarLists[index].bloodGlucose,
      //                                 unitController.getGlucoseLevelPreference(),
      //                               ),
      //                               style: TextStyle(
      //                                   fontSize: 25,
      //                                   color: ConstColour.textColor,
      //                                   fontFamily: ConstFont.bold
      //                               ),
      //                             ),
      //                             TextSpan(
      //                               text: unitController.getGlucoseLevelPreference() ? ' mmol/L' : ' mg/dL',
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
      //         // Padding(
      //         //   padding: const EdgeInsets.all(8.0),
      //         //   child: Visibility(
      //         //     visible: bloodSugarController.isLoading.value,
      //         //     child: Center(
      //         //       child: CircularProgressIndicator(
      //         //         color: ConstColour.buttonColor,
      //         //       ),
      //         //     ),
      //         //     replacement: RefreshIndicator(
      //         //       onRefresh: () {
      //         //         return navigateToAddPage();
      //         //       },
      //         //       child: Visibility(
      //         //         // visible: bloodSugarController,
      //         //         replacement: Center(
      //         //             child: Text(
      //         //               "No Todo Item",
      //         //               style: Theme.of(context).textTheme.headline2,
      //         //             ),
      //         //         ),
      //         //         child: ListView.builder(
      //         //           itemBuilder: (context, index) {
      //         //             return Padding(
      //         //               padding: const EdgeInsets.all(8.0),
      //         //               child: Visibility(
      //         //                 visible: bloodSugarController.isLoading.value,
      //         //                 child: Column(
      //         //                   children: [
      //         //                     Container(
      //         //                       decoration: BoxDecoration(
      //         //                           color: ConstColour.appColor
      //         //                       ),
      //         //                       child: ListTile(
      //         //                         title: Text(
      //         //                           "Before breakfast",
      //         //                           style: TextStyle(
      //         //                               fontSize: 20,
      //         //                               color: ConstColour.textColor,
      //         //                               fontFamily: ConstFont.regular
      //         //                           ),
      //         //                         ),
      //         //                         subtitle: Row(
      //         //                           children: [
      //         //                             Text(
      //         //                               "10/02/2024",
      //         //                               style: TextStyle(
      //         //                                   fontSize: 16,
      //         //                                   color: ConstColour.greyTextColor,
      //         //                                   fontFamily: ConstFont.regular
      //         //                               ),
      //         //                             ),
      //         //                             Padding(
      //         //                               padding: EdgeInsets.only(left: deviceWidth * 0.03),
      //         //                               child: Text(
      //         //                                 "05:47pm",
      //         //                                 style: TextStyle(
      //         //                                     fontSize: 16,
      //         //                                     color: ConstColour.greyTextColor,
      //         //                                     fontFamily: ConstFont.regular
      //         //                                 ),
      //         //                               ),
      //         //                             ),
      //         //                           ],
      //         //                         ),
      //         //                         trailing: RichText(
      //         //                           text: TextSpan(
      //         //                             children: <TextSpan>[
      //         //                               TextSpan(
      //         //                                 text: '585',
      //         //                                 style: TextStyle(
      //         //                                     fontSize: 28,
      //         //                                     color: ConstColour.textColor,
      //         //                                     fontFamily: ConstFont.bold
      //         //                                 ),
      //         //                               ),
      //         //                               TextSpan(
      //         //                                 text: '  mg/dL',
      //         //                                 style: TextStyle(
      //         //                                     fontSize: 12,
      //         //                                     color: ConstColour.greyTextColor,
      //         //                                     fontFamily: ConstFont.regular
      //         //                                 ),
      //         //                               ),
      //         //                             ],
      //         //                           ),
      //         //                         ),
      //         //                       ),
      //         //                     ),
      //         //                   ],
      //         //                 ),
      //         //               ),
      //         //             );
      //         //           },
      //         //         ),
      //         //       ),
      //         //     ),
      //         //   ),
      //         // ),
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
      // floatingActionButton: Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: FloatingActionButton(
      //     onPressed: navigateToAddPage,
      //     child: bloodSugarController.isLoading.value
      //         ? CircularProgressIndicator(
      //       color: ConstColour.buttonColor,
      //     )
      //         : Icon(Icons.add),
      //     backgroundColor: ConstColour.buttonColor,
      //   ),
      // ),
    );
  }

  Future<void> navigateToAddPage() async {
    // setState(() {
    //   bloodSugarController.isLoading.value = true;
    // });
    //
    // Future.delayed(Duration(seconds: 3), () {
    //   setState(() {
    //     bloodSugarController.isLoading.value = false;
    //   });
    // },);
    dateTimeController.selectedDate.value =  DateTime.now();
    TimeOfDay currentTime = TimeOfDay.now();
    dateTimeController.selectedTime.value = currentTime;
    String formattedHour = currentTime.hourOfPeriod.toString();
    String formattedMinute = currentTime.minute.toString().padLeft(2, '0');
    String period = currentTime.period == DayPeriod.am ? 'AM' : 'PM';
    String formattedTime = '$formattedHour:$formattedMinute $period';
    dateTimeController.formattedTime.value = formattedTime;

    // dateTimeController.formattedTime.value = dateTimeController.formatTimeOfDay(TimeOfDay.now());
    bloodSugarController.measuredType.value = "Before Breakfast";
    bloodSugarController.measuredId.value = 1;
    bloodSugarController.bloodGlucoseController.text = "";
    bloodSugarController.commentController.text = "";
    // unitController.glucoseLevel.value = !unitController.glucoseLevel.value;
    Get.to(() => BloodSugarAddScreen());
  }

  String convertBloodSugarValue(double value, bool glucoseLevel) {
    if (glucoseLevel) {
      double convertedValue = value / 18; // Convert mol/L to mg/dL
      return convertedValue.toStringAsFixed(2);
      // mol/L = mg/dl / 18
    } else {
      return value.toStringAsFixed(2);
      // double convertedValue = value * 18; // Convert mg/dL to mmol/L
      // return convertedValue.toStringAsFixed(1);
      // mg/dl = mmol/L x 18
    }
  }
}


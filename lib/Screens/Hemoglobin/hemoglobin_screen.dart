import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_care_dairy/Controller/date_time_controller.dart';
import 'package:health_care_dairy/Controller/hemoglobin_controller.dart';
import 'package:health_care_dairy/Controller/unit_controller.dart';
import 'package:health_care_dairy/Screens/Hemoglobin/edit_hemoglobin_screen.dart';

import '../../ConstFile/constColors.dart';
import '../../ConstFile/constFonts.dart';
import '../../Controller/blood_sugar_controller.dart';
import '../../Controller/delete_controller.dart';
import '../../Controller/filter_controller.dart';
import '../../model/get_category_model.dart';
import '../discription_screen.dart';
import '../home_screen.dart';
import '../loader.dart';
import 'hemoglobin_second_screen.dart';

class Hemoglobin extends StatefulWidget {
  final String id;
  const Hemoglobin({super.key, required this.id});

  @override
  State<Hemoglobin> createState() => _HemoglobinState();
}

class _HemoglobinState extends State<Hemoglobin> {
  FilterController filterController = Get.put(FilterController());
  DeleteController deleteController = Get.put(DeleteController());
  DateTimeController dateTimeController = Get.put(DateTimeController());
  UnitController unitController = Get.put(UnitController());
  A1CController a1cController = Get.put(A1CController());
  BloodSugarController bloodSugarController = Get.put(BloodSugarController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // bloodSugarController.updateCatId(widget.id.toString());
    // a1cController.updateCatId(widget.id.toString());
    // print("HemoglobinScreen catid"+widget.id.toString());
    //
    // setState(() {
    //   bloodSugarController.getCategoryList();
    // });
    loadHemoglobinData();
  }

  Future<void> loadHemoglobinData() async {
    await Future.delayed(Duration(seconds: 3));

    if (mounted) {
      setState(() {
        bloodSugarController.isLoading.value = false;
      });

      bloodSugarController.updateCatId(widget.id.toString());
      a1cController.updateCatId(widget.id.toString());
      print("HemoglobinScreen catid" + widget.id.toString());
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
              : "Hemoglobin (A1C)",
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
                    title: 'Hemoglobin',
                    description: 'Hemoglobin, or haemoglobin, abbreviated Hb or Hgd, is the iron-containing oxygen-transport metalloprotein in the red blood cells of almost all vertebrates as well as the tissues of some invertebrates. Hemoglobin in blood carries oxygen from the lungs or gills to the rest of the body.  \n\nHemoglobin functions by binding and transporting oxygen from the capillaries in the lungs to all of the tissues of the body back to yhe lungs.',
                    detailedDescription: '• Normal Hemoglobin : \n Male: 13.8 to 17.2 grams per deciliter(g/dl) or 138 to 172 grams per liter(g/l). \n Female: 12.1 to 15.1g/dL or 121 to 151g/L.  \n\n\n• Lower than normal results : \n   If Lower then normal have some form of anemia. \n   - Iron deficiency \n   - Vitamin B-12 deficiency \n   - Folate deficiency \n   - Bleeding \n   - Kidney disease \n   - Liver disease \n   - Hypothyroidism \n   - Thalassemia.  \n\n\n• Higher than normal results : \n   If higher then normal, may be the result of: \n   - Polycythemia vera \n   - Lung disease \n   - Dehydration \n   - Living at a high altitude \n   - Heavy smoking \n   - Burns \n   - Excessive vomiting \n   - Exterme physical exercise.'
                )
                );
              },
              icon: Image.asset("assets/Icons/information.png")),
          Obx(() =>  IconButton(
              onPressed: () {
                if(deleteController.flag.value == true) {
                  deleteController.flag.value = false;
                  deleteController.deleteDialog("Are you sure, you want to delete this A1C Record?");
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
                    : ListView.builder(controller: ScrollController(),
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
                              color: deleteController.selectedIndices.contains(index)
                                  ? ConstColour.buttonColor.withOpacity(0.5)
                                  : ConstColour.appColor,
                              child: ListTile(
                                onTap: () {
                                  a1cController.hemoglobinId.value = monthRecords[index].id.toInt();
                                  // bloodSugarController.getEditBloodSugarList(widget.id.toString());
                                  Get.to(() => UpdateHemoglobinScreen(
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
                                      padding: EdgeInsets.only(left: deviceWidth * 0.02),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: "A1C  ",
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: ConstColour.greyTextColor,
                                                fontFamily: ConstFont.regular
                                            ),
                                          ),
                                          TextSpan(
                                            text: monthRecords[index].averageSugarConcentration.toString(),
                                            style: TextStyle(
                                              fontSize: 22,
                                              color: ConstColour.textColor,
                                              fontFamily: ConstFont.bold,
                                            ),
                                          ),
                                          TextSpan(
                                            text: " %",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: ConstColour.greyTextColor,
                                                fontFamily: ConstFont.regular
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: "eAG  ",
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: ConstColour.greyTextColor,
                                                fontFamily: ConstFont.regular
                                            ),
                                          ),
                                          TextSpan(
                                            text: convertBloodSugarValue(
                                              monthRecords[index].averageSugarConcentration,
                                              unitController.getGlucoseLevelPreference(),
                                            ),
                                            style: TextStyle(
                                                fontSize: 22,
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
      //                       child: Center(
      //                         child: CircularProgressIndicator(
      //                           color: ConstColour.buttonColor,
      //                         ),
      //                       ),
      //                     )
      //                     : ListView.builder(
      //                   reverse: true,
      //                   controller: ScrollController(),
      //                   shrinkWrap: true,
      //                   itemCount: bloodSugarController.bloodSugarLists.length,
      //                   itemBuilder: (context, index) {
      //                     return ListTile(
      //                       onTap: () {
      //                         a1cController.hemoglobinId.value = bloodSugarController.bloodSugarLists[index].id.toInt();
      //                         // bloodSugarController.getEditBloodSugarList(widget.id.toString());
      //                         Get.to(() => UpdateHemoglobinScreen(
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
      //                             padding: EdgeInsets.only(left: deviceWidth * 0.02),
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
      //                                   text: "A1C  ",
      //                                   style: TextStyle(
      //                                       fontSize: 13,
      //                                       color: ConstColour.greyTextColor,
      //                                       fontFamily: ConstFont.regular
      //                                   ),
      //                                 ),
      //                                 TextSpan(
      //                                   text: bloodSugarController.bloodSugarLists[index].averageSugarConcentration.toString(),
      //                                   style: TextStyle(
      //                                     fontSize: 22,
      //                                     color: ConstColour.textColor,
      //                                     fontFamily: ConstFont.bold,
      //                                   ),
      //                                 ),
      //                                 TextSpan(
      //                                   text: " %",
      //                                   style: TextStyle(
      //                                       fontSize: 12,
      //                                       color: ConstColour.greyTextColor,
      //                                       fontFamily: ConstFont.regular
      //                                   ),
      //                                 ),
      //                               ],
      //                             ),
      //                           ),
      //                           RichText(
      //                             text: TextSpan(
      //                               children: <TextSpan>[
      //                                 TextSpan(
      //                                   text: "eAG  ",
      //                                   style: TextStyle(
      //                                       fontSize: 13,
      //                                       color: ConstColour.greyTextColor,
      //                                       fontFamily: ConstFont.regular
      //                                   ),
      //                                 ),
      //                                 TextSpan(
      //                                   text: convertBloodSugarValue(
      //                                     bloodSugarController.bloodSugarLists[index].averageSugarConcentration,
      //                                     unitController.getGlucoseLevelPreference(),
      //                                   ),
      //                                   style: TextStyle(
      //                                       fontSize: 22,
      //                                       color: ConstColour.textColor,
      //                                       fontFamily: ConstFont.bold
      //                                   ),
      //                                 ),
      //                                 TextSpan(
      //                                   text: unitController.getGlucoseLevelPreference() ? ' mmol/L' : ' mg/dL',
      //                                   style: TextStyle(
      //                                       fontSize: 12,
      //                                       color: ConstColour.greyTextColor,
      //                                       fontFamily: ConstFont.regular
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
    a1cController.averageSugarController.text = "";
    a1cController.a1cCommentController.text = "";
    Get.to(() => HemoglobinScreen());
  }

  String convertBloodSugarValue(double value, bool glucoseLevel) {
    if (glucoseLevel) {
      double convertedValue = value / 18; // Convert mmol/L to mg/dL
      return convertedValue.toStringAsFixed(1);
    } else {
      return value.toStringAsFixed(1);
    }
  }
}
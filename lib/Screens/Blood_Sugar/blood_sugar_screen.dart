import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_care_dairy/ConstFile/constColors.dart';
import 'package:health_care_dairy/Controller/blood_sugar_controller.dart';
import 'package:health_care_dairy/Controller/date_time_controller.dart';
import 'package:health_care_dairy/Controller/filter_Controller.dart';
import 'package:health_care_dairy/Controller/unit_controller.dart';
import 'package:health_care_dairy/Screens/Blood_Sugar/blood_sugar_add_screen.dart';
import 'package:health_care_dairy/Screens/Blood_Sugar/edit_blood_sugar_screen.dart';


import '../../Common/bottom_button.dart';
import '../../ConstFile/constFonts.dart';
import '../home_screen.dart';

class BloodSugar extends StatefulWidget {
  final String id;
   BloodSugar( {super.key ,required this.id});

  @override
  State<BloodSugar> createState() => _BloodSugarState();
}

class _BloodSugarState extends State<BloodSugar> {
  UnitController unitController = Get.put(UnitController());
  BloodSugarController bloodSugarController = Get.put(BloodSugarController());
  FilterController filterController = Get.put(FilterController());
  DateTimeController dateTimeController = Get.put(DateTimeController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloodSugarController.updateCatId(widget.id.toString());
    print("sugarscreen catid"+widget.id.toString());
    setState(() {
      bloodSugarController.getCategoryList();
    });
    // setState(() {
    //   bloodSugarController.updateCatId(widget.id.toString());
    //   bloodSugarController.categoryIdDetails();
    // //  bloodSugarLists.addAll(bloodSugarController.bloodSugarLists.value);
    // });
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
            "Blood Sugar",
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
        actions: [
          IconButton(
              onPressed: () => bloodSugarController.showDialogBox(context),
              icon: Image.asset("assets/Icons/filter.png")),
        ],
      ),
      backgroundColor: ConstColour.bgColor,
      body: RefreshIndicator(
        color: ConstColour.buttonColor,
        onRefresh: () async {
          await bloodSugarController.getCategoryList();
        },
        child: Obx(
          () => SingleChildScrollView(
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
                          ? Center(child: CircularProgressIndicator(
                        color: ConstColour.buttonColor,
                      ))
                          : ListView.builder(
                        reverse: true,
                        controller: ScrollController(),
                        shrinkWrap: true,
                        itemCount: bloodSugarController.bloodSugarLists.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: () {
                              bloodSugarController.sugarId.value = bloodSugarController.bloodSugarLists[index].id.toInt();
                              // bloodSugarController.getEditBloodSugarList(widget.id.toString());
                              Get.to(() => UpdateBloodSugarScreen(
                                  catId: bloodSugarController.bloodSugarLists[index].id.toString()
                              ));
                            },
                            onLongPress: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    backgroundColor: ConstColour.buttonColor,
                                    actions: [
                                      IconButton(
                                          onPressed: () {
                                            bloodSugarController.bloodSugarLists.removeAt(index);
                                            setState(() {
                                              Navigator.pop(context);
                                            });
                                          },
                                          icon: Icon(
                                            Icons.check,
                                            color: ConstColour.appColor,
                                          )
                                      )
                                    ],
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
                            title: Text(bloodSugarController.bloodSugarLists[index].measuredTypeName == null
                                ? "Before Breakfast"
                                : bloodSugarController.bloodSugarLists[index].measuredTypeName,
                              style: TextStyle(
                                  fontSize: 20,
                                  color: ConstColour.textColor,
                                  fontFamily: ConstFont.regular
                              ),
                            ),
                            subtitle: Padding(
                              padding: EdgeInsets.only(
                                  top: deviceHeight * 0.01
                              ),
                              child: Row(
                                children: [
                                  Text(bloodSugarController.bloodSugarLists[index].dateTime,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: ConstColour.greyTextColor,
                                        fontFamily: ConstFont.regular
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: deviceWidth * 0.02),
                                    child: Text(bloodSugarController.bloodSugarLists[index].time.toString(),
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
                                      bloodSugarController.bloodSugarLists[index].bloodGlucose,
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
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Visibility(
            //     visible: bloodSugarController.isLoading.value,
            //     child: Center(
            //       child: CircularProgressIndicator(
            //         color: ConstColour.buttonColor,
            //       ),
            //     ),
            //     replacement: RefreshIndicator(
            //       onRefresh: () {
            //         return navigateToAddPage();
            //       },
            //       child: Visibility(
            //         // visible: bloodSugarController,
            //         replacement: Center(
            //             child: Text(
            //               "No Todo Item",
            //               style: Theme.of(context).textTheme.headline2,
            //             ),
            //         ),
            //         child: ListView.builder(
            //           itemBuilder: (context, index) {
            //             return Padding(
            //               padding: const EdgeInsets.all(8.0),
            //               child: Visibility(
            //                 visible: bloodSugarController.isLoading.value,
            //                 child: Column(
            //                   children: [
            //                     Container(
            //                       decoration: BoxDecoration(
            //                           color: ConstColour.appColor
            //                       ),
            //                       child: ListTile(
            //                         title: Text(
            //                           "Before breakfast",
            //                           style: TextStyle(
            //                               fontSize: 20,
            //                               color: ConstColour.textColor,
            //                               fontFamily: ConstFont.regular
            //                           ),
            //                         ),
            //                         subtitle: Row(
            //                           children: [
            //                             Text(
            //                               "10/02/2024",
            //                               style: TextStyle(
            //                                   fontSize: 16,
            //                                   color: ConstColour.greyTextColor,
            //                                   fontFamily: ConstFont.regular
            //                               ),
            //                             ),
            //                             Padding(
            //                               padding: EdgeInsets.only(left: deviceWidth * 0.03),
            //                               child: Text(
            //                                 "05:47pm",
            //                                 style: TextStyle(
            //                                     fontSize: 16,
            //                                     color: ConstColour.greyTextColor,
            //                                     fontFamily: ConstFont.regular
            //                                 ),
            //                               ),
            //                             ),
            //                           ],
            //                         ),
            //                         trailing: RichText(
            //                           text: TextSpan(
            //                             children: <TextSpan>[
            //                               TextSpan(
            //                                 text: '585',
            //                                 style: TextStyle(
            //                                     fontSize: 28,
            //                                     color: ConstColour.textColor,
            //                                     fontFamily: ConstFont.bold
            //                                 ),
            //                               ),
            //                               TextSpan(
            //                                 text: '  mg/dL',
            //                                 style: TextStyle(
            //                                     fontSize: 12,
            //                                     color: ConstColour.greyTextColor,
            //                                     fontFamily: ConstFont.regular
            //                                 ),
            //                               ),
            //                             ],
            //                           ),
            //                         ),
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //             );
            //           },
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
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
    bloodSugarController.measuredType.value = "Before Breakfast";
    bloodSugarController.measuredId.value = 1;
    bloodSugarController.bloodGlucoseController.text = "";
    bloodSugarController.commentController.text = "";
    // unitController.glucoseLevel.value = !unitController.glucoseLevel.value;
    Get.to(() => BloodSugarAddScreen());
  }

  String convertBloodSugarValue(double value, bool glucoseLevel) {
    if (glucoseLevel) {
      double convertedValue = value / 18; // Convert mmol/L to mg/dL
      return convertedValue.toStringAsFixed(1);
      // mmol/L = mg/dl / 18
    } else {
      return value.toStringAsFixed(1);
      // double convertedValue = value * 18; // Convert mg/dL to mmol/L
      // return convertedValue.toStringAsFixed(1);
      // mg/dl = mmol/L x 18
    }
  }
}


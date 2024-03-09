import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_care_dairy/Controller/date_time_controller.dart';
import 'package:health_care_dairy/Controller/hemoglobin_controller.dart';
import 'package:health_care_dairy/Controller/unit_controller.dart';
import 'package:health_care_dairy/Screens/Hemoglobin/edit_hemoglobin_screen.dart';

import '../../ConstFile/constColors.dart';
import '../../ConstFile/constFonts.dart';
import '../../Controller/blood_sugar_controller.dart';
import '../home_screen.dart';
import 'hemoglobin_second_screen.dart';

class Hemoglobin extends StatefulWidget {
  final String id;
  const Hemoglobin({super.key, required this.id});

  @override
  State<Hemoglobin> createState() => _HemoglobinState();
}

class _HemoglobinState extends State<Hemoglobin> {
  DateTimeController dateTimeController = Get.put(DateTimeController());
  UnitController unitController = Get.put(UnitController());
  A1CController a1cController = Get.put(A1CController());
  BloodSugarController bloodSugarController = Get.put(BloodSugarController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloodSugarController.updateCatId(widget.id.toString());
    a1cController.updateCatId(widget.id.toString());
    print("HemoglobinScreen catid"+widget.id.toString());

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
          "Hemoglobin (A1C)",
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
                          ? Center(
                        child: CircularProgressIndicator(
                          color: ConstColour.buttonColor,
                        ),
                      )
                          : ListView.builder(
                        reverse: true,
                        controller: ScrollController(),
                        shrinkWrap: true,
                        itemCount: bloodSugarController.bloodSugarLists.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: () {
                              a1cController.hemoglobinId.value = bloodSugarController.bloodSugarLists[index].id.toInt();
                              // bloodSugarController.getEditBloodSugarList(widget.id.toString());
                              Get.to(() => UpdateHemoglobinScreen(
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
                                  padding: EdgeInsets.only(left: deviceWidth * 0.02),
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
                                        text: "A1C  ",
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: ConstColour.greyTextColor,
                                            fontFamily: ConstFont.regular
                                        ),
                                      ),
                                      TextSpan(
                                        text: bloodSugarController.bloodSugarLists[index].averageSugarConcentration.toString(),
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
                                        text: bloodSugarController.bloodSugarLists[index].averageSugarConcentration.toString(),
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
    a1cController.averageSugarController.text = "";
    a1cController.a1cCommentController.text = "";
    Get.to(() => HemoglobinScreen());
  }
}
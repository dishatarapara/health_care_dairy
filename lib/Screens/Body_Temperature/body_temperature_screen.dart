import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_care_dairy/Controller/date_time_controller.dart';
import 'package:health_care_dairy/Controller/unit_controller.dart';
import 'package:health_care_dairy/Screens/Body_Temperature/body_temperature_second_screen.dart';
import 'package:health_care_dairy/Screens/Body_Temperature/edit_body_temperature_screen.dart';

import '../../ConstFile/constColors.dart';
import '../../ConstFile/constFonts.dart';
import '../../Controller/blood_sugar_controller.dart';
import '../../Controller/body_temperature_controller.dart';
import '../home_screen.dart';

class BodyTemperature extends StatefulWidget {
  final String id;
  const BodyTemperature({super.key, required this.id});

  @override
  State<BodyTemperature> createState() => _BodyTemperatureState();
}

class _BodyTemperatureState extends State<BodyTemperature> {
  DateTimeController dateTimeController = Get.put(DateTimeController());
  UnitController unitController = Get.put(UnitController());
  BodyTemperatureController bodyTemperatureController = Get.put(BodyTemperatureController());
  BloodSugarController bloodSugarController = Get.put(BloodSugarController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloodSugarController.updateCatId(widget.id.toString());
    bodyTemperatureController.updateCatId(widget.id.toString());
    print("bodyTemperaturescreen catid"+widget.id.toString());

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
          "Body Temperature",
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
                              bodyTemperatureController.temperatureId.value = bloodSugarController.bloodSugarLists[index].id.toInt();
                              // bloodSugarController.getEditBloodSugarList(widget.id.toString());
                              Get.to(() => UpdateBodyTemperatureScreen(
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
                            title: Row(
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
                            trailing: RichText(
                              text: TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                    // text: bloodSugarController.bloodSugarLists[index].bodyTemperature.toString(),
                              //       text: '${unitController.bodyIndex.value == 4 ?
                              // bloodSugarController.bloodSugarLists[index].bodyTemperature :
                              // (bloodSugarController.bloodSugarLists[index].bodyTemperature * 9 / 5) + 32}',
                                    text: convertBodyTemperature(
                                        bloodSugarController.bloodSugarLists[index].bodyTemperature,
                                        unitController.getGlucoseLevelPreference()),
                                    style: TextStyle(
                                        fontSize: 28,
                                        color: ConstColour.textColor,
                                        fontFamily: ConstFont.bold
                                    ),
                                  ),
                                  TextSpan(
                                    text: " ${unitController.bodyIndex.value == 4 ? '℃' : 'ºf'}",
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
    bodyTemperatureController.temperatureController.text = "";
    bodyTemperatureController.temperatureCommentController.text = "";
    Get.to(() => BodyTemperatureScreen());
  }

  String convertBodyTemperature(double value, bool temperature) {
    if (temperature) {
    // °F = (9/5 × °C) + 32.
    // °C = (°F - 32) × 5/9
      double convertedValue = (9 / 5 * value) + 32; // Celsius to Fahrenheit
      // double convertedValue = (value - 32) * 5 / 9; // Fahrenheit to Celsius
      return convertedValue.toStringAsFixed(1);
    } else {
      return value.toStringAsFixed(1);
    }
  }


}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_care_dairy/Controller/date_time_controller.dart';
import 'package:health_care_dairy/Screens/Blood_oxygen/edit_blood_oxygen_screen.dart';

import '../../ConstFile/constColors.dart';
import '../../ConstFile/constFonts.dart';
import '../../Controller/blood_oxygen_controller.dart';
import '../../Controller/blood_sugar_controller.dart';
import '../home_screen.dart';
import 'blood_oxygen_second_screen.dart';

class BloodOxygen extends StatefulWidget {
  final String id;
  const BloodOxygen({super.key, required this.id});

  @override
  State<BloodOxygen> createState() => _BloodOxygenState();
}

class _BloodOxygenState extends State<BloodOxygen> {
  DateTimeController dateTimeController = Get.put(DateTimeController());
  BloodOxygenController bloodOxygenController = Get.put(BloodOxygenController());
  BloodSugarController bloodSugarController = Get.put(BloodSugarController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloodSugarController.updateCatId(widget.id.toString());
    bloodOxygenController.updateCatId(widget.id.toString());
    print("OxygenScreen catid"+widget.id.toString());

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
          "Blood Oxygen",
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
                              bloodOxygenController.oxygenId.value = bloodSugarController.bloodSugarLists[index].id.toInt();
                              // bloodSugarController.getEditBloodSugarList(widget.id.toString());
                              Get.to(() => UpdateBloodOxygenScreen(
                                  catId: bloodSugarController.bloodSugarLists[index].id.toString()
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
                                    text: bloodSugarController.bloodSugarLists[index].bloodOxygenSaturation.toString(),
                                    style: TextStyle(
                                        fontSize: 28,
                                        color: ConstColour.textColor,
                                        fontFamily: ConstFont.bold
                                    ),
                                  ),
                                  TextSpan(
                                    text: "  %",
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
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: deviceHeight * 0.02,
                                horizontal: deviceWidth * 0.02
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
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
                                    bloodSugarController.bloodSugarLists[index].dateTime,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: ConstColour.greyTextColor,
                                        fontFamily: ConstFont.regular
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: RichText(
                                    text: TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: bloodSugarController.bloodSugarLists[index].bodyTemperature.toString(),
                                          style: TextStyle(
                                              fontSize: 28,
                                              color: ConstColour.textColor,
                                              fontFamily: ConstFont.bold
                                          ),
                                        ),
                                        TextSpan(
                                          text: "  ℃",
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
    bloodOxygenController.oxygenController.text = "";
    bloodOxygenController.oxygenCommentController.text = "";
    Get.to(() => BloodOxygenScreen());
  }
}
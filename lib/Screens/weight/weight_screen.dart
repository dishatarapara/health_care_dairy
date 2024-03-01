import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_care_dairy/ConstFile/constPreferences.dart';
import 'package:health_care_dairy/Controller/date_time_controller.dart';
import 'package:health_care_dairy/Controller/unit_controller.dart';
import 'package:health_care_dairy/Screens/weight/edit_weight_screen.dart';
import 'package:health_care_dairy/Screens/weight/weight_add_screen.dart';
import 'package:sqflite/sqflite.dart';

import '../../ConstFile/constColors.dart';
import '../../ConstFile/constFonts.dart';
import '../../Controller/blood_sugar_controller.dart';
import '../../Controller/weight_controller.dart';
import '../home_screen.dart';

class Weight extends StatefulWidget {
  final String id;
  const Weight({super.key, required this.id});

  @override
  State<Weight> createState() => _WeightState();
}

class _WeightState extends State<Weight> {
  DateTimeController dateTimeController = Get.put(DateTimeController());
  UnitController unitController = Get.put(UnitController());
  WeightController weightController = Get.put(WeightController());
  BloodSugarController bloodSugarController = Get.put(BloodSugarController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // bloodSugarController.updateCatId(widget.id.toString());
    // weightController.updateCatId(widget.id.toString());
    // print("Weightscreen catid"+widget.id.toString());
    // weightController.setPref();
    //
    setState(() {
  //    bloodSugarController.getCategoryList();
      setPref();
    });
    loadData();
  }

  void setPref() async {
    var otherUnit = await ConstPreferences().getOtherUnit();
    print("otherunit "+otherUnit.toString());
    if (otherUnit != null) {
      weightController.newVal.value = otherUnit;
    } else {
      // Handle the case where otherUnit is null, maybe provide a default value or handle the error.
    }
  }

  Future<void> loadData() async {
    await Future.delayed(Duration(seconds: 5));

    setState(() {
      bloodSugarController.isLoading.value = false;
    });
    bloodSugarController.updateCatId(widget.id.toString());
    weightController.updateCatId(widget.id.toString());
   // weightController.setPref();
    bloodSugarController.getCategoryList();
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
          "Weight",
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
      body: Obx(() {
        if(bloodSugarController.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(
              color: ConstColour.buttonColor,
            ),
          );
        } else {
          return RefreshIndicator(
            color: ConstColour.buttonColor,
            onRefresh: () async {
              await bloodSugarController.getCategoryList();
            },
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              controller: ScrollController(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: ConstColour.appColor
                      ),
                      child: bloodSugarController.bloodSugarLists.isEmpty
                          ? Center(
                        child: Text(
                          "No data available",
                          style: TextStyle(
                            fontSize: 30,
                            color: ConstColour.textColor,
                            fontFamily: ConstFont.regular,
                          ),
                        )
                      )
                          : ListView.builder(
                        reverse: true,
                        controller: ScrollController(),
                        shrinkWrap: true,
                        itemCount: bloodSugarController.bloodSugarLists.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: () {
                              weightController.weightId.value = bloodSugarController.bloodSugarLists[index].id.toInt();
                              Get.to(() => UpdateWeightScreen(
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
                                    // text: bloodSugarController.bloodSugarLists[index].weight.toString(),
                                    // text: '${unitController.selectIndex.value == 2 ?
                                    // bloodSugarController.bloodSugarLists[index].weight :
                                    // bloodSugarController.bloodSugarLists[index].weight * 2.2046}',
                                    text: convertWeightValue(
                                      bloodSugarController.bloodSugarLists[index].weight,
                                      // weightController.isKGSelected!.value,
                                      weightController.newVal.value,
                                    ),
                                    style:  TextStyle(
                                        fontSize: 28,
                                        color: ConstColour.textColor,
                                        fontFamily: ConstFont.bold
                                    ),
                                  ),
                                  TextSpan(
                                    // text:' ${unitController.selectIndex.value == 2 ? 'kg' : 'lbs'}',
                                    text:' ${weightController.newVal.value == true ? 'kg' : 'lbs'}',
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
          );}
        },
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
    weightController.bodyWeightController.text = "";
    weightController.weightCommentController.text = "";
    Get.to(() => WeightAddScreen());
  }

  // String convertWeightValue(double value, bool weight) {
  //   if (weight) {
  //     double convertedValue = value * 2.2046; // Convert KG to LBS
  //     return convertedValue.toStringAsFixed(1);
  //   } else {
  //     return value.toStringAsFixed(1);
  //     // double convertedValue = value * 0.45359237; // Convert LBS to KG
  //     // return convertedValue.toStringAsFixed(1);
  //   }
  // }

  String convertWeightValue(double value, bool weight){
    // bool weight = weightController.isKGSelected.value;
    if (weight == false) { // lbs
      double convertedWeight = value * 2.2046;
      print(convertedWeight.toString() + "11ythghg");
      return convertedWeight.toStringAsFixed(1);
      // 1 lbs = 1 x 0.45359237 kg
    } else { // kg
      print(value.toString()+"else call");
      return value.toStringAsFixed(1);
    }
  }
}
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:get/get.dart';
import 'package:health_care_dairy/Controller/blood_sugar_controller.dart';
import 'package:health_care_dairy/Controller/medication_controller.dart';

import '../../Common/bottom_button.dart';
import '../../Common/snackbar.dart';
import '../../ConstFile/constColors.dart';
import '../../ConstFile/constFonts.dart';

class MedicationScreen extends StatefulWidget {
  const MedicationScreen({super.key});

  @override
  State<MedicationScreen> createState() => _MedicationScreenState();
}

class _MedicationScreenState extends State<MedicationScreen> {
  BloodSugarController bloodSugarController = Get.put(BloodSugarController());
  MedicationController medicationController = Get.put(MedicationController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    medicationController.selectDataList();
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
          "Add Medication",
          style: TextStyle(
              color: ConstColour.textColor,
              fontFamily: ConstFont.regular,
              fontWeight: FontWeight.w800,
              overflow: TextOverflow.ellipsis
          ),
        ),
        leading: IconButton(
          onPressed: () {
            // Get.to(() => Medication());
            Get.back();
          },
          icon: Icon(Icons.arrow_back),
          color: ConstColour.textColor,
        ),
      ),
      backgroundColor: ConstColour.bgColor,
      body: Obx(() => Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: deviceWidth * 0.02,
                vertical: deviceHeight * 0.02
            ),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: deviceWidth * 0.03,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Medication Name',
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: ConstFont.bold
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Expanded(
                                child: TextFormField(
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  controller: medicationController.medicationNameController,
                                  cursorColor: ConstColour.buttonColor,
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: ConstColour.textColor,
                                      fontFamily: ConstFont.regular
                                  ),
                                  autocorrect: true,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Enter Medication Name",
                                    hintStyle: TextStyle(
                                        fontSize: 20,
                                        color: ConstColour.greyTextColor,
                                        fontFamily: ConstFont.regular
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () => showBottomSheetButton(),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: deviceWidth * 0.03,
                          vertical: deviceHeight * 0.006
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Units',
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily: ConstFont.bold
                            ),
                          ),
                          Row(
                            children: [
                              Text(medicationController.unit.isEmpty
                                  ? "Unit"
                                  : medicationController.unit.value.toString(),
                                style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: ConstFont.bold
                                ),
                              ),
                              Icon(
                                Icons.arrow_drop_down,
                                color: ConstColour.greyTextColor,
                                size: 35,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: deviceWidth * 0.03,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Dosage',
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: ConstFont.bold
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Expanded(
                                child: TextFormField(
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  controller: medicationController.dosageController,
                                  cursorColor: ConstColour.buttonColor,
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: ConstColour.textColor,
                                      fontFamily: ConstFont.regular
                                  ),
                                  autocorrect: true,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*')),
                                    LengthLimitingTextInputFormatter(5)
                                  ],
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Dosage, units",
                                    hintStyle: TextStyle(
                                        fontSize: 20,
                                        color: ConstColour.greyTextColor,
                                        fontFamily: ConstFont.regular
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: deviceWidth * 0.03,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Times a day',
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: ConstFont.bold
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Expanded(
                                child: TextFormField(
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  controller: medicationController.timeController,
                                  cursorColor: ConstColour.buttonColor,
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: ConstColour.textColor,
                                      fontFamily: ConstFont.regular
                                  ),
                                  autocorrect: true,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*')),
                                  ],
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Enter how much time per day",
                                    hintStyle: TextStyle(
                                        fontSize: 20,
                                        color: ConstColour.greyTextColor,
                                        fontFamily: ConstFont.regular
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Obx(() => InkWell(
                      onTap: () async {
                        Color? newColor = await showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: Text('Pick a color'),
                            content: MaterialColorPicker(
                              allowShades: true,
                              shrinkWrap: true,
                              onlyShadeSelection: true,
                              selectedColor: medicationController.selectedColor.value,
                               onColorChange: (value) {
                                 print(value);
                                 medicationController.selectedColor.value = value;
                               },
                              onMainColorChange: (color) {
                                setState(() {
                                  print(color);
                                  medicationController.selectedColor.value = color!;
                                });
                              },
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Get.back(result: null);
                                  // Navigator.of(context).pop(null);
                                },
                                child: Text(
                                  'CANCEL',
                                  style: TextStyle(
                                    color: ConstColour.buttonColor
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  print(medicationController.selectedColor.value);
                                  Get.back(result: medicationController.selectedColor.value);
                                  // Navigator.of(context).pop(medicationController.selectedColor.value);
                                },
                                child: Text(
                                    'OK',
                                  style: TextStyle(
                                      color: ConstColour.buttonColor
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );

                        if (newColor != null) {
                          setState(() {
                            medicationController.selectedColor.value = newColor;
                          });
                        }
                      },
                      // {
                      //   Get.to(() => ColorPickerExample());
                      // },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: deviceWidth * 0.03,
                            vertical: deviceHeight * 0.015
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Color',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: ConstFont.bold
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  height: deviceHeight * 0.021,
                                  child: Image.asset(
                                    "assets/Icons/medication.png",
                                    fit: BoxFit.cover,
                                    color: medicationController.selectedColor.value,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: deviceWidth * 0.03,
                                  ),
                                  child: Icon(
                                    Icons.arrow_forward_ios,
                                    size: 20,
                                    color: ConstColour.textColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: deviceWidth * 0.03,
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Note',
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: ConstFont.bold
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: deviceWidth * 0.02
                            ),
                            child: TextFormField(
                              cursorColor: ConstColour.buttonColor,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              controller: medicationController.noteController,
                              style: TextStyle(
                                  fontSize: 18,
                                  color: ConstColour.textColor,
                                  fontFamily: ConstFont.regular
                              ),
                              autocorrect: true,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Enter Note",
                                hintStyle: TextStyle(
                                    fontSize: 20,
                                    color: ConstColour.greyTextColor,
                                    fontFamily: ConstFont.regular
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: deviceHeight * 0.01,
                left: deviceWidth * 0.02,
                right: deviceWidth * 0.02
            ),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    minimumSize: Size(deviceWidth * 0.9, deviceHeight * 0.06),
                    backgroundColor: ConstColour.buttonColor
                ),
                onPressed: () async {
                  try {
                    if (medicationController.medicationNameController.text.isEmpty) {
                      Utils().snackBar('Medication Name', "Please Enter Medication Name");
                      return;
                    }else if (medicationController.dosageController.text.isEmpty) {
                      Utils().snackBar('Dosages', "Please Enter Dosages");
                      return;
                    }
                    await medicationController.MedicationList(
                          medicationController.medicationNameController.text,
                          medicationController.dosageController.text,
                          medicationController.timeController.text,
                          medicationController.noteController.text
                      );
                  } catch(e) {
                    debugPrint("Error: $e");
                  }
                },
                child: bloodSugarController.isLoading.value
                    ? Center(
                  child: CircularProgressIndicator(
                    color: ConstColour.appColor,
                  ),
                )
                    : Text(
                  "Save",
                  style: TextStyle(
                      fontSize: 20,
                      color: bloodSugarController.isLoading.value ? Colors.transparent : ConstColour.bgColor
                  ),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                )
            ),
            // NextButton(
            //   onPressed: () {
            //     if (medicationController.medicationNameController.text.isEmpty) {
            //       Utils().snackBar('Medication Name', "Please Enter Medication Name");
            //     }else if (medicationController.dosageController.text.isEmpty) {
            //       Utils().snackBar('Dosages', "Please Enter Dosages");
            //     }else {
            //       medicationController.MedicationList(
            //         medicationController.medicationNameController.text,
            //         medicationController.dosageController.text,
            //         medicationController.timeController.text,
            //         medicationController.noteController.text
            //       );
            //     }
            //     // Get.to(() => Medication());
            //     // bloodSugarController.BloodSugarList();
            //   },
            //   btnName: "Save",
            // ),
          )
        ],
      )),
    );
  }

  void showBottomSheetButton() {
    showModalBottomSheet(
      elevation: 0,
      enableDrag: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          )
      ),
      context: context,
      builder: (context) {
        var deviceHeight = MediaQuery.of(context).size.height;
        var deviceWidth = MediaQuery.of(context).size.width;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: deviceHeight * 0.03),
              child: Center(
                child: Text(
                  "SELECT DATA TYPE",
                  style: TextStyle(
                      fontSize: 23,
                      fontFamily: ConstFont.bold
                  ),
                ),
              ),
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              controller: ScrollController(),
              itemCount: medicationController.selectedDataList.length,
              itemBuilder: (context, index) {
                final bool isSelected = medicationController.unit.value == medicationController.selectedDataList[index].name;
                return GestureDetector(
                  onTap: () {
                    medicationController.unit.value = medicationController.selectedDataList[index].name;
                    medicationController.selectedDataTypeId.value = medicationController.selectedDataList[index].id;
                    Navigator.pop(context);
                  },
                  child: Container(
                    color: isSelected
                        ? ConstColour.buttonColor.withOpacity(0.5)
                        : Colors.transparent,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: deviceWidth * 0.02,
                          vertical: deviceHeight * 0.01
                      ),
                      child: Text(
                        medicationController.selectedDataList[index].name,
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: ConstFont.regular,
                            color: ConstColour.textColor
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
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_care_dairy/Controller/medication_controller.dart';
import 'package:health_care_dairy/Screens/medication/edit_medication_screen.dart';

import '../../ConstFile/constColors.dart';
import '../../ConstFile/constFonts.dart';
import '../../Controller/blood_sugar_controller.dart';
import '../discription.dart';
import '../home_screen.dart';
import 'medication_second_screen.dart';

class Medication extends StatefulWidget {
  final String id;
  const Medication({super.key, required this.id});

  @override
  State<Medication> createState() => _MedicationState();
}

class _MedicationState extends State<Medication> {
  MedicationController medicationController = Get.put(MedicationController());
  BloodSugarController bloodSugarController = Get.put(BloodSugarController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloodSugarController.updateCatId(widget.id.toString());
    medicationController.updateCatId(widget.id.toString());
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
          "Medication",
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
              onPressed: () {
                Get.to(() =>  DiscriptionScreen(
                  title: 'Medication',
                  description: 'A dosage form that contains one or more active and/or inactive ingredients. ',
                  detailedDescription:'• A substance (other than food) intended to affect the structure or any function of the body.\n\n • A substance recognized by an official pharmacopeia or formulary. \n\n • A substance intended for use in the diagnosis, cure, mitigation, treatment, or prevention of disease.',
                ));
              },
              icon: Image.asset("assets/Icons/information.png"))
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
                          String colorString =  bloodSugarController.bloodSugarLists[index].color.toString() == null
                              ? '0xFF000000'
                              : bloodSugarController.bloodSugarLists[index].color.toString();
                          RegExp regex = RegExp(r"0x[\da-f]+"); // Regular expression to match hexadecimal color values
                          String? hexColor = regex.stringMatch(colorString); // Extract the hexadecimal color value

                          Color color = Color(0xffFFFFF);
                          if (hexColor != null) {
                            // Parse the hexadecimal color value into an integer
                            color = Color(int.parse(hexColor));
                          } else {}
                          return ListTile(
                            onTap: () {
                              medicationController.medicationId.value = bloodSugarController.bloodSugarLists[index].id.toInt();
                              Get.to(() => UpdateMedicationScreen(
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
                                Container(
                                  height: deviceHeight * 0.02,
                                  child: Image.asset(
                                    "assets/Icons/medication.png",
                                    fit: BoxFit.cover,
                                    color: color,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: deviceWidth * 0.05),
                                  child: Text(
                                    bloodSugarController.bloodSugarLists[index].medicationName,
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: ConstColour.textColor,
                                        fontFamily: ConstFont.bold
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            trailing: RichText(
                              text: TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                    text: bloodSugarController.bloodSugarLists[index].dosage.toString(),
                                    style: TextStyle(
                                        fontSize: 28,
                                        color: ConstColour.textColor,
                                        fontFamily: ConstFont.bold
                                    ),
                                  ),
                                  TextSpan(
                                    text: bloodSugarController.bloodSugarLists[index].selectDataTypeName == null
                                        ? "Unit"
                                        : bloodSugarController.bloodSugarLists[index].selectDataTypeName,
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
    medicationController.medicationNameController.text = "";
    medicationController.unit.value = "Unit";
    medicationController.selectedDataTypeId.value = 1;
    medicationController.dosageController.text = "";
    medicationController.timeController.text = "";
    medicationController.selectedColor.value = Color(0xFF000000);
    medicationController.noteController.text = "";
    Get.to(() => MedicationScreen());
  }
}
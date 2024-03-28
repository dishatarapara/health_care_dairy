import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:health_care_dairy/Controller/medication_controller.dart';
import 'package:health_care_dairy/Screens/medication/edit_medication_screen.dart';

import '../../ConstFile/constColors.dart';
import '../../ConstFile/constFonts.dart';
import '../../Controller/blood_sugar_controller.dart';
import '../../Controller/delete_controller.dart';
import '../../Controller/filter_controller.dart';
import '../home/discription_screen.dart';
import '../home_screen.dart';
import '../../Common/loader.dart';
import 'medication_second_screen.dart';

class Medication extends StatefulWidget {
  final String id;
  const Medication({super.key, required this.id});

  @override
  State<Medication> createState() => _MedicationState();
}

class _MedicationState extends State<Medication> {
  // FilterController filterController = Get.put(FilterController());
  DeleteController deleteController = Get.put(DeleteController());
  MedicationController medicationController = Get.put(MedicationController());
  BloodSugarController bloodSugarController = Get.put(BloodSugarController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // bloodSugarController.updateCatId(widget.id.toString());
    // medicationController.updateCatId(widget.id.toString());
    // print("OxygenScreen catid"+widget.id.toString());
    //
    // setState(() {
    //   bloodSugarController.getCategoryList();
    // });
    SchedulerBinding.instance.addPostFrameCallback((_) {
      bloodSugarController.filterLists.clear();
    });

    loadMedicitionData();
  }

  Future<void> loadMedicitionData() async {
    await Future.delayed(Duration(seconds: 3));

    if (mounted) {
      setState(() {
        bloodSugarController.isLoading.value = false;
      });

      bloodSugarController.updateCatId(widget.id.toString());
      medicationController.updateCatId(widget.id.toString());
      print("medicationScreen catid" + widget.id.toString());
      // bloodSugarController.getCategoryList();
      medicationController.getCategoryList();
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
              : "Medication",
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
          // IconButton(
          //     onPressed: () {
          //       Get.to(() =>  DiscriptionScreen(
          //         title: 'Medication',
          //         description: 'A dosage form that contains one or more active and/or inactive ingredients. ',
          //         detailedDescription:'• A substance (other than food) intended to affect the structure or any function of the body.\n\n• A substance recognized by an official pharmacopeia or formulary. \n\n • A substance intended for use in the diagnosis, cure, mitigation, treatment, or prevention of disease.',
          //       ));
          //     },
          //     icon: Image.asset("assets/Icons/information.png")),
          Obx(() =>  IconButton(
              onPressed: () {
                if(deleteController.flag.value == true) {
                  deleteController.flag.value = false;
                  deleteController.deleteDialog("Are you sure, you want to delete this Medication Record?");
                } else {
                  Get.to(() =>  DiscriptionScreen(
                    title: 'Medication',
                    description: 'A dosage form that contains one or more active and/or inactive ingredients. ',
                    detailedDescription:'• A substance (other than food) intended to affect the structure or any function of the body.\n\n• A substance recognized by an official pharmacopeia or formulary. \n\n • A substance intended for use in the diagnosis, cure, mitigation, treatment, or prevention of disease.',
                  ));
                  // filterController.showDialogBox();
                }
              },
              icon: deleteController.flag.value == true
                  ? Icon(Icons.delete,
                  color: ConstColour.textColor
              )
                  : Image.asset("assets/Icons/information.png")
              // Image.asset(
              //   "assets/Icons/filter.png",
              //   width: deviceWidth * 0.07,
              //   height: deviceHeight * 0.028,)
          ),
          )
        ],
      ),
      backgroundColor: ConstColour.bgColor,
      body: Obx(() => RefreshIndicator(
        color: ConstColour.buttonColor,
        onRefresh: () async {
          await medicationController.getCategoryList();
        },
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          controller: ScrollController(),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                medicationController.bloodSugarLists.isEmpty
                    ? ((bloodSugarController.isLoading.value == true))
                    ? Padding(
                  padding: EdgeInsets.symmetric(vertical: deviceHeight * 0.3),
                  child: Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Image.asset(
                            "assets/Icons/no_data_medication.png",
                            height: deviceHeight * 0.1
                        ),
                        Text(
                          "No Record Found",
                          style: TextStyle(
                              fontSize: 15,
                              color: ConstColour.greyTextColor,
                              fontFamily: ConstFont.regular
                          ),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
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
                  reverse: true,
                  controller: ScrollController(),
                  shrinkWrap: true,
                  itemCount: medicationController.bloodSugarLists.length,
                  itemBuilder: (context, index) {
                    String colorString =  medicationController.bloodSugarLists[index].color.toString() == null
                        ? '0xFF000000'
                        : medicationController.bloodSugarLists[index].color.toString();
                    RegExp regex = RegExp(r"0x[\da-f]+"); // Regular expression to match hexadecimal color values
                    String? hexColor = regex.stringMatch(colorString); // Extract the hexadecimal color value

                    Color color = Color(0xffFFFFF);
                    if (hexColor != null) {
                      // Parse the hexadecimal color value into an integer
                      color = Color(int.parse(hexColor));
                    } else {}
                    return GestureDetector(
                      onLongPress: () {
                        setState(() {
                          if(deleteController.selectedIndices.isEmpty){
                            deleteController.flag.value = false;
                          }
                          if (deleteController.selectedIndices.contains(index)) {
                            deleteController.selectedIndices.remove(index);
                            deleteController.deleteRecordList.remove(medicationController.bloodSugarLists[index].id.toString());
                            print("if");
                          } else {
                            deleteController.flag.value = true;
                            deleteController.selectedIndices.add(index);
                            deleteController.deleteRecordList.add(medicationController.bloodSugarLists[index].id);
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
                            if(deleteController.selectedIndices.isEmpty){
                              deleteController.flag.value = false;
                            }
                            if( deleteController.flag.value == true){
                              if (deleteController.selectedIndices.contains(index)) {
                                deleteController.selectedIndices.remove(index);
                                deleteController.deleteRecordList.remove(medicationController.bloodSugarLists[index].id.toString());
                                print("if");
                              } else {
                                deleteController.flag.value = true;
                                deleteController.selectedIndices.add(index);
                                deleteController.deleteRecordList.add(medicationController.bloodSugarLists[index].id);
                                print("else");
                              }
                              setState(() {});
                            }else{
                              medicationController.medicationId.value = medicationController.bloodSugarLists[index].id.toInt();
                              Get.to(() => UpdateMedicationScreen(
                                  catId: medicationController.bloodSugarLists[index].id.toString()
                              ));
                            }
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
                                  medicationController.bloodSugarLists[index].medicationName,
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
                                  text: medicationController.bloodSugarLists[index].dosage.toString(),
                                  style: TextStyle(
                                      fontSize: 28,
                                      color: ConstColour.textColor,
                                      fontFamily: ConstFont.bold
                                  ),
                                ),
                                TextSpan(
                                  text: medicationController.bloodSugarLists[index].selectDataTypeName == null
                                      ? "Unit"
                                      : medicationController.bloodSugarLists[index].selectDataTypeName,
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
      //                 child: medicationController.bloodSugarLists.isEmpty
      //                     ? Center(
      //                   child: Text(
      //                     "No Record Found",
      //                     style: TextStyle(
      //                       fontSize: 30,
      //                       color: ConstColour.textColor,
      //                       fontFamily: ConstFont.regular
      //                     ),
      //                   )
      //                 )
      //                     : ListView.builder(
      //                   reverse: true,
      //                   controller: ScrollController(),
      //                   shrinkWrap: true,
      //                   itemCount: medicationController.bloodSugarLists.length,
      //                   itemBuilder: (context, index) {
      //                     String colorString =  medicationController.bloodSugarLists[index].color.toString() == null
      //                         ? '0xFF000000'
      //                         : medicationController.bloodSugarLists[index].color.toString();
      //                     RegExp regex = RegExp(r"0x[\da-f]+"); // Regular expression to match hexadecimal color values
      //                     String? hexColor = regex.stringMatch(colorString); // Extract the hexadecimal color value
      //
      //                     Color color = Color(0xffFFFFF);
      //                     if (hexColor != null) {
      //                       // Parse the hexadecimal color value into an integer
      //                       color = Color(int.parse(hexColor));
      //                     } else {}
      //                     return ListTile(
      //                       onTap: () {
      //                         medicationController.medicationId.value = medicationController.bloodSugarLists[index].id.toInt();
      //                         Get.to(() => UpdateMedicationScreen(
      //                           catId: medicationController.bloodSugarLists[index].id.toString(),
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
      //                       title: Row(
      //                         children: [
      //                           Container(
      //                             height: deviceHeight * 0.02,
      //                             child: Image.asset(
      //                               "assets/Icons/medication.png",
      //                               fit: BoxFit.cover,
      //                               color: color,
      //                             ),
      //                           ),
      //                           Padding(
      //                             padding: EdgeInsets.only(left: deviceWidth * 0.05),
      //                             child: Text(
      //                               medicationController.bloodSugarLists[index].medicationName,
      //                               style: TextStyle(
      //                                   fontSize: 20,
      //                                   color: ConstColour.textColor,
      //                                   fontFamily: ConstFont.bold
      //                               ),
      //                             ),
      //                           ),
      //                         ],
      //                       ),
      //                       trailing: RichText(
      //                         text: TextSpan(
      //                           children: <TextSpan>[
      //                             TextSpan(
      //                               text: medicationController.bloodSugarLists[index].dosage.toString(),
      //                               style: TextStyle(
      //                                   fontSize: 28,
      //                                   color: ConstColour.textColor,
      //                                   fontFamily: ConstFont.bold
      //                               ),
      //                             ),
      //                             TextSpan(
      //                               text: medicationController.bloodSugarLists[index].selectDataTypeName == null
      //                                   ? "Unit"
      //                                   : medicationController.bloodSugarLists[index].selectDataTypeName,
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
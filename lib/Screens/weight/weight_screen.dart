import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
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
import '../../Controller/delete_controller.dart';
import '../../Controller/filter_controller.dart';
import '../../Controller/weight_controller.dart';
import '../../model/get_category_model.dart';
import '../home/discription_screen.dart';
import '../home_screen.dart';
import '../../Common/loader.dart';

class Weight extends StatefulWidget {
  final String id;
  const Weight({super.key, required this.id});

  @override
  State<Weight> createState() => _WeightState();
}

class _WeightState extends State<Weight> {
  FilterController filterController = Get.put(FilterController());
  DeleteController deleteController = Get.put(DeleteController());
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
    SchedulerBinding.instance.addPostFrameCallback((_) {
      bloodSugarController.filterLists.clear();
    });
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
    await Future.delayed(Duration(seconds: 3));

    if (mounted) {
      setState(() {
        bloodSugarController.isLoading.value = false;
      });

      bloodSugarController.updateCatId(widget.id.toString());
      weightController.updateCatId(widget.id.toString());
      // weightController.setPref();
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
              : "Weight",
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
                    title:'Human Weight',
                    description: 'Human body weight refers to a persons mass or weight.Body weight is measured in kilograms, a measure of mass, throughout the world in countries that use the Metric system, although in some countries such as the United States it is measured in pounds, or as in the United Kingdom,stones and pounds.',
                    detailedDescription:'Most hospitals, even in the United States, now use kilograms for calculations, but use kilograms and pounds together for other purpose. \n\n\nAverage adult human weight by continent from about 60 kg (130 lb) in Asia and Africa to about 80 kg(180 lb) in North America, with men on average weighing more than women.'
                ));
              },
              icon: Image.asset("assets/Icons/information.png")),
          Obx(() =>  IconButton(
              onPressed: () {
                if(deleteController.flag.value == true) {
                  deleteController.flag.value = false;
                  deleteController.deleteDialog("Are you sure, you want to delete this Weight Record?");
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
                height: deviceHeight * 0.028,)
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
                bloodSugarController.filterLists.isEmpty
                    ? ((bloodSugarController.isLoading.value == true))
                    ? Padding(
                  padding: EdgeInsets.symmetric(vertical: deviceHeight * 0.3),
                  child: Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Image.asset(
                            "assets/Icons/no_data_weight.png",
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
                  reverse: false,
                  controller: ScrollController(),
                  shrinkWrap: true,
                  itemCount: bloodSugarController.filterLists.length,
                  itemBuilder: (context, index) {
                    String prvIndexDate = "";
                    String currentIndexDate = bloodSugarController.filterLists[index].dateTime.substring(3);
                    if(index > 0) {
                      prvIndexDate = bloodSugarController.filterLists[(index - 1)].dateTime.substring(3);
                    } else {
                      prvIndexDate = bloodSugarController.filterLists[index].dateTime.substring(3);
                    }
                    //  List<CategoryList> monthRecords = [];
                    String monthYear = "";
                    bool isHeader = false;
                    if(currentIndexDate != prvIndexDate || index == 0) {
                      isHeader =true;
                      monthYear = bloodSugarController.filterLists[index].dateTime.substring(3);
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        isHeader
                            ? Padding(
                          padding: EdgeInsets.only(
                              top: deviceHeight * 0.01,
                              bottom: deviceHeight * 0.01),
                          child: Text(
                            bloodSugarController.formatDate(monthYear),
                            style: TextStyle(
                                fontSize: 25,
                                color: ConstColour.buttonColor,
                                fontFamily: ConstFont.bold
                            ),
                          ),
                        )
                            : SizedBox(),
                        GestureDetector(
                          onLongPress: () {
                            setState(() {
                              if(deleteController.selectedIndices.isEmpty){
                                deleteController.flag.value = false;
                              }
                              if (deleteController.selectedIndices.contains(index)) {
                                deleteController.selectedIndices.remove(index);
                                deleteController.deleteRecordList.remove(bloodSugarController.filterLists[index].id.toString());
                                print("if");
                              } else {
                                deleteController.flag.value = true;
                                deleteController.selectedIndices.add(index);
                                deleteController.deleteRecordList.add(bloodSugarController.filterLists[index].id);
                                print("else");
                              }
                            });
                          },
                          child: Container(
                            color: deleteController.selectedIndices.contains(index) ? ConstColour.buttonColor.withOpacity(0.5) : ConstColour.appColor,
                            child: ListTile(
                              selected: deleteController.selectedIndices.contains(index),
                              onTap: () {
                                if(deleteController.selectedIndices.isEmpty){
                                  deleteController.flag.value = false;
                                }
                                if( deleteController.flag.value == true){
                                  if (deleteController.selectedIndices.contains(index)) {
                                    deleteController.selectedIndices.remove(index);
                                    deleteController.deleteRecordList.remove(bloodSugarController.filterLists[index].id.toString());
                                    print("if");
                                  } else {
                                    deleteController.flag.value = true;
                                    deleteController.selectedIndices.add(index);
                                    deleteController.deleteRecordList.add(bloodSugarController.filterLists[index].id);
                                    print("else");
                                  }
                                  setState(() {});
                                }else{
                                  weightController.weightId.value = bloodSugarController.filterLists[index].id.toInt();
                                  Get.to(() => UpdateWeightScreen(
                                      catId: bloodSugarController.filterLists[index].id.toString()
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
                                  Text(
                                    bloodSugarController.filterLists[index].dateTime,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: ConstColour.greyTextColor,
                                        fontFamily: ConstFont.regular
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: deviceWidth * 0.03),
                                    child: Text(
                                      bloodSugarController.filterLists[index].time.toString(),
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
                                      // text: bloodSugarController.filterLists[index].weight.toString(),
                                      // text: '${unitController.selectIndex.value == 2 ?
                                      // bloodSugarController.filterLists[index].weight :
                                      // bloodSugarController.filterLists[index].weight * 2.2046}',
                                      text: convertWeightValue(
                                        bloodSugarController.filterLists[index].weight,
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
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                // ListView.builder(
                //   controller: ScrollController(),
                //   shrinkWrap: true,
                //   itemCount:bloodSugarController.filterLists.length ,
                //   itemBuilder: (BuildContext context, int index) {
                //     String prvIndexDate = "";
                //     String currentIndexDate = bloodSugarController.filterLists[index].dateTime.substring(3);
                //     if(index > 0) {
                //       prvIndexDate = bloodSugarController.filterLists[(index - 1)].dateTime.substring(3);
                //     } else {
                //       prvIndexDate = bloodSugarController.filterLists[index].dateTime.substring(3);
                //     }
                //     List<CategoryList> monthRecords = [];
                //     String monthYear = "";
                //     if(currentIndexDate != prvIndexDate) {
                //       monthYear = bloodSugarController.filterLists[index].dateTime.substring(3);
                //       monthRecords = bloodSugarController.filterLists.where((record) => record.dateTime.substring(3) == monthYear).toList();
                //     } else {
                //       if(index == 0) {
                //         monthYear = bloodSugarController.filterLists[index].dateTime.substring(3);
                //         monthRecords = bloodSugarController.filterLists.where((record) => record.dateTime.substring(3) == monthYear).toList();
                //       }
                //     }
                //     return Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         monthYear.isNotEmpty
                //             ? Padding(
                //           padding: EdgeInsets.only(
                //               top: deviceHeight * 0.01,
                //               bottom: deviceHeight * 0.01),
                //           child: Text(
                //             bloodSugarController.formatDate(monthYear),
                //             style: TextStyle(
                //                 fontSize: 25,
                //                 color: ConstColour.buttonColor,
                //                 fontFamily: ConstFont.bold),
                //           ),
                //         ): SizedBox(),
                //         ListView.builder(
                //           reverse: false,
                //           controller: ScrollController(),
                //           shrinkWrap: true,
                //           itemCount: monthRecords.length,
                //           itemBuilder: (context, index) {
                //             return Container(
                //               color: deleteController.selectedIndices.contains(index) ? ConstColour.buttonColor.withOpacity(0.5) : ConstColour.appColor,
                //               child: ListTile(
                //                 onTap: () {
                //                   weightController.weightId.value = monthRecords[index].id.toInt();
                //                   Get.to(() => UpdateWeightScreen(
                //                     catId: monthRecords[index].id.toString(),
                //                   ));
                //                 },
                //                 onLongPress: () {
                //                   setState(() {
                //                     if (deleteController.selectedIndices.contains(index)) {
                //                       deleteController.selectedIndices.remove(index);
                //                       print("if");
                //                     } else {
                //                       deleteController.flag.value = true;
                //                       deleteController.selectedIndices.add(index);
                //                       print("else");
                //                     }
                //                   });
                //                 },
                //                 leading: Stack(
                //                     alignment: Alignment.center,
                //                     children: [
                //                       Image.asset(
                //                         "assets/Icons/line.png",
                //                       ),
                //                       Container(
                //                         width: deviceWidth * 0.07,
                //                         height: deviceHeight * 0.02,
                //                         decoration: BoxDecoration(
                //                             shape: BoxShape.circle,
                //                             image: DecorationImage(
                //                               image: AssetImage(
                //                                 "assets/Icons/circle.png",
                //                               ),)
                //                         ),
                //                       ),
                //                     ]
                //                 ),
                //                 title: Row(
                //                   children: [
                //                     Text(
                //                       monthRecords[index].dateTime,
                //                       style: TextStyle(
                //                           fontSize: 16,
                //                           color: ConstColour.greyTextColor,
                //                           fontFamily: ConstFont.regular
                //                       ),
                //                     ),
                //                     Padding(
                //                       padding: EdgeInsets.only(left: deviceWidth * 0.03),
                //                       child: Text(
                //                         monthRecords[index].time.toString(),
                //                         style: TextStyle(
                //                             fontSize: 16,
                //                             color: ConstColour.greyTextColor,
                //                             fontFamily: ConstFont.regular
                //                         ),
                //                       ),
                //                     ),
                //                   ],
                //                 ),
                //                 trailing: RichText(
                //                   text: TextSpan(
                //                     children: <TextSpan>[
                //                       TextSpan(
                //                         // text: bloodSugarController.filterLists[index].weight.toString(),
                //                         // text: '${unitController.selectIndex.value == 2 ?
                //                         // bloodSugarController.filterLists[index].weight :
                //                         // bloodSugarController.filterLists[index].weight * 2.2046}',
                //                         text: convertWeightValue(
                //                           monthRecords[index].weight,
                //                           // weightController.isKGSelected!.value,
                //                           weightController.newVal.value,
                //                         ),
                //                         style:  TextStyle(
                //                             fontSize: 28,
                //                             color: ConstColour.textColor,
                //                             fontFamily: ConstFont.bold
                //                         ),
                //                       ),
                //                       TextSpan(
                //                         // text:' ${unitController.selectIndex.value == 2 ? 'kg' : 'lbs'}',
                //                         text:' ${weightController.newVal.value == true ? 'kg' : 'lbs'}',
                //                         style: TextStyle(
                //                             fontSize: 12,
                //                             color: ConstColour.greyTextColor,
                //                             fontFamily: ConstFont.regular
                //                         ),
                //                       ),
                //                     ],
                //                   ),
                //                 ),
                //               ),
                //             );
                //           },
                //         ),
                //       ],
                //     );
                //   },
                // ),
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
      //                 child: bloodSugarController.filterLists.isEmpty
      //                     ? Center(
      //                   child: Text(
      //                     "No data available",
      //                     style: TextStyle(
      //                       fontSize: 30,
      //                       color: ConstColour.textColor,
      //                       fontFamily: ConstFont.regular,
      //                     ),
      //                   )
      //                 )
      //                     : ListView.builder(
      //                   reverse: true,
      //                   controller: ScrollController(),
      //                   shrinkWrap: true,
      //                   itemCount: bloodSugarController.filterLists.length,
      //                   itemBuilder: (context, index) {
      //                     return ListTile(
      //                       onTap: () {
      //                         weightController.weightId.value = bloodSugarController.filterLists[index].id.toInt();
      //                         Get.to(() => UpdateWeightScreen(
      //                           catId: bloodSugarController.filterLists[index].id.toString(),
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
      //                           Text(
      //                             bloodSugarController.filterLists[index].dateTime,
      //                             style: TextStyle(
      //                                 fontSize: 16,
      //                                 color: ConstColour.greyTextColor,
      //                                 fontFamily: ConstFont.regular
      //                             ),
      //                           ),
      //                           Padding(
      //                             padding: EdgeInsets.only(left: deviceWidth * 0.03),
      //                             child: Text(
      //                               bloodSugarController.filterLists[index].time.toString(),
      //                               style: TextStyle(
      //                                   fontSize: 16,
      //                                   color: ConstColour.greyTextColor,
      //                                   fontFamily: ConstFont.regular
      //                               ),
      //                             ),
      //                           ),
      //                         ],
      //                       ),
      //                       trailing: RichText(
      //                         text: TextSpan(
      //                           children: <TextSpan>[
      //                             TextSpan(
      //                               // text: bloodSugarController.filterLists[index].weight.toString(),
      //                               // text: '${unitController.selectIndex.value == 2 ?
      //                               // bloodSugarController.filterLists[index].weight :
      //                               // bloodSugarController.filterLists[index].weight * 2.2046}',
      //                               text: convertWeightValue(
      //                                 bloodSugarController.filterLists[index].weight,
      //                                 // weightController.isKGSelected!.value,
      //                                 weightController.newVal.value,
      //                               ),
      //                               style:  TextStyle(
      //                                   fontSize: 28,
      //                                   color: ConstColour.textColor,
      //                                   fontFamily: ConstFont.bold
      //                               ),
      //                             ),
      //                             TextSpan(
      //                               // text:' ${unitController.selectIndex.value == 2 ? 'kg' : 'lbs'}',
      //                               text:' ${weightController.newVal.value == true ? 'kg' : 'lbs'}',
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
      //     );}
      //   },
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
      // print(convertedWeight.toString() + "11ythghg");
      return convertedWeight.toStringAsFixed(1);
      // 1 lbs = 1 x 0.45359237 kg
    } else { // kg
      // print(value.toString()+"else call");
      return value.toStringAsFixed(1);
    }
  }
}
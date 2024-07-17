import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:health_care_dairy/DatabaseHandler/dbhelper.dart';
import 'package:intl/intl.dart';

import '../Common/bottom_button.dart';
import '../ConstFile/constColors.dart';
import '../ConstFile/constFonts.dart';
import '../Screens/Setting/notification/service.dart';

class NotificationController extends GetxController {

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    refreshNotification();
  }

  TextEditingController notificationNameController = TextEditingController();

 // DateTime current_Datetime = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, DateTime.now().hour, DateTime.now().minute);

  DateFormat formatter = DateFormat('h:mm a');
  DateTime current_Datetime =  DateTime.now();
  RxInt selectedType = 1.obs;
  RxBool weekNameType = false.obs;

  setSelectedType(val) {
    selectedType.value = val;
    if (selectedType.value == 1) {
      weekNameType.value = false;
    } else {
      weekNameType.value = true;
    }
    debugPrint(selectedType.value.toString());
  }

  String formatCurrentTime() {
    DateTime currentTime = DateTime.now();
    DateFormat formatter = DateFormat('h:mm a');
    String formattedCurrentTime = formatter.format(currentTime);

    return formattedCurrentTime;
  }

  final Rx<TimeOfDay> selectedTime = TimeOfDay.now().obs;
  final RxString formattedTime = ''.obs;

  Future<void> pickTime() async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: Get.context!,
      initialTime: selectedTime.value,
      initialEntryMode: TimePickerEntryMode.dial,
      helpText: ' ',
      errorInvalidText: 'Provide valid time',
      hourLabelText: 'Hour',
      minuteLabelText: 'Minute',
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
              alwaysUse24HourFormat: false
          ),
          child:Theme(
              data: ThemeData.dark().copyWith(
                  colorScheme: ColorScheme.dark(
                    primary: ConstColour.buttonColor,
                    onPrimary: Colors.white,
                    surface: ConstColour.appColor,
                    onSurface: ConstColour.textColor,
                  ),
                  dialogBackgroundColor: ConstColour.buttonColor
              ),
              child: child!
          ),
        );
      },
    );
    if(pickedTime != null && pickedTime != selectedTime.value) {
      formattedTime.value = formatTimeOfDay(pickedTime);
      // bloodSugarController.setSelectedTime(pickedTime);
      print("time" + formattedTime.value.toString());
    }
  }
  String formatTimeOfDay(TimeOfDay timeOfDay) {
    final now = DateTime.now();
    final TimeOfDay datetime = timeOfDay;
    String customFormattedTimeOfDay = '${timeOfDay.hourOfPeriod}:${timeOfDay.minute.toString().padLeft(2, '0')} ${timeOfDay.period == DayPeriod.am ? 'AM' : 'PM'}';

  //  final TimeOfDay formatter = TimeOfDay('h:mm a');
    return customFormattedTimeOfDay;
  }

  TimeOfDay stringToTime(String timeOfDay) {
    try {
      final DateFormat formatter = DateFormat('h:mm a');
      final DateTime dateTime = formatter.parse(timeOfDay);
      return TimeOfDay(hour: dateTime.hour, minute: dateTime.minute);
    } catch (e) {
      print('Error parsing time: $e');
      // Return a default time (e.g., 12:00 AM) if parsing fails
      return TimeOfDay(hour: 0, minute: 0);
    }
  }

  List<String> weekNames = <String>[
    "Sun",
    "Mon",
    "Tue",
    "Wed",
    "Thu",
    "Fri",
    "Sat"
  ];
  Set<int> selected = {};
  RxList<Map<String, dynamic>> journals = <Map<String, dynamic>>[].obs;
  RxBool isLoading = true.obs;

  void refreshNotification() async {
    deleteRecordList.clear();
   // journals = [];
    selectedIndices.clear();
    final data = await DbHelper.getItems();
    journals.value = data;
    // journals = data.map((map) => CategoryList.fromJson(map)).toList();
    isLoading.value = false;
  }

  // Insert a new notification database
  Future<void> addItem() async {
    String selectedValue;

    if (selectedType.value == 1 && selected.isEmpty) {
      selectedValue = "Everyday";
    } else if (selectedType.value == 2 && selected.isNotEmpty) {
      selectedValue = selected.map((index) => weekNames[index]).join(", ");
    } else {
      selectedValue = "Everyday";
    }

    await DbHelper.createItem(
      notificationNameController.text,
      selectedValue,
      formattedTime.value.isEmpty
          ? formatter.format(current_Datetime)
          : formattedTime.value,
    );
    refreshNotification();
  }
  // Future<void> addItem() async {
  //   await DbHelper.createItem(
  //       notificationNameController.text,
  //       selectedType.value == 1 ? "Everyday" : weekNames.toString(),
  //     dateTimeController.formattedTime.value.isEmpty
  //       ? formatter.format(current_Datetime)
  //       : dateTimeController.formattedTime.value);
  //   refreshNotification();
  // }

  // Update an existing notification

  Future<void> updateItem(int id) async {
    String selectedValue;

    if (selectedType.value == 1 && selected.isEmpty) {
      selectedValue = "Everyday";
    } else if (selectedType.value == 2 && selected.isNotEmpty) {
      selectedValue = selected.map((index) => weekNames[index]).join(", ");
    } else {
      selectedValue = "Everyday";
    }

    final formatter = DateFormat('h:mm a');
    String notificationTime;

    try {
      notificationTime = formattedTime.value.isEmpty
          ? formatter.format(current_Datetime)
          : formattedTime.value;
      // notificationTime = formatter.format(current_Datetime);
    } catch (e) {
      print('Error parsing date-time: $e');
      // Handle the error appropriately
      return;
    }

    await DbHelper.updateItem(
        id,
        notificationNameController.text,
        selectedValue,
        notificationTime
    );
    refreshNotification();
  }

  // Future<void> updateList(int id) async {
  //   String selectedValue;
  //
  //   if (selectedType.value == 1 && selected.isEmpty) {
  //     selectedValue = "Everyday";
  //   } else if (selectedType.value == 2 && selected.isNotEmpty) {
  //     selectedValue = selected.map((index) => weekNames[index]).join(", ");
  //   } else {
  //     selectedValue = "Everyday";
  //   }
  //
  //   await DbHelper.updateItem(
  //     id,
  //     notificationNameController.text,
  //     selectedValue,
  //     formattedTime.value.isEmpty
  //         ? formatter.format(current_Datetime)
  //         : formattedTime.value,
  //   );
  //   refreshNotification();
  // }

  Future<void> showNotification(int id) async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    // final IOSInitializationSettings initializationSettingsIOS =  IOSInitializationSettings();
    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      // iOS: initializationSettingsIOS
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      importance: Importance.max,
      priority: Priority.high,
      // icon: '@mipmap/ic_launcher'
      // largeIcon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
    );
    const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      notificationNameController.text,
      'It\'s time to punch your record.',
      platformChannelSpecifics,
      payload: 'item id $id',
    );
  }

  void showForm(int? id) async {
    if(id != null) {
      final existingJournal =
      journals.firstWhere((element) => element['id'] == id);
      notificationNameController.text = existingJournal['title'];
      // selected = existingJournal['description'];
      if (existingJournal['description'] != null &&
          existingJournal['description'].isNotEmpty) {
        weekNameType.value = true; // or false, depending on your logic
      } else {
        weekNameType.value = false; // or true, depending on your logic
      }
      formattedTime.value = existingJournal['time'];
      }

    // void showForm(int? id) async {
    //   if(id != null) {
    //     final existingJournal =
    //     journals.firstWhere((element) => element.id == id);
    //     notificationNameController.text = existingJournal.title;
    //     selectedType.value = existingJournal.description;
    //     dateTimeController.formattedTime.value = existingJournal.time!;
    //   }

    // void notificationDialog() {
    showDialog(
      barrierDismissible: false,
      context: Get.context!,
      builder: (context) {
        var deviceHeight = MediaQuery.of(context).size.height;
        var deviceWidth = MediaQuery.of(context).size.width;
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              insetAnimationCurve: Curves.linear,
              backgroundColor: ConstColour.appColor,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: ConstColour.appColor,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: ConstColour.appColor,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: deviceWidth * 0.03
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: deviceHeight * 0.03),
                        child: Image.asset(
                          'assets/Images/notification_icon.png',
                          fit: BoxFit.cover,
                          height: deviceHeight * 0.08,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: deviceHeight * 0.02),
                        child: Text(
                          "Add Notification",
                          style: TextStyle(
                              fontSize: 23,
                              color: ConstColour.textColor,
                              fontFamily: ConstFont.bold
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: deviceHeight * 0.02
                        ),
                        child: TextFormField(
                          controller: notificationNameController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.text,
                          autocorrect: true,
                          style: TextStyle(
                              fontSize: 18,
                              color: ConstColour.textColor
                          ),
                          cursorColor: ConstColour.buttonColor,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[200],
                            isDense: true,
                            hintText: "Notification Name",
                            hintStyle: TextStyle(
                                fontSize: 18,
                                fontFamily: ConstFont.regular,
                                color: ConstColour.greyTextColor
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: deviceHeight * 0.01),
                        child: InkWell(
                          onTap: () => pickTime(),
                          child: Text(formattedTime.value.isEmpty
                              ? formatter.format(current_Datetime)
                              : formattedTime.value,
                            style: TextStyle(
                                fontSize: 35,
                                fontFamily: ConstFont.bold,
                                color: ConstColour.buttonColor
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: deviceHeight * 0.01),
                        child: Text(
                          "Notification Time",
                          style: TextStyle(
                              fontSize: 15,
                              color: ConstColour.greyTextColor,
                              fontFamily: ConstFont.regular,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: deviceHeight * 0.01,
                            left: deviceWidth * 0.01
                        ),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Type",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                fontFamily: ConstFont.regular
                            ),
                          ),
                        ),
                      ),
                      Obx(() => Padding(
                        padding: EdgeInsets.only(top: deviceHeight * 0.01),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                                child: Row(
                                  children: [
                                    Radio(
                                      value: 1,
                                      groupValue: selectedType.value,
                                      onChanged: setSelectedType,
                                      activeColor: ConstColour.buttonColor,
                                    ),
                                    Text(
                                      "Everyday",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: ConstFont.regular,
                                          color: selectedType.value == 1
                                              ? ConstColour.textColor
                                              : ConstColour.greyTextColor
                                      ),
                                    ),
                                  ],
                                )
                            ),
                            Expanded(
                                child: Row(
                                  children: [
                                    Radio(
                                      value: 2,
                                      groupValue: selectedType.value,
                                      onChanged: setSelectedType,
                                      activeColor: ConstColour.buttonColor,
                                    ),
                                    Text(
                                      "On Certain Days",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: ConstFont.regular,
                                          color: selectedType.value == 2
                                              ? ConstColour.textColor
                                              : ConstColour.greyTextColor
                                      ),
                                    ),
                                  ],
                                )
                            ),
                          ],
                        ),
                      ),
                      ),

                      Obx(() => Visibility(
                        visible: weekNameType.value,
                        child: Container(
                          color: ConstColour.appColor,
                          height: deviceHeight * 0.05,
                          child: ListView.builder(
                              itemCount: weekNames.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (selected.contains(index)) {
                                        selected.remove(index);
                                      } else {
                                        selected.add(index);
                                      }
                                    });
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: deviceWidth * 0.015
                                    ),
                                    child: Container(
                                      width: deviceWidth * 0.11,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8),
                                          color: selected.contains(index)
                                              ? ConstColour.buttonColor
                                              : ConstColour.appColor
                                      ),
                                      child: Center(
                                        child: Text(
                                          weekNames[index],
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: ConstFont.bold,
                                              color: selected.contains(index)
                                                  ? ConstColour.appColor
                                                  : ConstColour.greyTextColor
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }
                          ),
                        ),
                      ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: deviceHeight * 0.02),
                        child: NextButton(
                          onPressed: () async {
                            if(id == null) {
                              // await addItem(selected);
                              await addItem();
                            }
                            Get.back();
                            // Navigator.pop(context);
                          },
                          btnName: "Save",
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(top: deviceHeight * 0.01),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  elevation: 0.0,
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide.none,
                                      borderRadius: BorderRadius.circular(50)),
                                  minimumSize: Size(deviceWidth * 0.9, deviceHeight * 0.06),
                                  backgroundColor: ConstColour.appColor
                              ),
                              onPressed: () {
                                Get.back();
                                // Navigator.pop(context);
                              },
                              child: Text(
                                "Cancel",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: ConstColour.textColor
                                ),
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                              )
                          )
                      ),
                      SizedBox(
                        height: deviceHeight * 0.01,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void updateForm(int? id) async {
    if(id != null) {
      final existingJournal =
      journals.firstWhere((element) => element['id'] == id);
      notificationNameController.text = existingJournal['title'];
      String selectedValue;

      if (selectedType.value == 1 && selected.isEmpty) {
        selectedValue = "Everyday";
      } else if (selectedType.value == 2 && selected.isNotEmpty) {
        selectedValue = selected.map((index) => weekNames[index]).join(", ");
      } else {
        selectedValue = "Everyday";
      }
      // if (existingJournal['description'] != null && existingJournal['description'].isNotEmpty) {
      //   weekNameType.value = true;
      // } else {
      //   weekNameType.value = false;
      // }
      // var dateTime = dateTimeController.stringToTime(existingJournal['time'].toString());
      // dateTimeController.selectedTime.value = dateTime;
      selectedTime.value = stringToTime(existingJournal['time'].toString());
      formattedTime.value = existingJournal['time'].toString();
    }

    showDialog(
      barrierDismissible: false,
      context: Get.context!,
      builder: (context) {
        var deviceHeight = MediaQuery.of(context).size.height;
        var deviceWidth = MediaQuery.of(context).size.width;
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              insetAnimationCurve: Curves.linear,
              backgroundColor: ConstColour.appColor,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: ConstColour.appColor,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: ConstColour.appColor,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: deviceWidth * 0.03
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: deviceHeight * 0.03),
                        child: Image.asset(
                          'assets/Images/notification_icon.png',
                          fit: BoxFit.cover,
                          height: deviceHeight * 0.08,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: deviceHeight * 0.02),
                        child: Text(
                          "Update Notification",
                          style: TextStyle(
                              fontSize: 23,
                              color: ConstColour.textColor,
                              fontFamily: ConstFont.bold
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: deviceHeight * 0.02
                        ),
                        child: TextFormField(
                          controller: notificationNameController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.text,
                          autocorrect: true,
                          style: TextStyle(
                              fontSize: 18,
                              color: ConstColour.textColor
                          ),
                          cursorColor: ConstColour.buttonColor,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[200],
                            isDense: true,
                            hintText: "Notification Name",
                            hintStyle: TextStyle(
                                fontSize: 18,
                                fontFamily: ConstFont.regular,
                                color: ConstColour.greyTextColor
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none
                            ),
                          ),
                        ),
                      ),
                      Obx(
                        () =>  Padding(
                          padding: EdgeInsets.only(top: deviceHeight * 0.01),
                          child: InkWell(
                            onTap: () {
                              pickTime();
                            },
                            child: Text(formattedTime.value.isEmpty
                                ? formatter.format(current_Datetime)
                                : formattedTime.value,
                              style: TextStyle(
                                  fontSize: 35,
                                  fontFamily: ConstFont.bold,
                                  color: ConstColour.buttonColor
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: deviceHeight * 0.01),
                        child: Text(
                          "Notification Time",
                          style: TextStyle(
                              fontSize: 15,
                              color: ConstColour.greyTextColor,
                              fontFamily: ConstFont.regular,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: deviceHeight * 0.01,
                            left: deviceWidth * 0.01
                        ),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Type",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                fontFamily: ConstFont.regular
                            ),
                          ),
                        ),
                      ),

                      Obx(() => Padding(
                        padding: EdgeInsets.only(top: deviceHeight * 0.01),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                                child: Row(
                                  children: [
                                    Radio(
                                      value: 1,
                                      groupValue: selectedType.value,
                                      onChanged: setSelectedType,
                                      activeColor: ConstColour.buttonColor,
                                    ),
                                    Text(
                                      "Everyday",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: ConstFont.regular,
                                          color: selectedType.value == 1
                                              ? ConstColour.textColor
                                              : ConstColour.greyTextColor
                                      ),
                                    ),
                                  ],
                                )
                            ),
                            Expanded(
                                child: Row(
                                  children: [
                                    Radio(
                                      value: 2,
                                      groupValue: selectedType.value,
                                      onChanged: setSelectedType,
                                      activeColor: ConstColour.buttonColor,
                                    ),
                                    Text(
                                      "On Certain Days",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: ConstFont.regular,
                                          color: selectedType.value == 2
                                              ? ConstColour.textColor
                                              : ConstColour.greyTextColor
                                      ),
                                    ),
                                  ],
                                )
                            ),
                          ],
                        ),
                      ),),
                      Obx(() => Visibility(
                        visible: weekNameType.value,
                        child: Container(
                          color: ConstColour.appColor,
                          height: deviceHeight * 0.05,
                          child: ListView.builder(
                              itemCount: weekNames.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (selected.contains(index)) {
                                        selected.remove(index);
                                      } else {
                                        selected.add(index);
                                      }
                                    });
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: deviceWidth * 0.015
                                    ),
                                    child: Container(
                                      width: deviceWidth * 0.11,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8),
                                          color: selected.contains(index)
                                              ? ConstColour.buttonColor
                                              : ConstColour.appColor
                                      ),
                                      child: Center(
                                        child: Text(
                                          weekNames[index],
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: ConstFont.bold,
                                              color: selected.contains(index)
                                                  ? ConstColour.appColor
                                                  : ConstColour.greyTextColor
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }
                          ),
                        ),
                      ),
                      //     Visibility(
                      //   visible: weekNameType.value,
                      //   child: Container(
                      //     color: ConstColour.appColor,
                      //     height: deviceHeight * 0.05,
                      //     child: ListView.builder(
                      //         itemCount: weekNames.length,
                      //         scrollDirection: Axis.horizontal,
                      //         itemBuilder: (BuildContext context, int index) {
                      //           return GestureDetector(
                      //             onTap: () {
                      //               setState(() {
                      //                 if (selected.contains(index)) {
                      //                   selected.remove(index);
                      //                 } else {
                      //                   selected.add(index);
                      //                 }
                      //               });
                      //               // weekNameType.value == index;
                      //             },
                      //             child: Padding(
                      //               padding: EdgeInsets.symmetric(
                      //                   horizontal: deviceWidth * 0.015
                      //               ),
                      //               child: Container(
                      //                 width: deviceWidth * 0.11,
                      //                 decoration: BoxDecoration(
                      //                     borderRadius: BorderRadius.circular(8),
                      //                     color: selected.contains(index)
                      //                         ? ConstColour.buttonColor
                      //                         : ConstColour.appColor
                      //                     // color: weekNameType.value
                      //                     //     ? ConstColour.buttonColor
                      //                     //     : ConstColour.appColor
                      //                 ),
                      //                 child: Center(
                      //                   child: Text(
                      //                     weekNames[index],
                      //                     style: TextStyle(
                      //                         fontSize: 15,
                      //                         color: selected.contains(index)
                      //                             ? ConstColour.greyTextColor
                      //                             : ConstColour.appColor
                      //                         // color: weekNameType.value == index
                      //                         //     ? ConstColour.greyTextColor
                      //                         //     : ConstColour.appColor
                      //                     ),
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //           );
                      //         }
                      //     ),
                      //   ),
                      // ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: deviceHeight * 0.02),
                        child: NextButton(
                          onPressed: () async {
                            if(id != null) {
                              await updateItem(id);
                              // await updateList(id);
                            }
                            notificationNameController.text = '';
                            // selectedType.value == 1
                            //     ? "Everyday"
                            //     : selectedType.value == 2
                            //     ? weekNames.toString()
                            //     : " ";
                            // formattedTime.value.isEmpty
                            //     ? formatter.format(current_Datetime)
                            //     : formattedTime.value;
                            Get.back();
                            // Navigator.pop(context);
                          },
                          btnName: "Save",
                          // btnName: "Save",
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(top: deviceHeight * 0.01),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  elevation: 0.0,
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide.none,
                                      borderRadius: BorderRadius.circular(50)),
                                  minimumSize: Size(deviceWidth * 0.9, deviceHeight * 0.06),
                                  backgroundColor: ConstColour.appColor
                              ),
                              onPressed: () {
                                Get.back();
                                // Navigator.pop(context);
                              },
                              child: Text(
                                "Cancel",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: ConstColour.textColor
                                ),
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                              )
                          )
                      ),
                      SizedBox(
                        height: deviceHeight * 0.01,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  // Delete an item
  // void deleteItem(int index) async {
  //   await DbHelper.deleteItem(journals[index]['id']);
  //   refreshNotification();
  // }

  RxBool flag = false.obs;

  RxSet<int> selectedIndices = <int>{}.obs;
  var deleteRecordList = Set<int>().obs;

  // void deleteSelected() {
  //   List<Map<String, dynamic>> tempList = [];
  //
  //   for (int i = 0; i < journals.length; i++) {
  //     if (!selectedIndices.contains(i)) {
  //       tempList.add(journals[i]);
  //     }
  //   }
  //   journals.value=[];
  //   journals.assignAll(tempList);
  //   // journals = List.from(tempList);
  //   selectedIndices.clear();
  // }

void notificationDeleteDialog(int index) {
    showDialog(
      barrierDismissible: false,
      context: Get.context!,
      builder: (context) {
        var deviceHeight = MediaQuery.of(context).size.height;
        var deviceWidth = MediaQuery.of(context).size.width;
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              insetAnimationCurve: Curves.linear,
              backgroundColor: ConstColour.appColor,
              child: WillPopScope(
                onWillPop: () async {
                  SystemNavigator.pop();
                  return true;
                },
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: ConstColour.appColor,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: ConstColour.appColor,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.4),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: deviceWidth * 0.03
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: deviceHeight * 0.03),
                          child: Image.asset(
                            'assets/Images/delete.png',
                            fit: BoxFit.cover,
                            height: deviceHeight * 0.07,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: deviceHeight * 0.02),
                          child: Text(
                            "Delete",
                            style: TextStyle(
                                fontSize: 23,
                                color: ConstColour.textColor,
                                fontFamily: ConstFont.bold
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: deviceHeight * 0.02,
                          ),
                          child: Text(
                            "Are you sure, you want to delete this Notification Alarm?",
                            style: TextStyle(
                                fontSize: 18,
                                color: ConstColour.greyTextColor,
                                fontFamily: ConstFont.regular
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: deviceHeight * 0.02),
                          child: NextButton(
                            onPressed: () {
                              if (selectedIndices.isEmpty) {
                                Get.back();
                              } else {
                                // deleteItem(journals['id']);
                                deleteMultiRecord(deleteRecordList);
                                //deleteItem(index);
                              //  deleteSelected();

                                Get.back();
                              }
                            },
                            btnName: "Yes, sure",
                          ),
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                elevation: 0.0,
                                shape: RoundedRectangleBorder(
                                    side: BorderSide.none,
                                    borderRadius: BorderRadius.circular(50)),
                                minimumSize: Size(deviceWidth * 0.9, deviceHeight * 0.06),
                                backgroundColor: ConstColour.appColor
                            ),
                            onPressed: () {
                              Get.back();
                            },
                            child: Text(
                              "Cancel",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: ConstColour.textColor
                              ),
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            )
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void deleteMultiRecord(RxSet<int> deleteRecordList) async {
    List<int> list = deleteRecordList.toList();
    for (int index = 0; index < list.length; index++) {
      await DbHelper.deleteItem(list[index]);
      }
    refreshNotification();
  }

}

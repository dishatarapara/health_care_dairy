import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_care_dairy/Controller/blood_sugar_controller.dart';
import 'package:intl/intl.dart';

import '../ConstFile/constColors.dart';


class DateTimeController extends GetxController {
  // BloodSugarController bloodSugarController = Get.put(BloodSugarController());

  final RxString formattedTime = ''.obs;

  final Rx<DateTime> selectedDate = DateTime.now().obs;
  final Rx<TimeOfDay> selectedTime = TimeOfDay.now().obs;

  // Future<void> pickDate() async {
  //   DateTime? pickedDate = await showDatePicker(
  //     context: Get.context!,
  //     firstDate: DateTime(1990),
  //     lastDate: DateTime.now(),
  //     initialDate: selectedDate.value,
  //     initialDatePickerMode: DatePickerMode.day,
  //     initialEntryMode: DatePickerEntryMode.calendarOnly,
  //     helpText: ' ',
  //     builder: (BuildContext context, picker) {
  //       return Theme(
  //           data: ThemeData.dark().copyWith(
  //               colorScheme: ColorScheme.dark(
  //                   primary: ConstColour.buttonColor,
  //                   onPrimary: Colors.white,
  //                   surface: ConstColour.appColor,
  //                   onSurface: ConstColour.textColor
  //               ),
  //               dialogBackgroundColor: ConstColour.buttonColor
  //           ),
  //           child: picker!
  //       );
  //     },
  //   );
  //
  //   if (pickedDate != null && pickedDate != selectedDate.value) {
  //     selectedDate.value = pickedDate;
  //   }
  // }

  var startdate = DateTime.now().add(Duration(hours: -TimeOfDay.now().hour, minutes: -TimeOfDay.now().minute)).millisecondsSinceEpoch.obs;



  Future<void> pickDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: selectedDate.value,
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      initialDatePickerMode: DatePickerMode.day,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      helpText: ' ',
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: ConstColour.buttonColor,
              // header background color
              onPrimary: Colors.white,
              // header text color
              onSurface: Colors.black, // body text color
            ),
          ),
          child: child!,
        );
      },
    );
    if (pickedDate != null) {
      startdate.value = pickedDate.millisecondsSinceEpoch;
        selectedDate.value = pickedDate;
    }
    debugPrint(DateFormat('dd/MM/yyyy').format(selectedDate.value));
  }



  // Future<void> pickTime() async {
  //   TimeOfDay? pickedTime = await showTimePicker(
  //     context: Get.context!,
  //     initialTime: selectedTime.value,
  //     initialEntryMode: TimePickerEntryMode.dial,
  //     helpText: ' ',
  //     errorInvalidText: 'Provide valid time',
  //     hourLabelText: 'Hour',
  //     minuteLabelText: 'Minute',
  //     builder: (BuildContext context, Widget? child) {
  //       return MediaQuery(
  //         data: MediaQuery.of(context).copyWith(
  //             alwaysUse24HourFormat: false
  //         ),
  //         child:Theme(
  //             data: ThemeData.dark().copyWith(
  //                 colorScheme: ColorScheme.dark(
  //                   primary: ConstColour.buttonColor,
  //                     onPrimary: Colors.white,
  //                     surface: ConstColour.appColor,
  //                     onSurface: ConstColour.textColor,
  //                 ),
  //               dialogBackgroundColor: ConstColour.buttonColor
  //             ),
  //             child: child!
  //         ),
  //       );
  //     },
  //   );
  //   if(pickedTime != null && pickedTime != selectedTime.value) {
  //     selectedTime.value = pickedTime;
  //   }
  // }

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
      print("fgdfgfsv" + formattedTime.value.toString());
    }
  }

  String formatTimeOfDay(TimeOfDay timeOfDay) {
    final now = DateTime.now();
    final DateTime datetime = DateTime(now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
    final DateFormat formatter = DateFormat('h:mm a');
    return formatter.format(datetime);
  }

  TimeOfDay stringToTime(String timeOfDay) {
    final DateFormat formatter = DateFormat('h:mm a');
    return TimeOfDay.fromDateTime(formatter.parse(timeOfDay));
  }
}
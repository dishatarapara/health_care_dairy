import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_care_dairy/Controller/delete_controller.dart';
import 'package:health_care_dairy/Controller/notification_controller.dart';
import 'package:health_care_dairy/Common/loader.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:intl/intl.dart';

import '../../../ConstFile/constColors.dart';
import '../../../ConstFile/constFonts.dart';
import '../../../Controller/date_time_controller.dart';
import 'notification_service.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  NotificationController notificationController = Get.put(NotificationController());
  DateTimeController dateTimeController = Get.put(DateTimeController());
  DeleteController deleteController = Get.put(DeleteController());

  DateTime current_Datetime = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, DateTime.now().hour, DateTime.now().minute);
  DateFormat formatter = DateFormat('h:mm a');

  // final _formKey = new GlobalKey<FormState>();

  // final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // notificationController.showForm(null);
    // initializeNotifications();
    // tz.initializeTimeZones();
    // NotificationService().showNotification();
    // NotificationService().showDailyTimeNotification();
    // NotificationService().initializeNotifications();
    // tz.initializeTimeZones();
    NotificationService().initializeNotifications();
    notificationController.refreshNotification();
    print("..number of items ${notificationController.journals.length}");

    // checkAndDisplayNotifications();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   checkAndDisplayNotifications();
    // });
  }

  // Future<void> initializeNotifications() async {
  //   const AndroidInitializationSettings initializationSettingsAndroid =
  //   AndroidInitializationSettings('@mipmap/ic_launcher');
  //
  //   final InitializationSettings initializationSettings =
  //   InitializationSettings(android: initializationSettingsAndroid);
  //
  //   await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  // }
  //
  // Future<void> displayLocalNotification() async {
  //   const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
  //     'your_channel_id',
  //     'your_channel_name',
  //     importance: Importance.max,
  //     priority: Priority.high,
  //   );
  //   const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
  //   await flutterLocalNotificationsPlugin.show(
  //     0,
  //     notificationController.notificationNameController.text,
  //     'It\'s time to punch your record.',
  //     platformChannelSpecifics,
  //   );
  // }
  //
  // Future<void> checkAndDisplayNotifications() async {
  //   final String currentTime = formatter.format(current_Datetime);
  //
  //   print('Current Time: $currentTime');
  //
  //   for (var notification in notificationController.journals) {
  //     final String notificationTime = notification['time'];
  //     print('Notification Time: $notificationTime');
  //     if (notificationTime == currentTime) {
  //       print('Displaying notification for time: $currentTime');
  //       await displayLocalNotification();
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ConstColour.appColor,
        elevation: 0.0,
        title: Obx(
          () => Text(
            notificationController.flag.value == true
                ? "${notificationController.selectedIndices.length} selected"
                : "Notification",
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
            // Get.to(() => SettingScreen());
            Get.back();
          },
          icon: Icon(Icons.arrow_back),
          color: ConstColour.textColor,
        ),
        actions: [
          Obx(() =>  IconButton(
              onPressed: () {
                if(notificationController.flag.value == true) {
                  notificationController.flag.value = false;
                  notificationController.notificationDeleteDialog(0);
                } else {}
              },
              icon: notificationController.flag.value == true
                  ? Icon(
                  Icons.delete,
                  color: ConstColour.textColor
              )
                  : SizedBox()
          ),
          )
        ],
      ),
      backgroundColor: ConstColour.bgColor,
      body: Obx(() => RefreshIndicator(
          color: ConstColour.buttonColor,
          onRefresh: () async {
            notificationController.refreshNotification();
          },
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            controller: ScrollController(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  notificationController.journals.isEmpty
                  ? (notificationController.isLoading.value == false)
                  ? Padding(
                    padding: EdgeInsets.symmetric(vertical: deviceHeight * 0.3),
                    child: Align(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Image.asset(
                              "assets/Icons/notifications.png",
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
                              subtitle: Container(
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
                  : Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: ConstColour.appColor,
                    child: ListView.builder(
                      reverse: true,
                        shrinkWrap: true,
                        controller: ScrollController(),
                        itemCount: notificationController.journals.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onLongPress: () {
                              // notificationController.deleteItem(notificationController.journals[index]['id']);
                              // debugPrint("deleteItem");
                              setState(() {
                                if(notificationController.selectedIndices.isEmpty){
                                  notificationController.flag.value = false;
                                }
                                if (notificationController.selectedIndices.contains(index)) {
                                  notificationController.selectedIndices.remove(index);
                                  notificationController.deleteRecordList.remove(notificationController.journals[index]['id'].toString());
                                  print("if");
                                } else {
                                  notificationController.flag.value = true;
                                  notificationController.selectedIndices.add(index);
                                  notificationController.deleteRecordList.add(notificationController.journals[index]['id']);
                                  print("else");
                                }
                              });
                            },
                            child: Column(
                              children: [
                                Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: notificationController.selectedIndices.contains(index)
                                      ? ConstColour.buttonColor.withOpacity(0.5)
                                      : ConstColour.appColor,
                                ),
                                  child: ListTile(
                                    onTap: () async {
                                      if(notificationController.selectedIndices.isEmpty){
                                        notificationController.flag.value = false;
                                      }
                                      if(notificationController.flag.value == true){
                                        if (notificationController.selectedIndices.contains(index)) {
                                          notificationController.selectedIndices.remove(index);
                                          notificationController.deleteRecordList.remove(notificationController.journals[index]['id'].toString());
                                          print("if");
                                        } else {
                                          notificationController.flag.value = true;
                                          notificationController.selectedIndices.add(index);
                                          notificationController.deleteRecordList.add(notificationController.journals[index]['id']);
                                          print("else");
                                        }
                                        setState(() {});
                                      } else {
                                        // notificationController.notificationId.value = notificationController.journals[index]['id'].toInt();
                                        notificationController.updateForm(
                                            notificationController.journals[index]['id']);
                                        // NotificationService().showNotification();
                                        // NotificationService().showDailyTimeNotification();
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
                                          notificationController.notificationNameController.text,
                                          'It\'s time to punch your record.',
                                          platformChannelSpecifics,
                                          payload: 'item id ${notificationController.journals[index]['id']}',
                                        );
                                        // notificationController.updateItem(index);
                                      }
                                    },
                                    leading: Padding(
                                      padding: EdgeInsets.only(top: deviceHeight * 0.01),
                                      child: Container(
                                        width: deviceWidth * 0.07,
                                        height: deviceHeight * 0.025,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                              image: AssetImage(
                                                "assets/Images/notification_icon.png",
                                              ),
                                            )
                                          ),
                                        ),
                                    ),
                                    title: Text(
                                      notificationController.journals[index]['title'],
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: ConstColour.textColor,
                                          fontFamily: ConstFont.bold
                                      ),
                                    ),
                                    subtitle: Text(
                                      notificationController.journals[index]['description'],
                                      style: TextStyle(
                                          fontSize: 17,
                                          color: ConstColour.greyTextColor,
                                          fontFamily: ConstFont.regular
                                      ),
                                    ),
                                    trailing: Text(
                                      notificationController.journals[index]['time'],
                                      // dateTimeController.formattedTime.value.isEmpty
                                      //     ? formatter.format(current_Datetime)
                                      //     : dateTimeController.formattedTime.value,
                                      style: TextStyle(
                                          fontSize: 25,
                                          color: ConstColour.textColor,
                                          fontFamily: ConstFont.bold
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: deviceWidth * 0.18,
                                      right: deviceWidth * 0.04),
                                  child: Divider(height: deviceHeight * 0.001,),
                                )
                              ],
                            ),
                          );
                        }
                      ),
                  ),
                ],
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
    TimeOfDay currentTime = TimeOfDay.now();
    dateTimeController.selectedTime.value = currentTime;
    String formattedHour = currentTime.hourOfPeriod.toString();
    String formattedMinute = currentTime.minute.toString().padLeft(2, '0');
    String period = currentTime.period == DayPeriod.am ? 'AM' : 'PM';
    String formattedTime = '$formattedHour:$formattedMinute $period';
    dateTimeController.formattedTime.value = formattedTime;
    notificationController.selectedType.value = 2;
    notificationController.notificationNameController.text = "";

    notificationController.showForm(null);
    // Get.to(() => BloodSugarAddScreen());
  }
}

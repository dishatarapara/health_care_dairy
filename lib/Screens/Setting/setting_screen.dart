import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_care_dairy/ConstFile/constColors.dart';
import 'package:health_care_dairy/Controller/setting_screen_controller.dart';
import 'package:health_care_dairy/Screens/Setting/notification/notification_screen.dart';
import 'package:health_care_dairy/Screens/Setting/privacy/privacy_policy.dart';
import 'package:health_care_dairy/Screens/Setting/profile/profile_screen.dart';
import 'package:health_care_dairy/Screens/Setting/terms/TermsAndService.dart';
import 'package:health_care_dairy/Screens/home_screen.dart';
import 'package:health_care_dairy/Screens/Setting/unit_second_screen.dart';
import 'package:intl/intl.dart';

import '../../ConstFile/constFonts.dart';
import '../../ConstFile/constPreferences.dart';
import '../../Controller/date_time_controller.dart';
import '../login_screen.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  DateTimeController dateTimeController = Get.put(DateTimeController());
  SettingScreenController settingScreenController = Get.put(SettingScreenController());

  DateFormat formatter = DateFormat('h:mm a');
  DateTime current_Datetime = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      DateTime.now().hour,
      DateTime.now().minute);

  bool isSwitched = false;

  void toggleSwitch(bool value) {
    if(isSwitched == false) {
      setState(() {
        isSwitched = true;
      });
    } else {
      setState(() {
        isSwitched = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: ConstColour.bgColor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: ConstColour.appColor,
        leading: IconButton(
            onPressed: () {
              Get.to(() => HomeScreen());
            },
            icon: Icon(
              Icons.arrow_back,
              color: ConstColour.textColor,
            )
        ),
        title: Text(
          'Settings',
          style: TextStyle(
            fontSize: 22,
              color: ConstColour.textColor,
              fontFamily: ConstFont.regular,
              fontWeight: FontWeight.w800,
              overflow: TextOverflow.ellipsis
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: deviceWidth * 0.02
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: deviceHeight * 0.02
                ),
                child: Text(
                  "GENERAL SETTINGS",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: deviceHeight * 0.01
                ),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: deviceHeight * 0.01,
                    ),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Get.to(() => ProfileScreen());
                          },
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: ConstColour.settingIconColor,
                              radius: 20,
                              child: Image.asset(
                                "assets/Icons/profile.png",
                                color: ConstColour.settingColor,
                                fit: BoxFit.cover,
                                height: deviceHeight * 0.02,
                              ),
                            ),
                            title: Text(
                                "Profile",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: ConstFont.bold,
                                )
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              size: 20,
                              color: ConstColour.textColor,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(() => NotificationScreen());
                          },
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: ConstColour.settingIconColor,
                              radius: 20,
                              child: Image.asset(
                                  "assets/Images/notifications_setting.png",
                                fit: BoxFit.cover,
                                height: deviceHeight * 0.02,
                              ),
                            ),
                            title: Text(
                              "Notification",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: ConstFont.bold,
                                )
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              size: 20,
                              color: ConstColour.textColor,
                            ),
                          ),
                        ),
                        // InkWell(
                        //   onTap: () => toggleSwitch,
                        //   child: ListTile(
                        //     leading: CircleAvatar(
                        //       backgroundColor: ConstColour.settingIconColor,
                        //       radius: 20,
                        //       child: Image.asset(
                        //         "assets/Images/lock.png",
                        //         fit: BoxFit.cover,
                        //         height: deviceHeight * 0.02,
                        //       ),
                        //     ),
                        //     title: Row(
                        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //       children: [
                        //         Text(
                        //             "System App Lock",
                        //             style: TextStyle(
                        //               fontSize: 20,
                        //               fontFamily: ConstFont.bold,
                        //             )
                        //         ),
                        //         Transform.scale(
                        //           scale: 1,
                        //           child: Switch(
                        //               value: isSwitched,
                        //               onChanged: toggleSwitch,
                        //             activeColor: ConstColour.buttonColor,
                        //           ),
                        //         )
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        // InkWell(
                        //   onTap: () {
                        //     settingScreenController.showDateFormat();
                        //   },
                        //   child: ListTile(
                        //     leading: CircleAvatar(
                        //       backgroundColor: ConstColour.settingIconColor,
                        //       radius: 20,
                        //       child: Image.asset(
                        //         "assets/Images/date.png",
                        //         fit: BoxFit.cover,
                        //         height: deviceHeight * 0.02,
                        //       ),
                        //     ),
                        //     title: Row(
                        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //       children: [
                        //         Text(
                        //             "Date Format",
                        //             style: TextStyle(
                        //               fontSize: 20,
                        //               fontFamily: ConstFont.bold,
                        //             )
                        //         ),
                        //         Text(
                        //             DateFormat('dd/MM/yyyy').format(
                        //                 dateTimeController.selectedDate.value),
                        //             style: TextStyle(
                        //               fontSize: 15,
                        //             )
                        //         ),
                        //       ],
                        //     ),
                        //     trailing: Icon(
                        //       Icons.arrow_forward_ios,
                        //       size: 20,
                        //       color: ConstColour.textColor,
                        //     ),
                        //   ),
                        // ),
                        // InkWell(
                        //   onTap: () {
                        //     settingScreenController.showTimeFormat();
                        //   },
                        //   child: ListTile(
                        //     leading: CircleAvatar(
                        //       backgroundColor: ConstColour.settingIconColor,
                        //       radius: 20,
                        //       child: Image.asset(
                        //         "assets/Images/time.png",
                        //         fit: BoxFit.cover,
                        //         height: deviceHeight * 0.02,
                        //       ),
                        //     ),
                        //     title: Row(
                        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //       children: [
                        //         Text(
                        //             "Time Format",
                        //             style: TextStyle(
                        //               fontSize: 20,
                        //               fontFamily: ConstFont.bold,
                        //             )
                        //         ),
                        //         Text(dateTimeController.formattedTime.value.isEmpty
                        //             ? formatter.format(current_Datetime)
                        //             : dateTimeController.formattedTime.value,
                        //             style: TextStyle(
                        //               fontSize: 15,
                        //             )
                        //         ),
                        //       ],
                        //     ),
                        //     trailing: Icon(
                        //       Icons.arrow_forward_ios,
                        //       size: 20,
                        //       color: ConstColour.textColor,
                        //     ),
                        //   ),
                        // ),
                        InkWell(
                          onTap: () {
                            Get.to(() => UnitSecondScreen());
                          },
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: ConstColour.settingIconColor,
                              radius: 20,
                              child: Image.asset(
                                "assets/Images/unit_formate.png",
                                fit: BoxFit.cover,
                                height: deviceHeight * 0.02,
                              ),
                            ),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    "Unit Format",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: ConstFont.bold,
                                    )
                                ),
                                Text(
                                    "mg/dL, lbs, ºf",
                                    style: TextStyle(
                                      fontSize: 15,
                                    )
                                ),
                              ],
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              size: 20,
                              color: ConstColour.textColor,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            settingScreenController.showNumberFormat();
                          },
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: ConstColour.settingIconColor,
                              radius: 20,
                              child: Image.asset(
                                "assets/Images/number_formate.png",
                                fit: BoxFit.cover,
                                height: deviceHeight * 0.02,
                              ),
                            ),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    "Number Format",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: ConstFont.bold,
                                    )
                                ),
                                Text(
                                    "123456789",
                                    style: TextStyle(
                                      fontSize: 15,
                                    )
                                ),
                              ],
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              size: 20,
                              color: ConstColour.textColor,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: ConstColour.settingIconColor,
                              radius: 20,
                              child: Image.asset(
                                "assets/Images/backup_setting.png",
                                fit: BoxFit.cover,
                                height: deviceHeight * 0.02,
                              ),
                            ),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    "Backup & Restore",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: ConstFont.bold,
                                    )
                                ),
                                Image.asset(
                                    "assets/Images/premium.png",
                                  fit: BoxFit.cover,
                                  height: deviceHeight * 0.03,
                                )
                              ],
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              size: 20,
                              color: ConstColour.textColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: deviceHeight * 0.02
                ),
                child: Text(
                  "COMMUNICATION",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: deviceHeight * 0.01
                ),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: deviceHeight * 0.01,
                    ),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            String contentToShare =
                                'MySugar: Track Blood Sugar, Blood Pressure Keeps track of blood sugar level and other health factors - medication, weight - Track your blood glucose levels by time. \n • Daily reminders to get a notification at times you specify every day \n • Statistics (averages per week, per month, all time)';
                            settingScreenController.shareWithFriends(contentToShare);
                          },
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: ConstColour.bodyTembgColor,
                              radius: 20,
                              child: Image.asset(
                                "assets/Images/share.png",
                                fit: BoxFit.cover,
                                height: deviceHeight * 0.02,
                              ),
                            ),
                            title: Text(
                                "Share with friends",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: ConstFont.bold,
                                )
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              size: 20,
                              color: ConstColour.textColor,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            settingScreenController.showRateUsDialogBox();
                          },
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: ConstColour.bodyTembgColor,
                              radius: 20,
                              child: Image.asset(
                                "assets/Images/rate.png",
                                fit: BoxFit.cover,
                                height: deviceHeight * 0.02,
                              ),
                            ),
                            title: Text(
                                "Rate Us",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: ConstFont.bold,
                                )
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              size: 20,
                              color: ConstColour.textColor,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            // final url ='https://appworldinfotech.com/privacy_policy/index.html';
                            Get.to(() => PrivacyAndPolicyScreen());
                          },
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: ConstColour.bodyTembgColor,
                              radius: 20,
                              child: Image.asset(
                                "assets/Images/privacypolicy.png",
                                fit: BoxFit.cover,
                                height: deviceHeight * 0.02,
                              ),
                            ),
                            title: Text(
                                "Privacy Policy",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: ConstFont.bold,
                                )
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              size: 20,
                              color: ConstColour.textColor,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            // final url ='https://appworldinfotech.com/termsofservices/index.html';
                            Get.to(() => TermsOfServiceScreen());
                          },
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: ConstColour.bodyTembgColor,
                              radius: 20,
                              child: Image.asset(
                                "assets/Images/terms_of_service.png",
                                fit: BoxFit.cover,
                                height: deviceHeight * 0.02,
                              ),
                            ),
                            title: Text(
                                "Terms of Service",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: ConstFont.bold,
                                )
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              size: 20,
                              color: ConstColour.textColor,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.back();
                            ConstPreferences().clearPreferences();
                            Get.to(() => LoginScreen());
                          },
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: ConstColour.bodyTembgColor,
                              radius: 20,
                              child: Image.asset(
                                "assets/Icons/logout.png",
                                fit: BoxFit.cover,
                                height: deviceHeight * 0.02,
                              ),
                            ),
                            title: Text(
                                "Log Out",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: ConstFont.bold,
                                )
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              size: 20,
                              color: ConstColour.textColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

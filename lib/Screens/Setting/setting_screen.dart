import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_care_dairy/ConstFile/constColors.dart';
import 'package:health_care_dairy/Controller/setting_screen_controller.dart';
import 'package:health_care_dairy/Screens/Setting/notification/notification_screen.dart';
import 'package:health_care_dairy/Screens/Setting/profile/profile_screen.dart';
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
  SettingScreenController settingScreenController = Get.put(SettingScreenController());

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
                            Get.to(() => Profilescreen());
                          },
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: ConstColour.settingIconColor,
                              radius: 20,
                              child: Image.asset(
                                "assets/Icons/profile.png",
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
                                  "assets/images/notifications_setting.png",
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
                        InkWell(
                          onTap: () => toggleSwitch,
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: ConstColour.settingIconColor,
                              radius: 20,
                              child: Image.asset(
                                "assets/images/lock.png",
                                fit: BoxFit.cover,
                                height: deviceHeight * 0.02,
                              ),
                            ),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    "System App Lock",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: ConstFont.bold,
                                    )
                                ),
                                Transform.scale(
                                  scale: 1,
                                  child: Switch(
                                      value: isSwitched,
                                      onChanged: toggleSwitch,
                                    activeColor: ConstColour.buttonColor,
                                  ),
                                )
                              ],
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
                                "assets/images/date.png",
                                fit: BoxFit.cover,
                                height: deviceHeight * 0.02,
                              ),
                            ),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    "Date Formate",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: ConstFont.bold,
                                    )
                                ),
                                Text(
                                    " ",
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
                                "assets/images/time.png",
                                fit: BoxFit.cover,
                                height: deviceHeight * 0.02,
                              ),
                            ),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    "Time Formate",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: ConstFont.bold,
                                    )
                                ),
                                Text('',
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
                            Get.to(() => UnitSecondScreen());
                          },
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: ConstColour.settingIconColor,
                              radius: 20,
                              child: Image.asset(
                                "assets/images/unit_formate.png",
                                fit: BoxFit.cover,
                                height: deviceHeight * 0.02,
                              ),
                            ),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    "Unit Formate",
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
                          onTap: () {},
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: ConstColour.settingIconColor,
                              radius: 20,
                              child: Image.asset(
                                "assets/images/number_formate.png",
                                fit: BoxFit.cover,
                                height: deviceHeight * 0.02,
                              ),
                            ),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    "Number Formate",
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
                                "assets/images/backup_setting.png",
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
                                    "assets/images/premium.png",
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
                          onTap: () {},
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: ConstColour.bodyTembgColor,
                              radius: 20,
                              child: Image.asset(
                                "assets/images/share.png",
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
                          onTap: () {},
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: ConstColour.bodyTembgColor,
                              radius: 20,
                              child: Image.asset(
                                "assets/images/rate.png",
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
                          onTap: () {},
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: ConstColour.bodyTembgColor,
                              radius: 20,
                              child: Image.asset(
                                "assets/images/privacypolicy.png",
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
                          onTap: () {},
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: ConstColour.bodyTembgColor,
                              radius: 20,
                              child: Image.asset(
                                "assets/images/terms_of_service.png",
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

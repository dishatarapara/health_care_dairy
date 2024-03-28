import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:health_care_dairy/Screens/Blood_oxygen/blood_oxygen_screen.dart';
import 'package:health_care_dairy/Screens/Blood_pressure/blood_pressure_screen.dart';
import 'package:health_care_dairy/Screens/Body_Temperature/body_temperature_screen.dart';
import 'package:health_care_dairy/Screens/Setting/setting_screen.dart';
import 'package:health_care_dairy/Screens/weight/weight_screen.dart';

import '../ConstFile/constColors.dart';
import '../ConstFile/constFonts.dart';
import '../Controller/home_controller.dart';
import 'Blood_Sugar/blood_sugar_screen.dart';
import 'Hemoglobin/hemoglobin_screen.dart';
import 'home/genrate_pdf.dart';
import 'medication/medication_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeController.submitData();
  }

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ConstColour.appColor,
          elevation: 0.0,
          leading: SizedBox(),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: deviceWidth * 0.03),
              child: IconButton(
                onPressed: () {
                  Get.to(() => SettingScreen());
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => SettingScreen(),));
                },
                icon: Icon(Icons.settings,color: ConstColour.textColor),
              )
            ),
          ],
          title: Text(
            'Home Screen',
            style: TextStyle(
                fontSize: 22,
                color: ConstColour.textColor,
                fontFamily: ConstFont.regular,
                fontWeight: FontWeight.w800,
                overflow: TextOverflow.ellipsis
            ),
          ),
          centerTitle: true,
        ),
        backgroundColor: ConstColour.bgColor,
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: deviceWidth * 0.02
          ),
          child: SingleChildScrollView(
            controller: ScrollController(),
            scrollDirection: Axis.vertical,
            child: Obx(() =>
                Column(
                  children: [
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: homeController.diaryLists.length,
                      itemBuilder: (BuildContext context, index) {
                        return Padding(
                          padding: EdgeInsets.only(
                              top: deviceHeight * 0.015,
                              left: deviceWidth * 0.01,
                              right: deviceWidth * 0.01
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(8),
                            onTap: () {
                              if (index == 0) {
                                print(homeController.diaryLists[index].id.toString()+"home sugar");
                                // Get.to(()=> TestScreen());
                                Get.to(() => BloodSugar(
                                   id: homeController.diaryLists[index].id.toString()
                                ));
                              } else if(index == 1) {
                                Get.to(() => BloodPressure(
                                    id: homeController.diaryLists[index].id.toString()
                                ));
                              } else if(index == 2) {
                                Get.to(() => BodyTemperature(
                                    id: homeController.diaryLists[index].id.toString()
                                ));
                              } else if(index == 3) {
                                Get.to(() => BloodOxygen(
                                    id: homeController.diaryLists[index].id.toString()
                                ));
                              } else if(index == 4) {
                                Get.to(() => Hemoglobin(
                                    id: homeController.diaryLists[index].id.toString()
                                ));
                              } else if(index == 5) {
                                Get.to(() => Weight(
                                    id: homeController.diaryLists[index].id.toString()
                                ));
                              } else if(index == 6) {
                                Get.to(() => Medication(
                                    id: homeController.diaryLists[index].id.toString()
                                ));
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: ConstColour.appColor
                              ),
                              child: ListTile(
                                title: Text(
                                  homeController.diaryLists[index].name,
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: ConstColour.textColor,
                                      fontFamily: ConstFont.bold
                                  ),
                                ),
                                trailing: Icon(
                                  Icons.arrow_forward_ios,
                                  color: ConstColour.textColor,
                                ),
                                leading: CircleAvatar(
                                  backgroundColor: homeController.colorList[index],
                                  child: Container(
                                    height: deviceHeight * 0.021,
                                    child: ClipRRect(
                                        child: Image.asset(
                                            homeController.imagesList[index],
                                            fit: BoxFit.cover)
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: deviceHeight * 0.01,
                      ),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        child: Container(
                          width: double.infinity,
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: deviceHeight * 0.04,
                                left: deviceWidth * 0.03,
                                bottom: deviceHeight * 0.03
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'VIEW GENERATED REPORTS',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: ConstFont.bold,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: deviceHeight * 0.02
                                  ),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(7),
                                    onTap: () {
                                      Get.to(() => GeneratePdfScreen());
                                    },
                                    child: Container(
                                      height: deviceHeight * 0.035,
                                      width: deviceWidth * 0.3,
                                      decoration: BoxDecoration(
                                        color: ConstColour.buttonColor,
                                        borderRadius: BorderRadius.circular(7),
                                      ),
                                      child: Center(
                                        child: Text('GENERATE PDF',
                                          style: TextStyle(
                                              color: ConstColour.appColor
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                        height: deviceHeight * 0.02
                    ),
                  ],
                ),
            ),
          ),
        ),
      ),
    );
  }
}

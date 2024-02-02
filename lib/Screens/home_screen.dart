import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_care_dairy/Screens/unit_second_screen.dart';

import '../ConstFile/constColors.dart';
import '../ConstFile/constFonts.dart';
import '../Controller/home_controller.dart';
import 'blood_sugar_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ConstColour.appColor,
        elevation: 0.0,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: deviceWidth * 0.03),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UnitSecondScreen(),));
              },
              icon: Icon(Icons.settings,color: ConstColour.textColor),
            )
          ),
        ],
        title: Text(
          'Home Screen',
          style: TextStyle(
              color: ConstColour.textColor,
              fontFamily: ConstFont.regular,
              fontWeight: FontWeight.w800,
              overflow: TextOverflow.ellipsis
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: ConstColour.bgColor,
      body: SingleChildScrollView(
        controller: ScrollController(),
        scrollDirection: Axis.vertical,
        child:
        // Obx(() =>
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: deviceHeight * 0.02,
                      left: deviceWidth * 0.01,
                      right: deviceWidth * 0.01
                  ),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: deviceHeight * 0.01,
                          left: deviceWidth * 0.03,
                          bottom: deviceHeight * 0.015
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'How would you rate',
                            style: TextStyle(
                              fontSize: 28,
                              fontFamily: ConstFont.bold,
                            ),
                          ),
                          Text(
                            'MySugar App?',
                            style: TextStyle(
                              fontSize: 28,
                              fontFamily: ConstFont.bold,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: deviceHeight * 0.01
                            ),
                            child: Text(
                              "How can we improve it? We'd love your feedback.",
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: ConstFont.regular,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: deviceHeight * 0.02
                            ),
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () {},
                                  child: Container(
                                    height: deviceHeight * 0.035,
                                    width: deviceWidth * 0.18,
                                    decoration: BoxDecoration(
                                        border: Border.all(width: 2,
                                          color: ConstColour.buttonColor,
                                        ),
                                        borderRadius: BorderRadius.circular(7)
                                    ),
                                    child: Center(
                                        child: Text('Not Now')),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: deviceWidth * 0.03),
                                  child: InkWell(
                                    onTap: () {},
                                    child: Container(
                                      height: deviceHeight * 0.035,
                                      width: deviceWidth * 0.18,
                                      decoration: BoxDecoration(
                                        color: ConstColour.buttonColor,
                                        borderRadius: BorderRadius.circular(7),
                                      ),
                                      child: Center(
                                        child: Text('Rate Us',
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
                        ],
                      ),
                    ),
                  ),
                ),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: homeController.diarylists.length,
                  itemBuilder: (BuildContext context, index) {
                    return Padding(
                      padding: EdgeInsets.only(
                          top: deviceHeight * 0.015,
                          left: deviceWidth * 0.02,
                          right: deviceWidth * 0.02
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: ConstColour.appColor
                        ),
                        child: ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                              MaterialPageRoute(
                                builder: (context) => BloodSugar(),)
                            );
                          },
                          title: Text(
                            homeController.diarylists[index].name,
                            style: TextStyle(
                                fontSize: 20,
                                color: ConstColour.textColor,
                                fontFamily: ConstFont.bold
                            ),
                          ),
                          trailing: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.arrow_forward_ios,),
                            color: ConstColour.textColor,
                          ),
                          leading: CircleAvatar(
                            backgroundColor: homeController.diarylists[index].color,
                            child: Container(
                              height: deviceHeight * 0.021,
                              child: ClipRRect(
                                  child: Image.asset(homeController.diarylists[index].image,fit: BoxFit.cover)),
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
                      left: deviceWidth * 0.01,
                      right: deviceWidth * 0.01
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
                                onTap: () {},
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
        // ),
      ),
    );
  }
}

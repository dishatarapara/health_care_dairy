import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../ConstFile/constColors.dart';
import '../ConstFile/constFonts.dart';
import '../Controller/splash_screen_controller.dart';
import 'home_screen.dart';

class SplashSecondScreen extends StatefulWidget {
  const SplashSecondScreen({super.key});

  @override
  State<SplashSecondScreen> createState() => _SplashSecondScreenState();
}

class _SplashSecondScreenState extends State<SplashSecondScreen> {
  SplashScreenController splashScreenController = Get.put(SplashScreenController());
  late PageController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = PageController();
  }

  int _currentPage = 0;

  AnimatedContainer _buildDots({
    int? index,
  }) {
    return AnimatedContainer(
        duration: Duration(milliseconds: 200),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(50),
        ),
        color: Color(0xFF000000),
      ),
      margin: EdgeInsets.only(right: 5),
      height: 10,
      curve: Curves.easeIn,
      width: _currentPage == index ? 20 : 10,
    );
  }

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: ConstColour.appColor,
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: PageView.builder(
              physics: BouncingScrollPhysics(),
              controller: _controller,
              onPageChanged: (value) =>
                  setState(() {
                    _currentPage = value;
                  }),
              itemCount: splashScreenController.contents.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(),
                    Image.asset(
                      splashScreenController.contents[index].image,
                      height: deviceHeight * 0.5,
                      width: deviceWidth * 0.8,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: deviceWidth * 0.04,
                          right: deviceWidth * 0.04
                      ),
                      child: Text(
                        splashScreenController.contents[index].title,
                        style: TextStyle(
                          fontSize: 35,
                            fontFamily: ConstFont.bold,
                            color: ConstColour.textColor
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: deviceHeight * 0.01,
                          left: deviceWidth * 0.03,
                          right: deviceWidth * 0.03
                      ),
                      child: Text(
                        splashScreenController.contents[index].desc,
                        style: TextStyle(
                            fontSize: 22,
                            fontFamily: ConstFont.regular,
                            color: Colors.grey
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    splashScreenController.contents.length,
                        (index) => _buildDots(
                          index: index,
                        ),
                    ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    right: deviceWidth * 0.03,
                    left: deviceWidth * 0.03,
                    bottom: deviceHeight * 0.03
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context, MaterialPageRoute(
                              builder: (context) => HomeScreen(),
                            ));
                          },
                          child: Text(
                              'Skip',
                            style: TextStyle(
                              fontSize: 25,
                              fontFamily: ConstFont.bold,
                              color: ConstColour.textColor
                            ),
                          )
                      ),
                      TextButton(
                          onPressed: () {
                            _currentPage + 1 == splashScreenController.contents.length
                                ? Navigator.push(
                                context, MaterialPageRoute(
                              builder: (context) => HomeScreen()))
                                : _controller.nextPage(
                                duration: Duration(milliseconds: 200),
                                curve: Curves.easeIn
                            );
                          },
                          child: Text(
                              _currentPage + 1 == splashScreenController.contents.length
                                  ? 'Go to Login'
                                  : 'Next',
                            style: TextStyle(
                                fontSize: 25,
                                fontFamily: ConstFont.bold,
                                color: ConstColour.textColor
                            ),
                          )
                      ),
                      // ElevatedButton(
                      //   style: ElevatedButton.styleFrom(
                      //       shape: RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.circular(5)),
                      //       minimumSize: Size(deviceWidth * 0.4, deviceHeight * 0.05),
                      //       backgroundColor: ConstColour.buttonColor
                      //   ),
                      //   onPressed: () {
                      //
                      //   },
                      //   child: Text(
                      //     'Skip',
                      //     style: TextStyle(
                      //       fontSize: 20,
                      //       color: ConstColour.bgColor,
                      //     ),
                      //   ),
                      // ),
                      // ElevatedButton(
                      //   style: ElevatedButton.styleFrom(
                      //       shape: RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.circular(5)),
                      //       minimumSize: Size(deviceWidth * 0.4, deviceHeight * 0.05),
                      //       backgroundColor: ConstColour.buttonColor
                      //   ),
                      //   onPressed: () {
                      //     _controller.nextPage(
                      //         duration: Duration(milliseconds: 200),
                      //         curve: Curves.easeIn
                      //     );
                      //   },
                      //   child: Text(
                      //     _currentPage + 1 == splashScreenController.contents.length
                      //         ? 'Go to Login'
                      //         : 'Next',
                      //     style: TextStyle(
                      //       fontSize: 20,
                      //       color: ConstColour.bgColor,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

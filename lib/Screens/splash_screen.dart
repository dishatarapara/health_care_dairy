import 'package:flutter/material.dart';
import 'package:health_care_dairy/Screens/home_screen.dart';
import 'package:health_care_dairy/Screens/login_screen.dart';
import 'package:health_care_dairy/Screens/splash_second_screen.dart';

import '../ConstFile/constColors.dart';
import '../ConstFile/constFonts.dart';
import '../ConstFile/constPreferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin{
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  var id;
  var isflag;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   // var flag = ConstPreferences().isIntroScreenFlag('IntroScreenFlag');
   //  IntroScreenFlag();
    _controller = AnimationController(
        vsync: this,
        duration: Duration(seconds: 3),
    );
    _scaleAnimation = Tween<double>(
      begin: 0.5, // initial scale
      end: 1.0,   // final scale
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _controller.forward();

    _loadNextScreen();
  }

  Future<void> _loadNextScreen() async {
    id = await ConstPreferences().getUserId('UserId');
    isflag = await ConstPreferences().isIntroScreenFlag('IntroScreenFlag');
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => isflag == true
              ? (id == null ? LoginScreen() : HomeScreen())
              : SplashSecondScreen(),
        ),
      );
    });
  }

  // Future<void> IntroScreenFlag() async{
  //   id = await ConstPreferences().getUserId('UserId');
  //   isflag = await ConstPreferences().isIntroScreenFlag('IntroScreenFlag');
  //   if(isflag == true){
  //     Future.delayed(Duration(seconds: 3),
  //             () => Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //               builder: (context) => id == null ? LoginScreen() : HomeScreen(),))
  //     );
  //   }else{
  //     Future.delayed(Duration(seconds: 3),
  //             () => Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //               builder: (context) => SplashSecondScreen(),))
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: ConstColour.appColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Container(
            //   height: deviceHeight * 0.4,
            //   child: Image.asset(
            //     "assets/Images/health_image.png",
            //     fit: BoxFit.cover,
            //   ),
            // ),
            ScaleTransition(
              scale: _scaleAnimation,
              child: Container(
                height: deviceHeight * 0.4,
                child: Image.asset(
                  "assets/Images/health_image.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: deviceHeight * 0.05),
              child: const Text(
                'Health Care Diary',
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: ConstColour.textColor,
                  fontFamily: ConstFont.regular),
                overflow: TextOverflow.ellipsis),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

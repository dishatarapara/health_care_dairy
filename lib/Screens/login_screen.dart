import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:health_care_dairy/Common/bottom_button.dart';
import 'package:health_care_dairy/Controller/login_controller.dart';
import 'package:health_care_dairy/Screens/register_screen.dart';

import '../Common/snackbar.dart';
import '../ConstFile/constColors.dart';
import '../ConstFile/constFonts.dart';
import '../ConstFile/constPreferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginController loginController = Get.put(LoginController());

  String? email;
  String? password;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    IntroScreenFlag(true);
    loginController.emailController.clear();
    loginController.passController.clear();
    loginController.emailController.text = "pinuasodariya10@gmail.com";
    loginController.passController.text = "12345678";
  }
  Future<bool?> IntroScreenFlag(bool flag) async{
    await ConstPreferences().setIntroScreenFlag('IntroScreenFlag',flag);
  }
  // final _formkey = GlobalKey<FormState>();

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
        backgroundColor: ConstColour.appColor,
        body: SingleChildScrollView(
          controller: ScrollController(),
          scrollDirection: Axis.vertical,
          // child: Form(
          //   key: _formkey,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: deviceWidth * 0.03,
                vertical: deviceHeight * 0.02
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: deviceHeight * 0.08),
                    child: Center(
                      child: Container(
                        height: deviceHeight * 0.2,
                        width: deviceWidth * 0.6,
                        child: Image.asset(
                          "assets/Images/login.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
      
                  Padding(
                    padding: EdgeInsets.only(top: deviceHeight * 0.03),
                    child: Center(
                      child: Text(
                          'Login',
                          style: TextStyle(
                              fontSize: 30,
                              fontFamily: ConstFont.bold,
                              color: ConstColour.buttonColor,),
                          overflow: TextOverflow.ellipsis),
                    ),
                  ),
      
                  Padding(
                    padding: EdgeInsets.only(top: deviceHeight * 0.03),
                    child: Text(
                        'Email',
                        style: TextStyle(
                          fontSize: 17,
                          fontFamily: ConstFont.bold,
                          color: ConstColour.textColor,),
                        overflow: TextOverflow.ellipsis),
                  ),
      
                  Padding(
                    padding: EdgeInsets.only(top: deviceHeight * 0.01),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: loginController.emailController,
                      cursorColor: ConstColour.textColor,
                      autocorrect: true,
                      style: TextStyle(
                          fontSize: 18,
                          color: ConstColour.textColor
                      ),
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: "Email Id",
                        hintStyle: TextStyle(
                          fontSize: 18,
                            color: ConstColour.textColor
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: ConstColour.textColor
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: ConstColour.textColor
                          ),),
                      ),
                      // validator: (value) {
                      //   if (value!.isEmpty ||
                      //       !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      //           .hasMatch(value)) {
                      //     return 'Please Enter Email Address';
                      //   }
                      //   return null;
                      // },
                    ),
                  ),
      
                  Padding(
                    padding: EdgeInsets.only(top: deviceHeight * 0.02),
                    child: const Text(
                        'Password',
                        style: TextStyle(
                          fontSize: 17,
                          fontFamily: ConstFont.bold,
                          color: ConstColour.textColor,),
                        overflow: TextOverflow.ellipsis),
                  ),
      
                  Padding(
                    padding: EdgeInsets.only(top: deviceHeight * 0.01),
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: loginController.passController,
                      keyboardType: TextInputType.multiline,
                      autocorrect: true,
                      style: TextStyle(
                          fontSize: 18,
                          color: ConstColour.textColor
                      ),
                      cursorColor: ConstColour.textColor,
                      obscureText: true,
                      obscuringCharacter: "*",
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: "Password",
                        hintStyle: TextStyle(
                          fontSize: 18,
                            color: ConstColour.textColor
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: ConstColour.textColor
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: ConstColour.textColor
                          ),),
                      ),
                      // validator: (value) {
                      //   if (value!.isEmpty) {
                      //     return 'Password is required';
                      //   }
                      //   return null;
                      // },
                    ),
                  ),
      
                  Padding(
                    padding: EdgeInsets.only(top: deviceHeight * 0.02),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                            'Forget password?',
                            style:TextStyle(
                                fontSize: 16,
                                color: ConstColour.textColor,
                                fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
      
                  Padding(
                    padding: EdgeInsets.only(top: deviceHeight * 0.02),
                    child: Center(
                      child: NextButton(
                        onPressed: () async {
                          if (loginController.emailController.text.isEmpty) {
                            Utils().errorSnackBar('Email', "Enter valid email ");
                          } else
                          if (loginController.passController.text.isEmpty) {
                            Utils().errorSnackBar('Password', "Enter valid password ");
                          } else {
                            loginController.login(
                                loginController.emailController.text,
                                loginController.passController.text);
                          }
                        },
                        btnName: "Login",
                      ),
                    )
                    // ElevatedButton(
                    //   child: Text(
                    //     "Login",
                    //     style: TextStyle(
                    //       fontSize: 20,
                    //       color: Colors.white,
                    //     ),
                    //   ),
                    //   style: ElevatedButton.styleFrom(
                    //       shape: RoundedRectangleBorder(
                    //           borderRadius: BorderRadius.circular(50)),
                    //       minimumSize: Size(deviceWidth * 1.0, deviceHeight * 0.06),
                    //       backgroundColor: ConstColour.buttonColor
                    //   ),
                    //
                    //   onPressed: () async {
                    //     if (loginController.emailController.text.isEmpty) {
                    //       Utils().errorSnackBar('Email', "Enter valid email ");
                    //     } else if (loginController.passController.text.isEmpty) {
                    //       Utils().errorSnackBar('Password', "Enter valid password ");
                    //     } else {
                    //       loginController.login(
                    //           loginController.emailController.text,
                    //           loginController.passController.text);
                    //     }
                    //     // if (_formkey.currentState!.validate()) {
                    //     //   email = loginController.emailController.text;
                    //     //   password = loginController.passController.text;
                    //     //
                    //     //   if(loginController.emailController.text.isEmpty &&
                    //     //   loginController.passController.text.isEmpty) {
                    //     //     setState(() {
                    //     //       Utils().snackBar('',
                    //     //           "Enter valid email & password");
                    //     //     });
                    //     //   } else {
                    //     //     loginController.login(email!, password!);
                    //     //   }
                    //     // }
                    //     },
                    // ),
                  ),
      
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                          "Don't have an account?",
                          style: TextStyle(
                            fontSize: 15,
                              color: ConstColour.textColor
                          )
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RegisterScreen()),
                              );
                            },
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                              fontSize: 15,
                                color: ConstColour.buttonColor
                            ),
                          )
                      ),
                    ],
                  )
                ],
              ),
            ),
          // ),
        ),
      ),
    );
  }
}

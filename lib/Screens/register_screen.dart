import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:health_care_dairy/Screens/Setting/unit_screen.dart';
import 'package:health_care_dairy/Screens/login_screen.dart';

import '../Common/snackbar.dart';
import '../ConstFile/constColors.dart';
import '../ConstFile/constFonts.dart';
import '../Controller/register_controller.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  RegisterController registerController = Get.put(RegisterController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    registerController.firstNameController.clear();
    registerController.emailController.clear();
    registerController.passwordController.clear();
  }

  String? name;
  String? email;
  String? password;

  bool validate = false;
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: ConstColour.appColor,
      body: SingleChildScrollView(
        controller: ScrollController(),
        scrollDirection: Axis.vertical,
        child: Form(
          key: _formkey,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: deviceWidth * 0.03, vertical: deviceHeight * 0.02),
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
                        "assets/Images/regi.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: deviceHeight * 0.03),
                  child: Center(
                    child: Text('CREATE ACCOUNT',
                        style: TextStyle(
                          fontSize: 30,
                          fontFamily: ConstFont.bold,
                          color: ConstColour.buttonColor,
                        ),
                        overflow: TextOverflow.ellipsis),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: deviceHeight * 0.03, right: deviceWidth * 0.01),
                  child: TextFormField(
                    cursorColor: ConstColour.textColor,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.text,
                    autocorrect: true,
                    controller: registerController.firstNameController,
                    style:
                        TextStyle(fontSize: 18, color: ConstColour.textColor),
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: "First Name",
                      hintStyle:
                          TextStyle(fontSize: 18, color: ConstColour.textColor),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: ConstColour.textColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: ConstColour.textColor),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Enter FirstName';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: deviceHeight * 0.02),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: registerController.emailController,
                    cursorColor: ConstColour.textColor,
                    autocorrect: true,
                    style:
                        TextStyle(fontSize: 18, color: ConstColour.textColor),
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: "Email Id",
                      hintStyle:
                          TextStyle(fontSize: 18, color: ConstColour.textColor),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: ConstColour.textColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: ConstColour.textColor),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty ||
                          !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value)) {
                        return 'Please Enter Email Address';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: deviceHeight * 0.02),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: registerController.passwordController,
                    keyboardType: TextInputType.multiline,
                    autocorrect: true,
                    style:
                        TextStyle(fontSize: 18, color: ConstColour.textColor),
                    cursorColor: ConstColour.textColor,
                    obscureText: true,
                    obscuringCharacter: "*",
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: "Password",
                      hintStyle:
                          TextStyle(fontSize: 18, color: ConstColour.textColor),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: ConstColour.textColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: ConstColour.textColor),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Password is required';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: deviceHeight * 0.02),
                  child: ElevatedButton(
                    child: Text(
                      "Next",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        minimumSize:
                            Size(deviceWidth * 1.0, deviceHeight * 0.06),
                        backgroundColor: ConstColour.buttonColor),
                    onPressed: () async {
                      if (registerController.firstNameController.text.isEmpty) {
                        Utils().snackBar('Username', "Enter valid Username ");
                      } else if (registerController
                          .emailController.text.isEmpty) {
                        Utils().snackBar('Email', "Enter valid email ");
                      } else if (registerController
                          .passwordController.text.isEmpty) {
                        Utils().snackBar('Password', "Enter valid password ");
                      } else {
                        registerController.register(
                            registerController.firstNameController.text,
                            registerController.emailController.text,
                            registerController.passwordController.text);
                      }
                      // if (_formkey.currentState!.validate()) {
                      //   name = registerController.firstNameController.text;
                      //   email = registerController.emailController.text;
                      //   password = registerController.passwordController.text;
                      //
                      //   if(registerController.firstNameController.text.isEmpty &&
                      //       registerController.emailController.text.isEmpty &&
                      //       registerController.passwordController.text.isEmpty) {
                      //     setState(() {
                      //       Utils().toastMessage(
                      //           "Enter valid Username & email & password");
                      //     });
                      //   } else {
                      //     registerController.register(name!, email!, password!);
                      //   }
                      //
                      //   setState(() {
                      //     validate = false;
                      //   });
                      // }
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account?",
                        style: TextStyle(
                            fontSize: 15, color: ConstColour.textColor)),
                    TextButton(
                        onPressed: () {
                          Get.to(() => LoginScreen());
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(
                              fontSize: 15, color: ConstColour.buttonColor),
                        ))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

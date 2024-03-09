

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_care_dairy/Screens/Setting/setting_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../../../ConstFile/constColors.dart';
import '../../../ConstFile/constFonts.dart';
import '../../../ConstFile/constPreferences.dart';
import '../../../Controller/image_controller.dart';
import '../../../Controller/register_controller.dart';

class Profilescreen extends StatefulWidget {
  const Profilescreen({super.key});

  @override
  State<Profilescreen> createState() => _ProfilescreenState();
}

class _ProfilescreenState extends State<Profilescreen> {

  @override
  void initState() {
    super.initState();
    loadImage();
  }



  String? _imagepath;

  void getImageGallery() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _imagepath = image.path;
      });
    }
  }

  void getImageCamera() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      setState(() {
        _imagepath = image.path;
      });
    }
  }
  void removePicture() async {
    ConstPreferences().clearPreferences();
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // preferences.remove("imagepath");
    setState(() {
      _imagepath = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery
        .of(context)
        .size
        .height;
    var deviceWidth = MediaQuery
        .of(context)
        .size
        .width;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: ConstColour.appColor,
          elevation: 0.0,
          title: Text(
            "Profile",
            style: TextStyle(
                color: ConstColour.textColor,
                fontFamily: ConstFont.regular,
                fontWeight: FontWeight.w800,
                overflow: TextOverflow.ellipsis
            ),
          ),
          leading: IconButton(
            onPressed: () {
              Get.to(() => SettingScreen());
            },
            icon: Icon(Icons.arrow_back),
            color: ConstColour.textColor,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: deviceHeight * 0.05),
                  child: Center(
                      child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundImage: _imagepath != null
                                  ? FileImage(
                                  File(_imagepath!)) as ImageProvider<Object>?
                                  : AssetImage("assets/images/profile2.png"),
                              child:
                              Padding(
                                padding: EdgeInsets.only(
                                    top: deviceHeight * 0.08,
                                    left: deviceWidth * 0.15),
                                child: InkWell(
                                  onTap: () {
                                    showDialog<void>(
                                      context: context,
                                      builder: (BuildContext dialogContext) {
                                        return AlertDialog(
                                          content: SizedBox(
                                            // height: deviceHeight * 0.17,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Card(
                                                  child: ListTile(
                                                    title:
                                                    const Text("Camera"),
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                      getImageCamera();
                                                    },
                                                    leading: const Icon(
                                                      Icons.camera_alt,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                                Card(
                                                  child: ListTile(
                                                    title:
                                                    const Text("Gallery"),
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                      getImageGallery();
                                                    },
                                                    leading: const Icon(
                                                      Icons
                                                          .photo_library_rounded,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                                Card(
                                                  child: ListTile(
                                                    title:
                                                    const Text("Remove profile"),
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                      removePicture();
                                                    },
                                                    leading: const Icon(
                                                      Icons
                                                          .remove,
                                                      color: Colors.black,
                                                    ),
                                                  ),

                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Icon(
                                    Icons.add_a_photo,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ), // Add a default image
                          ])
                  ),
                ),


                Padding(
                  padding: EdgeInsets.only(
                      top: deviceHeight * 0.07, right: deviceWidth * 0.75),
                  child: Text(
                      'Username',
                      style: TextStyle(
                        fontSize: 17,
                        fontFamily: ConstFont.bold,
                        color: ConstColour.textColor,),
                      overflow: TextOverflow.ellipsis),
                ),
                Padding(
                  padding: EdgeInsets.only(top: deviceHeight * 0.02,
                      left: deviceWidth * 0.03,
                      right: deviceWidth * 0.03),
                  child: TextFormField(
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: "Username",
                      hintStyle: TextStyle(
                          fontSize: 18,
                          color: ConstColour.textColor
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            color: ConstColour.textColor
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                            color: ConstColour.textColor
                        ),),
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
                  padding: EdgeInsets.only(
                      top: deviceHeight * 0.02, right: deviceWidth * 0.80),
                  child: Text(
                      'Email',
                      style: TextStyle(
                        fontSize: 17,
                        fontFamily: ConstFont.bold,
                        color: ConstColour.textColor,),
                      overflow: TextOverflow.ellipsis),
                ),
                Padding(
                  padding: EdgeInsets.only(top: deviceHeight * 0.02,
                      left: deviceWidth * 0.03,
                      right: deviceWidth * 0.03),
                  child: TextFormField(
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: "Email Id",
                      hintStyle: TextStyle(
                          fontSize: 18,
                          color: ConstColour.textColor
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            color: ConstColour.textColor
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                            color: ConstColour.textColor
                        ),),
                    ),
                    validator: (value) {
                      if (value!.isEmpty ||
                          !RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value)) {
                        return 'Please Enter Email Address';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(top: deviceHeight * 0.05,
                        left: deviceWidth * 0.03,
                        right: deviceWidth * 0.03),
                    child: ElevatedButton(
                        child: Text(
                          "Save",
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

                        onPressed: () {
                          saveImage(_imagepath);
                          Get.to(() => SettingScreen());
                        })
                )
              ]),
        )

    );
  }

  void saveImage(String? path) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("imagepath", path ?? "");
  }


  void loadImage() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      _imagepath = preferences.getString("imagepath");
    });
  }

}


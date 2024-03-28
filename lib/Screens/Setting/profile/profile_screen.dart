import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_care_dairy/Controller/profile_controller.dart';


import '../../../ConstFile/constColors.dart';
import '../../../ConstFile/constFonts.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileController profileController = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();
    profileController.loadImage();
  }

  // String? _imagepath;
  //
  // void getImageGallery() async {
  //   final picker = ImagePicker();
  //   final image = await picker.pickImage(source: ImageSource.gallery);
  //
  //   if (image != null) {
  //     setState(() {
  //       _imagepath = image.path;
  //     });
  //   }
  // }
  //
  // void getImageCamera() async {
  //   final picker = ImagePicker();
  //   final image = await picker.pickImage(source: ImageSource.camera);
  //
  //   if (image != null) {
  //     setState(() {
  //       _imagepath = image.path;
  //     });
  //   }
  // }
  // void removePicture() async {
  //   ConstPreferences().clearPreferences();
  //   // SharedPreferences preferences = await SharedPreferences.getInstance();
  //   // preferences.remove("imagepath");
  //   setState(() {
  //     _imagepath = null;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;

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
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Get.back();
              // Get.to(() => SettingScreen());
            },
            icon: Icon(Icons.arrow_back),
            color: ConstColour.textColor,
          ),
        ),
        body: Obx(() => SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: deviceWidth * 0.03,
                vertical: deviceHeight * 0.01
            ),
            child: Column(
                children: [
                  SizedBox(
                    width: deviceWidth * 1.0,
                    height: deviceHeight * 0.15,
                    child: Padding(
                      padding: EdgeInsets.only(top: deviceHeight * 0.05),
                      child: Center(
                          child: Stack(
                              children: [
                                CircleAvatar(
                                  radius: 50,
                                  backgroundColor: ConstColour.greyTextColor,
                                  backgroundImage: profileController.imagePath.value.isNotEmpty
                                      ? Image.file(
                                    File(profileController.imagePath.value),
                                    fit: BoxFit.cover,
                                  ).image
                                      : AssetImage(
                                      "assets/Images/profile_setting_image.png"
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: deviceHeight * 0.05,
                                        left: deviceWidth * 0.15),
                                    child: CircleAvatar(
                                      radius: 15,
                                      backgroundColor: ConstColour.appColor,
                                      child: InkWell(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext dialogContext) {
                                              return AlertDialog(
                                                content: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Card(
                                                      child: ListTile(
                                                        title: Text("Camera"),
                                                        onTap: () {
                                                          Get.back();
                                                          profileController.getImageCamera();
                                                        },
                                                        leading: Icon(
                                                          Icons.camera_alt,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                    Card(
                                                      child: ListTile(
                                                        title: Text("Gallery"),
                                                        onTap: () {
                                                          Get.back();
                                                          profileController.getImageGallery();
                                                        },
                                                        leading: Icon(
                                                          Icons.photo_library_rounded,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                    Card(
                                                      child: ListTile(
                                                        title: Text("Remove profile"),
                                                        onTap: () {
                                                          Get.back();
                                                          profileController.removePicture();
                                                        },
                                                        leading: Icon(
                                                          Icons.remove,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        child: Icon(
                                          Icons.add_a_photo,
                                          size: 20,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ]
                          )
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: EdgeInsets.only(
                  //       top: deviceHeight * 0.07,
                  //       right: deviceWidth * 0.75),
                  //   child: Text(
                  //       'User Name',
                  //       style: TextStyle(
                  //         fontSize: 17,
                  //         fontFamily: ConstFont.bold,
                  //         color: ConstColour.textColor,),
                  //       overflow: TextOverflow.ellipsis),
                  // ),
                  Padding(
                    padding: EdgeInsets.only(top: deviceHeight * 0.05),
                    child: TextFormField(
                      cursorColor: ConstColour.textColor,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.text,
                      autocorrect: true,
                      style: TextStyle(fontSize: 18, color: ConstColour.textColor),
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: "Name",
                        hintStyle: TextStyle(fontSize: 18, color: ConstColour.textColor),
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
                          return 'Please Enter User Name';
                        }
                        return null;
                      },
                    ),
                  ),
                  // Padding(
                  //   padding: EdgeInsets.only(
                  //       top: deviceHeight * 0.02, right: deviceWidth * 0.80),
                  //   child: Text(
                  //       'Email',
                  //       style: TextStyle(
                  //         fontSize: 17,
                  //         fontFamily: ConstFont.bold,
                  //         color: ConstColour.textColor,),
                  //       overflow: TextOverflow.ellipsis),
                  // ),
                  Padding(
                    padding: EdgeInsets.only(top: deviceHeight * 0.02),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
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
                      padding: EdgeInsets.only(top: deviceHeight * 0.05),
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
                              minimumSize: Size(deviceWidth * 0.9, deviceHeight * 0.06),
                              backgroundColor: ConstColour.buttonColor
                          ),
                          onPressed: () {
                            profileController.saveImage(profileController.imagePath.value);
                            Get.back();
                          })
                  )
                ]
            ),
          ),
        ),)
    );
  }
}


// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:health_care_dairy/Controller/profile_controller.dart';
//
//
// import '../../../ConstFile/constColors.dart';
// import '../../../ConstFile/constFonts.dart';
//
// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({super.key});
//
//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }
//
// class _ProfileScreenState extends State<ProfileScreen> {
//   ProfileController profileController = Get.put(ProfileController());
//
//   @override
//   void initState() {
//     super.initState();
//     profileController.loadImage();
//   }
//
//   // String? _imagepath;
//   //
//   // void getImageGallery() async {
//   //   final picker = ImagePicker();
//   //   final image = await picker.pickImage(source: ImageSource.gallery);
//   //
//   //   if (image != null) {
//   //     setState(() {
//   //       _imagepath = image.path;
//   //     });
//   //   }
//   // }
//   //
//   // void getImageCamera() async {
//   //   final picker = ImagePicker();
//   //   final image = await picker.pickImage(source: ImageSource.camera);
//   //
//   //   if (image != null) {
//   //     setState(() {
//   //       _imagepath = image.path;
//   //     });
//   //   }
//   // }
//   // void removePicture() async {
//   //   ConstPreferences().clearPreferences();
//   //   // SharedPreferences preferences = await SharedPreferences.getInstance();
//   //   // preferences.remove("imagepath");
//   //   setState(() {
//   //     _imagepath = null;
//   //   });
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     var deviceHeight = MediaQuery.of(context).size.height;
//     var deviceWidth = MediaQuery.of(context).size.width;
//
//     return Scaffold(
//         appBar: AppBar(
//           backgroundColor: ConstColour.appColor,
//           elevation: 0.0,
//           title: Text(
//             "Profile",
//             style: TextStyle(
//                 color: ConstColour.textColor,
//                 fontFamily: ConstFont.regular,
//                 fontWeight: FontWeight.w800,
//                 overflow: TextOverflow.ellipsis
//             ),
//           ),
//           centerTitle: true,
//           leading: IconButton(
//             onPressed: () {
//               Get.back();
//               // Get.to(() => SettingScreen());
//             },
//             icon: Icon(Icons.arrow_back),
//             color: ConstColour.textColor,
//           ),
//         ),
//         body: SingleChildScrollView(
//           child: Padding(
//             padding: EdgeInsets.symmetric(
//                 horizontal: deviceWidth * 0.03,
//                 vertical: deviceHeight * 0.01
//             ),
//             child: Column(
//                 children: [
//                   SizedBox(
//                     width: deviceWidth * 1.0,
//                     height: deviceHeight * 0.15,
//                     child: Padding(
//                       padding: EdgeInsets.only(top: deviceHeight * 0.05),
//                       child: Center(
//                           child: Stack(
//                               children: [
//                                 CircleAvatar(
//                                   radius: 50,
//                                   backgroundColor: ConstColour.greyTextColor,
//                                   backgroundImage: profileController.imagePath.value.isNotEmpty
//                                       ? Image.file(
//                                     File(profileController.imagePath.value),
//                                     fit: BoxFit.cover,
//                                   ).image
//                                       : AssetImage(
//                                       "assets/Images/profile_setting_image.png"
//                                   ),
//                                   child: Padding(
//                                     padding: EdgeInsets.only(
//                                         top: deviceHeight * 0.05,
//                                         left: deviceWidth * 0.18),
//                                     child: CircleAvatar(
//                                       radius: 50,
//                                       backgroundColor: ConstColour.appColor,
//                                       child: InkWell(
//                                         onTap: () {
//                                           showDialog(
//                                             context: context,
//                                             builder: (BuildContext dialogContext) {
//                                               return AlertDialog(
//                                                 content: Column(
//                                                   mainAxisSize: MainAxisSize.min,
//                                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                   children: [
//                                                     Card(
//                                                       child: ListTile(
//                                                         title: Text("Camera"),
//                                                         onTap: () {
//                                                           Get.back();
//                                                           profileController.getImageCamera();
//                                                         },
//                                                         leading: Icon(
//                                                           Icons.camera_alt,
//                                                           color: Colors.black,
//                                                         ),
//                                                       ),
//                                                     ),
//                                                     Card(
//                                                       child: ListTile(
//                                                         title: Text("Gallery"),
//                                                         onTap: () {
//                                                           Get.back();
//                                                           profileController.getImageGallery();
//                                                         },
//                                                         leading: Icon(
//                                                           Icons.photo_library_rounded,
//                                                           color: Colors.black,
//                                                         ),
//                                                       ),
//                                                     ),
//                                                     Card(
//                                                       child: ListTile(
//                                                         title: Text("Remove profile"),
//                                                         onTap: () {
//                                                           Get.back();
//                                                           profileController.removePicture();
//                                                         },
//                                                         leading: Icon(
//                                                           Icons.remove,
//                                                           color: Colors.black,
//                                                         ),
//                                                       ),
//                                                     )
//                                                   ],
//                                                 ),
//                                               );
//                                             },
//                                           );
//                                         },
//                                         child: Icon(
//                                           Icons.add_a_photo,
//                                           size: 20,
//                                           color: Colors.black,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ]
//                           )
//                       ),
//                     ),
//                   ),
//                   // Padding(
//                   //   padding: EdgeInsets.only(
//                   //       top: deviceHeight * 0.07,
//                   //       right: deviceWidth * 0.75),
//                   //   child: Text(
//                   //       'User Name',
//                   //       style: TextStyle(
//                   //         fontSize: 17,
//                   //         fontFamily: ConstFont.bold,
//                   //         color: ConstColour.textColor,),
//                   //       overflow: TextOverflow.ellipsis),
//                   // ),
//                   Padding(
//                     padding: EdgeInsets.only(top: deviceHeight * 0.05),
//                     child: TextFormField(
//                       cursorColor: ConstColour.textColor,
//                       autovalidateMode: AutovalidateMode.onUserInteraction,
//                       keyboardType: TextInputType.text,
//                       autocorrect: true,
//                       style: TextStyle(fontSize: 18, color: ConstColour.textColor),
//                       decoration: InputDecoration(
//                         isDense: true,
//                         hintText: "Name",
//                         hintStyle: TextStyle(fontSize: 18, color: ConstColour.textColor),
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10)),
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                           borderSide: BorderSide(color: ConstColour.textColor),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                           borderSide: BorderSide(color: ConstColour.textColor),
//                         ),
//                       ),
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return 'Please Enter User Name';
//                         }
//                         return null;
//                       },
//                     ),
//                   ),
//                   // Padding(
//                   //   padding: EdgeInsets.only(
//                   //       top: deviceHeight * 0.02, right: deviceWidth * 0.80),
//                   //   child: Text(
//                   //       'Email',
//                   //       style: TextStyle(
//                   //         fontSize: 17,
//                   //         fontFamily: ConstFont.bold,
//                   //         color: ConstColour.textColor,),
//                   //       overflow: TextOverflow.ellipsis),
//                   // ),
//                   Padding(
//                     padding: EdgeInsets.only(top: deviceHeight * 0.02),
//                     child: TextFormField(
//                       keyboardType: TextInputType.emailAddress,
//                       autovalidateMode: AutovalidateMode.onUserInteraction,
//                       cursorColor: ConstColour.textColor,
//                       autocorrect: true,
//                       style: TextStyle(
//                           fontSize: 18,
//                           color: ConstColour.textColor
//                       ),
//                       decoration: InputDecoration(
//                         isDense: true,
//                         hintText: "Email Id",
//                         hintStyle: TextStyle(
//                             fontSize: 18,
//                             color: ConstColour.textColor
//                         ),
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10)
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                           borderSide: BorderSide(
//                               color: ConstColour.textColor
//                           ),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                           borderSide: BorderSide(
//                               color: ConstColour.textColor
//                           ),),
//                       ),
//                       // validator: (value) {
//                       //   if (value!.isEmpty ||
//                       //       !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
//                       //           .hasMatch(value)) {
//                       //     return 'Please Enter Email Address';
//                       //   }
//                       //   return null;
//                       // },
//                     ),
//                   ),
//                   Padding(
//                       padding: EdgeInsets.only(top: deviceHeight * 0.05),
//                       child: ElevatedButton(
//                           child: Text(
//                             "Save",
//                             style: TextStyle(
//                               fontSize: 20,
//                               color: Colors.white,
//                             ),
//                           ),
//                           style: ElevatedButton.styleFrom(
//                               shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(50)),
//                               minimumSize: Size(deviceWidth * 0.9, deviceHeight * 0.06),
//                               backgroundColor: ConstColour.buttonColor
//                           ),
//                           onPressed: () {
//                             profileController.saveImage(profileController.imagePath.value);
//                             Get.back();
//                           })
//                   )
//                 ]
//             ),
//           ),
//         ),
//     );
//   }
// }
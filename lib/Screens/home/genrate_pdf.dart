import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_care_dairy/Controller/pdf_controller.dart';
import 'package:intl/intl.dart';

import '../../ConstFile/constColors.dart';
import '../../ConstFile/constFonts.dart';
import '../../Controller/date_time_controller.dart';

class GeneratePdfScreen extends StatefulWidget {
  const GeneratePdfScreen({super.key});

  @override
  State<GeneratePdfScreen> createState() => _GeneratePdfScreenState();
}

class _GeneratePdfScreenState extends State<GeneratePdfScreen> {
  PdfController pdfController = Get.put(PdfController());
  DateTimeController dateTimeController = Get.put(DateTimeController());

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: ConstColour.appColor,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back,
            color: ConstColour.textColor,
            ),
        ),
        title: Text(
          'Report',
          style: TextStyle(
              fontSize: 22,
              color: ConstColour.textColor,
              fontFamily: ConstFont.regular,
              fontWeight: FontWeight.w800,
              overflow: TextOverflow.ellipsis
          ),
        ),
      ),
      backgroundColor: ConstColour.bgColor,
      body: Column(
        children: [
      Padding(
      padding: EdgeInsets.symmetric(
      horizontal: deviceWidth * 0.02,
          vertical: deviceHeight * 0.02),
      child: InkWell(
        onTap: () {
          showSelectedTypeSheet();
        },
        child: Container(
          height: deviceHeight * 0.055,
          width: double.infinity,
          decoration: BoxDecoration(
            color: ConstColour.appColor,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding:  EdgeInsets.only(left:  deviceWidth * 0.02),
                child: Text(
                    "Selected Type:",
                    style: TextStyle(
                        color: ConstColour.buttonColor,
                        fontSize: 20
                    )
                ),
              ),
              Row(
                children: [
                  Text(
                      "Blood Sugar",
                      style: TextStyle(
                          color: ConstColour.textColor,
                          fontSize: 22,
                          fontFamily: ConstFont.bold
                      )
                  ),
                  IconButton(
                      onPressed: () => showSelectedTypeSheet(),
                      icon: Icon(Icons.arrow_drop_down,size: 30,)
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ),
          Padding(
            padding: EdgeInsets.only(
                top: deviceHeight * 0.01,
                left: deviceWidth * 0.02),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                "FILTER BY",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  fontFamily: ConstFont.regular,
                ),
              ),
            ),
          ),
          Obx(() =>
              Padding(
                padding: EdgeInsets.only(top: deviceHeight * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: deviceWidth * 0.40,
                      decoration: BoxDecoration(
                        color: ConstColour.appColor,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Row(
                        children: [
                          Radio(
                            value: 1,
                            groupValue: pdfController.selectedType.value,
                            onChanged: pdfController.setSelectedType,
                            activeColor: ConstColour.buttonColor,
                          ),
                          Text(
                            "This Week",
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: ConstFont.regular,
                              color: pdfController.selectedType.value == 1
                                  ? ConstColour.textColor
                                  : ConstColour.greyTextColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: deviceWidth * 0.40,
                      decoration: BoxDecoration(
                        color: ConstColour.appColor,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Row(
                        children: [
                          Radio(
                            value: 2,
                            groupValue: pdfController.selectedType.value,
                            onChanged: pdfController.setSelectedType,
                            activeColor: ConstColour.buttonColor,
                          ),
                          Text(
                            "Last Week",
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: ConstFont.regular,
                              color: pdfController.selectedType.value == 2
                                  ? ConstColour.textColor
                                  : ConstColour.greyTextColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),),
          Obx(() =>
              Padding(
                padding: EdgeInsets.only(top: deviceHeight * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: deviceWidth * 0.40,
                      decoration: BoxDecoration(
                        color: ConstColour.appColor,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Row(
                        children: [
                          Radio(
                            value: 3,
                            groupValue: pdfController.selectedType.value,
                            onChanged: pdfController.setSelectedType,
                            activeColor: ConstColour.buttonColor,
                          ),
                          Text(
                            "This Month",
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: ConstFont.regular,
                              color: pdfController.selectedType.value == 3
                                  ? ConstColour.textColor
                                  : ConstColour.greyTextColor,
                            ),
                          ),
                        ],
                      ),
                    ) ,
                    Container(
                      width: deviceWidth * 0.40,
                      decoration: BoxDecoration(
                        color: ConstColour.appColor,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Row(
                        children: [
                          Radio(
                            value: 4,
                            groupValue: pdfController.selectedType.value,
                            onChanged: pdfController.setSelectedType,
                            activeColor: ConstColour.buttonColor,
                          ),
                          Text(
                            "Last Month",
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: ConstFont.regular,
                              color: pdfController.selectedType.value == 4
                                  ? ConstColour.textColor
                                  : ConstColour.greyTextColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),),
          Obx(() =>
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding:  EdgeInsets.only(left: deviceWidth * 0.02,),
                    child: Text(
                      "CUSTOM FILTER",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        fontFamily: ConstFont.regular,
                        color: ConstColour.textColor,
                      ),
                    ),
                  ),
                  Radio(
                    value: 5,
                    groupValue: pdfController.selectedType.value,
                    onChanged: pdfController.setSelectedType,
                    activeColor: ConstColour.buttonColor,
                  ),
                ],
              ),),
          Obx(() => Padding(
            padding: EdgeInsets.symmetric(
                horizontal: deviceWidth * 0.05,
            ),
            child: Visibility(
              visible: pdfController.weekNameType.value,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(8.0),
                    onTap: () => dateTimeController.selectFromDate(),
                    child: Container(
                      height: deviceHeight * 0.055,
                      width: deviceWidth * 0.4,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1.0,color: Colors.grey.withOpacity(0.5)),
                        color: ConstColour.appColor,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(
                            "assets/Icons/ic_calendar.png",
                            height: deviceHeight * 0.02,
                          ),
                          Text(DateFormat('dd/MM/yyyy').format(dateTimeController.selectedFromDate.value),
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: ConstFont.regular
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(8.0),
                    onTap: () => dateTimeController.selectToDate(),
                    child: Container(
                      height: deviceHeight * 0.055,
                      width: deviceWidth * 0.4,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1.0,color: Colors.grey.withOpacity(0.5)),
                        color: ConstColour.appColor,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(
                            "assets/Icons/ic_calendar.png",
                            height: deviceHeight * 0.02,
                          ),
                          Text(DateFormat('dd/MM/yyyy').format(dateTimeController.selectedToDate.value),
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: ConstFont.regular
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: deviceHeight * 0.03
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(7),
                  onTap: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => GentartePdfScreen(),));
                    // Get.back();
                    pdfController.pdfDialog();
                  },
                  child: Container(
                    height: deviceHeight * 0.05,
                    width: deviceWidth * 0.4,
                    decoration: BoxDecoration(
                      color: ConstColour.pdfIconColor,
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(
                          "assets/Icons/pdf2.png",
                          height: deviceHeight * 0.02,
                        ),
                        Text(
                          'Export To PDF',
                          style: TextStyle(
                              color: ConstColour.appColor
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: deviceHeight * 0.03
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(7),
                  onTap: () {
                    Get.back();
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => GentartePdfScreen(),));
                  },
                  child: Container(
                    height: deviceHeight * 0.05,
                    width: deviceWidth * 0.4,
                    decoration: BoxDecoration(
                      color: ConstColour.reportIconColor,
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(
                          "assets/Icons/view_details.png",
                          height: deviceHeight * 0.02,
                        ),
                        Text('View Reports',
                          style: TextStyle(
                              color: ConstColour.appColor
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void showSelectedTypeSheet() {
    showModalBottomSheet(
      elevation: 0.0,
      enableDrag: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          )),
      context: context,
      builder: (context) {
        var deviceHeight = MediaQuery.of(context).size.height;
        var deviceWidth = MediaQuery.of(context).size.width;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: deviceHeight * 0.03),
              child: Center(
                child: Text(
                  "SELECT DATA TYPE",
                  style: TextStyle(
                      fontSize: 23,
                      fontFamily: ConstFont.bold
                  ),
                ),
              ),
            ),
            ListView.builder(
                // physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                controller: ScrollController(),
                itemCount: pdfController.diaryLists.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      // pdfController.diaryLists = pdfController.diaryLists[index].name.toString()
                      Get.back();
                    },
                    child: ListTile(
                      dense: true,
                      title: Text(
                        pdfController.diaryLists[index].name,
                        style: TextStyle(
                            fontSize: 20,
                            color: ConstColour.textColor,
                            fontFamily: ConstFont.regular
                        ),
                      ),
                      leading: Container(
                        height: deviceHeight * 0.021,
                        child: ClipRRect(
                            child: Image.asset(
                                pdfController.diaryLists[index].image,
                                fit: BoxFit.cover
                            )
                        ),
                      ),
                    ),
                  );
                }
            ),
            SizedBox(height: deviceHeight * 0.01)
          ],
        );
      },
    );
  }
}

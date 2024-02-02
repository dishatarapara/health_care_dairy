import 'package:flutter/material.dart';

class Settingscreen extends StatefulWidget {
  const Settingscreen({super.key});

  @override
  State<Settingscreen> createState() => _SettingscreenState();
}

class _SettingscreenState extends State<Settingscreen> {
  bool isSwitched = false;
  void toggleSwitch(bool value) {

    if(isSwitched == false)
    {
      setState(() {
        isSwitched = true;
      });}
    else
    {
      setState(() {
        isSwitched = false;
      });

    }}
      @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff0f0f0),
      appBar: AppBar(
        backgroundColor:Colors.white,
        title: Text("Settings"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("GENERAL SETTINGS",style: TextStyle(fontSize: 13,fontWeight: FontWeight.w700,color: Colors.grey),)
                ],
              ),
              Card(
                color: Colors.white,
                shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(3),
                ),

                child: Column(
                  children: [
                    ListTile(
                      leading:CircleAvatar(
                          backgroundColor: Colors.indigo[50],
                          radius: 20,
                          child: Image.asset("assets/images/notifications_setting.png", width: 15,height: 15 ,)),
                      title:  Text("Notification",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 13),),
                      trailing: Icon(Icons.arrow_forward_ios_outlined,size: 20,),
                      ),
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.indigo[50],
                        radius: 20,
                          child: Image.asset("assets/images/lock.png",height: 15,width: 15,)),
                      title:  Text("System App Lock",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 13),),
                      trailing: Column(
                        children: [ Transform.scale(
                          scale: 1,
                          child:Switch(
                            onChanged: toggleSwitch,
                            value: isSwitched,
                            activeColor: Colors.blue,


                          ) ),
                        ],
                      ),
                    ),
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.indigo[50],
                        radius: 20,
                          child: Image.asset("assets/images/date.png",height: 15,width: 15,)),
                      title:  Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Date Format",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 13),),
                          Text("30/01/2024",style: TextStyle(fontSize: 10),)
                        ],
                      ),
                      trailing: Icon(Icons.arrow_forward_ios_outlined,size: 20,),
                    ),
                    ListTile(
                      leading:CircleAvatar(
                          backgroundColor: Colors.indigo[50],
                          radius: 20,
                      child: Image.asset("assets/images/time.png",height: 15,width: 15,)),
                      title:  Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Time Format",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 13),),
                          Text("02:29 pm",style: TextStyle(fontSize: 10),),
                        ],
                      ),
                      trailing: Icon(Icons.arrow_forward_ios_outlined,size: 20,),
                    ),
                    ListTile(
                      leading: CircleAvatar(
                          backgroundColor: Colors.indigo[50],
                          radius: 20,
                      child: Image.asset("assets/images/unit_formate.png",height: 15,width: 15,)),
                      title:  Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Unit Format",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 13),),
                          Text("mg/dL,lbs,f",style: TextStyle(fontSize: 10),),
                        ],
                      ),
                      trailing: Icon(Icons.arrow_forward_ios_outlined,size: 20,),
                    ),
                    ListTile(
                      leading:CircleAvatar(
                          backgroundColor: Colors.indigo[50],
                          radius: 20,
                      child: Image.asset("assets/images/number_formate.png",height: 15,width: 15,)),
                      title:  Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Number Format",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 13),),
                          Text("12345678",style: TextStyle(fontSize: 10),),
                        ],
                      ),
                      trailing: Icon(Icons.arrow_forward_ios_outlined,size: 20,),
                    ),
                    ListTile(
                      leading: CircleAvatar(
                          backgroundColor: Colors.indigo[50],
                          radius: 20,
                      child: Image.asset("assets/images/backup_setting.png",height: 15,width: 15,)),
                      title:  Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Backup & Restore",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 13),),
                          Image.asset("assets/images/premium.png",height: 20,width: 20,)
                        ],
                      ),
                      trailing: Icon(Icons.arrow_forward_ios_outlined,size: 20,),
                    ),
                  ],

                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text("COMMUNICATION",style: TextStyle(fontSize: 13,fontWeight: FontWeight.w700,color: Colors.grey),),
                  ),
                ],
              ),
              Card(
                shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(3),
                ),
                color: Colors.white,
                child: Column(

                  children: [
                    Container(
                  child: ListTile(
                  leading:  CircleAvatar(
                      backgroundColor: Colors.orange[50],
                      radius: 20,
                child: Image.asset("assets/images/share.png",height: 15,width: 15,)),
                  title:  Text("Share with friends",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 13),),
                  trailing: Icon(Icons.arrow_forward_ios_outlined,size: 20,),
                  ),
                ),
                    ListTile(
                      leading: CircleAvatar(
                          backgroundColor: Colors.orange[50],
                          radius: 20,
                          child: Image.asset("assets/images/rate.png",height: 15,width: 15,)),
                      title:  Text("Rate Us",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 13),),
                      trailing: Icon(Icons.arrow_forward_ios_outlined,size: 20,),
                    ),
                    ListTile(
                      leading: CircleAvatar(
                          backgroundColor: Colors.orange[50],
                          radius: 20,
                          child: Image.asset("assets/images/privacypolicy.png",height: 15,width: 15,)),
                      title:  Text("Privacy Policy",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 13),),
                      trailing: Icon(Icons.arrow_forward_ios_outlined,size: 20,),
                    ),
                    ListTile(
                      leading: CircleAvatar(
                          backgroundColor: Colors.orange[50],
                          radius: 20,
                          child: Image.asset("assets/images/terms_of_service.png",height: 15,width: 15,)),
                      title:  Text("Terms of Service",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 13),),
                      trailing: Icon(Icons.arrow_forward_ios_outlined,size: 20,),
                    ),


                        ],
                      ),
                    ),
            ]
            ),
        ),
      ),
    ),
    );
  }
}

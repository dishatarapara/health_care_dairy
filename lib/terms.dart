import 'package:flutter/material.dart';
class TermsScreen extends StatefulWidget {
  const TermsScreen({super.key});

  @override
  State<TermsScreen> createState() => _TermsScreenState();
}

class _TermsScreenState extends State<TermsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text ("Terms And condition",),
      leading: Icon(Icons.arrow_back),
      ),
      body:SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
         Padding(
           padding: const EdgeInsets.all(8.0),
           child: Row(
             children: [
               Center(
                child: Text("Wecome to ",style: TextStyle(fontWeight: FontWeight.w100,),
                ),
               ),
               Text('"Healthcare dairy!"',style: TextStyle(fontWeight: FontWeight.bold),),
             ],
           ),
         ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text("These Terms of Use govern your use of the 'Health care dairy'  mobile application provided by us. By \n accessing or using the App, you agree to comply with and be bound by these terms. If you do not agree with these terms, please do not /n use the App.",style: TextStyle(fontWeight: FontWeight.w100 )),
              ),
            ),
            Text("1. Acceptance of Terms",style: TextStyle(fontSize: (20),fontWeight: FontWeight.w500)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text("By using the App, you acknowledge that you have read. understood, and agree to be bound by these Terms of Use. /n These terms may be updated or modified, and it is your responsibility to review them periodically",style: TextStyle(fontWeight: FontWeight.w100)),
                ),
              ),
            Text("2.  User Accounts",style: TextStyle(fontSize: (20),fontWeight: FontWeight.w500)),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text("• To use certain features of the App, you may be  \n required to create a user account. You are responsible \n for maintaining the confidentiality of your account  \n information and password.\n\n"
                               "•You agree to provide accurate and complete \n information when creating your account.",style: TextStyle(fontWeight: FontWeight.w100)),
              ),
            ),
            Text("3. User Conduct",style: TextStyle(fontSize: (20),fontWeight: FontWeight.w500)),

            Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text("• When using the App, you agree not to: \n\n• Violate any applicable laws or regulations. \n\n• Infringe upon the rights of others.Post or share any \n   harmful, abusive, or inappropriate content. \n\n"
              "• Attempt to gain unauthorized access to other users'\n  accounts",style: TextStyle(fontWeight: FontWeight.w100),)
            ),
          ),

            Text("4. Business Pitch Contributions",style: TextStyle(fontSize: (20),fontWeight: FontWeight.w500)),
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: Center(
               child: Text("Users are solely responsible for the information they \ncontribute to  contacts and enquiries on the Health care dairy.  By providing contact details and inquiries, you affirm that",style: TextStyle(fontWeight: FontWeight.w100)),
             ),
           ),
          ]

        ),
      ),


    );
  }
}

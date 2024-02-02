import 'package:flutter/material.dart';
import 'package:health_care_dairy/home.dart';

class Login_Screen extends StatefulWidget {
  const Login_Screen({super.key});

  @override
  State<Login_Screen> createState() => _Login_ScreenState();
}

class _Login_ScreenState extends State<Login_Screen> {
  bool _validate = false;
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Form(
          key: _formkey,
            child: Column(
              children: [
                Center(
                  child: Container(
                   child: Image.asset("assets/images/img.png")
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Center(child: Text('Login',style:TextStyle(fontSize: 30,color: Colors.deepPurple ,fontWeight: FontWeight.bold,))),
                ),
            
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text('Email',style:TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.w400)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    hintText: "Enter your email",
                  border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  ),
                      ),
                    validator: (value) {
                      if (value!.isEmpty ) {
                        return 'Enter a valid email!';
                      }
                      return null;
                    },
                  ),
                ),
            
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text('Password',style:TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.w400,)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    obscureText: true,
                    obscuringCharacter: "*",
                    decoration: InputDecoration(
                      hintText: "Enter your password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter a valid password!';
                      }
                      else if (value!.length < 6) {
                        return "Password length should be atleast 6";
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Forget password?',style:TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 500,
                    height: 50,
                    child: ElevatedButton(
                      child: Text("Login",style: TextStyle(color: Colors.white,),),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.deepPurple),
                      onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Homescreen()),
                      );

                      if (_formkey.currentState!.validate()) {
                      setState(() {
                     _validate = true;
                      });
                      setState(() {
                      _validate = false;
                    });}},

                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Have an account?",style: TextStyle(color: Colors.black),),
                      TextButton(onPressed: () {
                        }, child: Text("SIGN Up",style: TextStyle(color: Colors.deepPurple),)),
                    ],
                  ),
                )

              ],
            ),
          ),
        ),
      );
  }
}

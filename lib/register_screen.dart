
import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});


  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool _validate = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Form(
          key: _formKey,
          child: Column
            (mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/registerimage/regi.png"),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Center(
                    child: Text(
                      "CREATE ACCOUNT",
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),

                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            autovalidateMode: AutovalidateMode
                                .onUserInteraction,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black
                                  ),
                                  borderRadius: BorderRadius.circular(16)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black
                                  ),
                                  borderRadius: BorderRadius.circular(16)),
                              labelText: 'Full name',
                              labelStyle: TextStyle(color: Colors.black),
                              hintText: "Enter your name",
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter a valid full name";
                              }
                            },

                          ),
                        ),
                      ),


                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            autovalidateMode: AutovalidateMode
                                .onUserInteraction,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black
                                  ),
                                  borderRadius: BorderRadius.circular(16)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black
                                  ),
                                  borderRadius: BorderRadius.circular(16)),
                              labelText: 'Last name',
                              labelStyle: TextStyle(color: Colors.black),
                              hintText: "Enter your name",
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter a valid last name";
                              }
                            },

                          ),
                        ),
                      ),
                    ]),
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),


                          child: TextFormField(
                            autovalidateMode: AutovalidateMode
                                .onUserInteraction,
                            obscureText: false,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black
                                  ),
                                  borderRadius: BorderRadius.circular(16)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black
                                  ),
                                  borderRadius: BorderRadius.circular(16)),
                              labelText: 'Enter Your Mobile Number ',

                              labelStyle: TextStyle(color: Colors.black),
                              hintText: "Enter your mo",

                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter a valid  mo number";
                              }
                              else if (value!.length <= 10) {
                                return "mo no length should be atleast 10";
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ]),

                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            autovalidateMode: AutovalidateMode
                                .onUserInteraction,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black
                                  ),
                                  borderRadius: BorderRadius.circular(15)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black
                                  ),
                                  borderRadius: BorderRadius.circular(16)),
                              labelText: 'Enter your Email ',
                              labelStyle: TextStyle(color: Colors.black),
                              hintText: "Enter Your Email",
                            ),

                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter a valid Email";
                              }
                            },
                          ),
                        ),
                      ),
                    ]),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            autovalidateMode: AutovalidateMode
                                .onUserInteraction,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black
                                  ),
                                  borderRadius: BorderRadius.circular(16)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black
                                  ),
                                  borderRadius: BorderRadius.circular(16)),
                              labelText: 'Enter Your Address ',
                              labelStyle: TextStyle(color: Colors.black),
                              hintText: "Enter your address",
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter a valid address";
                              }
                            },
                          ),
                        ),
                      ),
                    ]),

                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            autovalidateMode: AutovalidateMode
                                .onUserInteraction,
                            obscureText: true,
                            obscuringCharacter: "*",
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black
                                  ),
                                  borderRadius: BorderRadius.circular(16)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black
                                  ),
                                  borderRadius: BorderRadius.circular(16)),
                              labelText: 'Password ',
                              labelStyle: TextStyle(color: Colors.black),
                              hintText: "Enter your password",
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
                      ),
                    ]),

                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            autovalidateMode: AutovalidateMode
                                .onUserInteraction,
                            obscureText: true,
                            obscuringCharacter: "*",
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black
                                  ),
                                  borderRadius: BorderRadius.circular(16)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black
                                  ),
                                  borderRadius: BorderRadius.circular(16)),
                              labelText: 'Confirm Password ',
                              labelStyle: TextStyle(color: Colors.black),
                              hintText: "Enter your confirm password",
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
                      ),
                    ]),


                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(width: 500,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            _validate = true;
                          });
                          setState(() {
                            _validate = false;
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.deepPurple,
                        minimumSize: const Size.fromHeight(40),
                      ),
                      child: Text(
                        'Register', style: TextStyle(color: Colors.white,),),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 50),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Have an account?',
                          style: TextStyle(color: Colors.black, fontSize: 13),
                        ),
                        TextButton(onPressed: () {

                        },
                            child: Text("SIGN IN",
                              style: TextStyle(color: Colors.deepPurple),))
                      ]),
                ),
              ]
          ),
        ),
      ),

    );
  }
}

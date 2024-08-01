// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison, unnecessary_new, avoid_unnecessary_containers, use_build_context_synchronously, unused_local_variable

import 'package:ecom/login.dart';
import 'package:ecom/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String email = "", password = "", name = "";
  TextEditingController namecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController mailcontroller = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  registration() async {
    if (password != null &&
        namecontroller.text != "" &&
        mailcontroller.text != "") {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          "Registered Successfully",
          style: TextStyle(fontSize: 20.0),
        )));
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => MyHomePage(title: 'hii')));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                "Password Provided is too Weak",
                style: TextStyle(fontSize: 18.0),
              )));
        } else if (e.code == "email-already-in-use") {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                "Account Already exists",
                style: TextStyle(fontSize: 18.0),
              )));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "images/login.jpg",
              fit: BoxFit.cover,
            ),
          ),
          SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.25),
                    Form(
                      key: _formkey,
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 2.0, horizontal: 30.0),
                            decoration: BoxDecoration(
                                color: Color(0xFFedf0f8),
                                borderRadius: BorderRadius.circular(30)),
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter Name';
                                }
                                return null;
                              },
                              controller: namecontroller,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Name",
                                  hintStyle: TextStyle(
                                      color: Color(0xFFb2b7bf),
                                      fontSize: 18.0)),
                            ),
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 2.0, horizontal: 30.0),
                            decoration: BoxDecoration(
                                color: Color(0xFFedf0f8),
                                borderRadius: BorderRadius.circular(30)),
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter Email';
                                }
                                return null;
                              },
                              controller: mailcontroller,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Email",
                                  hintStyle: TextStyle(
                                      color: Color(0xFFb2b7bf),
                                      fontSize: 18.0)),
                            ),
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 2.0, horizontal: 30.0),
                            decoration: BoxDecoration(
                                color: Color(0xFFedf0f8),
                                borderRadius: BorderRadius.circular(30)),
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter Password';
                                }
                                return null;
                              },
                              controller: passwordcontroller,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Password",
                                  hintStyle: TextStyle(
                                      color: Color(0xFFb2b7bf),
                                      fontSize: 18.0)),
                              obscureText: true,
                            ),
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          GestureDetector(
                            onTap: () async {
                              if (_formkey.currentState!.validate()) {
                                setState(() {
                                  email = mailcontroller.text;
                                  name = namecontroller.text;
                                  password = passwordcontroller.text;
                                });
                                await registration();
                              }
                            },
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.symmetric(
                                    vertical: 13.0, horizontal: 30.0),
                                decoration: BoxDecoration(
                                    color: Color(0xFF273671),
                                    borderRadius: BorderRadius.circular(30)),
                                child: Center(
                                    child: Text(
                                  "Sign Up",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.w500),
                                ))),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    Text(
                      "or LogIn with",
                      style: TextStyle(
                          color: Color(0xFF273671),
                          fontSize: 22.0,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "images/google.png",
                          height: 45,
                          width: 45,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(
                          width: 30.0,
                        ),
                        Image.asset(
                          "images/apple1.png",
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account?",
                            style: TextStyle(
                                color: Color(0xFF8c8e98),
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500)),
                        SizedBox(
                          width: 5.0,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LogIn()));
                          },
                          child: Text(
                            "LogIn",
                            style: TextStyle(
                                color: Color(0xFF273671),
                                fontSize: 20.0,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.25),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
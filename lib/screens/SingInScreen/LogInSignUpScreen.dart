// ignore_for_file: unnecessary_this, use_key_in_widget_constructors, unused_field, prefer_final_fields, prefer_const_constructors, use_build_context_synchronously, deprecated_member_use, prefer_const_literals_to_create_immutables, unused_import, must_be_immutable, unused_local_variable, duplicate_import, unused_element, unnecessary_import, no_leading_underscores_for_local_identifiers, file_names, sized_box_for_whitespace, avoid_unnecessary_containers, sort_child_properties_last

import 'dart:async';
import 'dart:math';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import "package:flutter/services.dart";
import 'package:riise/providers/UserLoginProvider.dart';

class LogInSignUpScreen extends StatefulWidget {
  static const routeName = '/rise-logIn-signUp-screen';
  const LogInSignUpScreen({super.key});

  @override
  State<LogInSignUpScreen> createState() => _LogInSignUpScreenState();
}

class _LogInSignUpScreenState extends State<LogInSignUpScreen> {
  final _formkey = GlobalKey<FormState>();
  List<DropdownMenuItem<String>> userTypeList = [
    DropdownMenuItem(
      child: Text("Guest"),
      value: "Guest",
    ),
    DropdownMenuItem(
      child: Text("Faculty"),
      value: "Faculty",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;
    return Material(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset("assets/images/logo2.png", fit: BoxFit.cover),
            SizedBox(
              height: 20,
            ),
            Text(
              Provider.of<UserLoginProvider>(context, listen: false).userType ==
                      "Guest"
                  ? "Welcome, Guest "
                  : "Welcome, Faculty",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            // SizedBox(
            //   height: 20,
            // ),
            // Padding(
            //   padding:
            //       const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20),
            //   child: Form(
            //     key: _formkey,
            //     child: Column(
            //       children: [
            //         TextFormField(
            //           decoration: InputDecoration(
            //             hintText: "Enter UserName",
            //             labelText: "UserName",
            //           ),
            //           validator: (value) {
            //             print("username $value");
            //             if (value!.length < 1) return 'UserName cant be empty';
            //             return null;
            //           },
            //         ),
            //         SizedBox(
            //           height: 10,
            //         ),
            //         TextFormField(
            //           obscureText: true,
            //           decoration: InputDecoration(
            //             hintText: "Enter Password",
            //             labelText: "Password",
            //           ),
            //           validator: (value) {
            //             print("password $value");
            //             if (value!.length < 1) return 'password cant be empty';
            //             // return null;
            //             if (value.length < 8)
            //               return "Password length must be greater than 8";
            //             return null;
            //           },
            //         ),
            //         SizedBox(
            //           height: 40,
            //         ),
            //         SizedBox(
            //           width: 140,
            //           height: 50,
            //           child: ElevatedButton(
            //             onPressed: () {},
            //             child: Text(
            //               Provider.of<UserLoginProvider>(context, listen: false)
            //                           .userType ==
            //                       "SignUp"
            //                   ? 'Sign Up'
            //                   : "Log In",
            //             ),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
          SizedBox(
            height: 15,
          ),
          Align(
            child: Container(
              width: screenWidth * 0.9,
              padding: EdgeInsets.symmetric(
                vertical: 5,
              ),
              child: DropdownButtonFormField(
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.green.shade600,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.green.shade600,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.green.shade200,
                ),
                items: userTypeList,
                dropdownColor: Colors.green.shade200,
                value: userTypeList[0].value,
                onChanged: (String? value) {
                  setState(() {
                    print(value);
                    Provider.of<UserLoginProvider>(context, listen: false)
                        .userType = value!;
                  });
                },
              ),
            ),
          ),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton.extended(
                onPressed: () async {
                  Provider.of<UserLoginProvider>(context, listen: false).checkPointsWhenButtonIsPressed(context);
                },
                icon: Image.asset(
                  "assets/images/google_icon.png",
                  height: 32,
                  width: 32,
                ),
                label: Text('Google Sign In',
                ),
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _checkForError(
      BuildContext context, String titleText, String contextText,
      {bool popVal = false}) async {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }

    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('$titleText'),
        content: Text('$contextText'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.check_circle_rounded,
              color: Color(0xff42ccc3),
            ),
            iconSize: 50,
            color: Colors.brown,
            onPressed: () {
              setState(() {
                if (popVal == false) {
                  Navigator.pop(ctx);
                }
              });
            },
          ),
        ],
      ),
    );
  }
}

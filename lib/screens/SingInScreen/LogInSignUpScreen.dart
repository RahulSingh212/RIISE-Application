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
  static const routeName = '/rise-logIn-signUp-single-screen';
  const LogInSignUpScreen({super.key});

  @override
  State<LogInSignUpScreen> createState() => _LogInSignUpScreenState();
}

class _LogInSignUpScreenState extends State<LogInSignUpScreen> {
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Login",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 60.sp,
          ),
          textAlign: TextAlign.center,
        ),
        iconTheme: IconThemeData(
          color: Colors.blue,
          size: 80.r,
        ),
        actions: [
          Container(
            padding: EdgeInsets.only(top: 15.h, bottom: 25.h, right: 20.w),
            child: Center(
              child: Image.network(
                "https://www.iiitd.ac.in/sites/default/files/images/logo/style1colorlarge.jpg",
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset("assets/images/logo2.png", fit: BoxFit.cover),
            SizedBox(
              height: 75,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton.extended(
                onPressed: () async {
                  Provider.of<UserLoginProvider>(context, listen: false)
                      .checkPointsWhenButtonIsPressed(context);
                },
                icon: Image.asset(
                  "assets/images/google_icon.png",
                  height: 32,
                  width: 32,
                ),
                label: Text(
                  'Google Sign In',
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

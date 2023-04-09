// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, unused_import, unnecessary_import, duplicate_import, unused_local_variable, deprecated_member_use, file_names, avoid_unnecessary_containers

import 'dart:async';
import 'dart:math';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../AddDataScreen/AddNewThemeScreen.dart';
import '../AddDataScreen/AddNewEventScreen.dart';
import '../AddDataScreen/AddNewKeyNoteSpeaker.dart';

class AddSectionScreen extends StatefulWidget {
  static const routeName = '/rise-add-section-screen';

  @override
  State<AddSectionScreen> createState() => _AddSectionScreenState();
}

class _AddSectionScreenState extends State<AddSectionScreen> {
  Map<String, dynamic> screenMapping = {
    "add-new-theme": AddNewThemeScreen(),
    "add-new-event": AddNewEventScreen(),
    "add-new-keynote-speaker": AddNewKeyNoteSpeakerScreen(),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf2f3f4),
      appBar: AppBar(
        elevation: 5,
        leading: IconButton(
          enableFeedback: false,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_circle_left,
            color: Color(0xff42ccc3),
            size: 35,
          ),
        ),
        title: Text(
          "Add Section",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 24,
          ),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          // TabButton(
          //   context,
          //   "Add New Theme",
          //   "add-new-theme",
          // ),
          TabButton(
            context,
            "Add New Event",
            "add-new-event",
          ),
          TabButton(
            context,
            "Add New Keynote Speaker",
            "add-new-keynote-speaker",
          ),
        ],
      ),
    );
  }

  Widget TabButton(
    BuildContext context,
    String buttonName,
    String screenKey,
  ) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;

    return (Align(
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => screenMapping[screenKey],
            ),
          );
        },
        child: Container(
          margin: EdgeInsets.only(
            top: 15,
          ),
          padding: EdgeInsets.all(15),
          width: screenWidth * 0.95,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.5),
            color: Colors.greenAccent.shade100,
          ),
          child: Row(
            children: [
              Container(
                child: Icon(
                  Icons.arrow_right,
                  size: 20,
                ),
              ),
              Container(
                child: Text(
                  buttonName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, unused_import, unnecessary_import, duplicate_import, unused_local_variable, deprecated_member_use, file_names

import 'dart:async';
import 'dart:math';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../components/SideNavBar.dart';
import '../../providers/EventsProvider.dart';

class ForwardLookingPannelScreen extends StatefulWidget {
  static const routeName = '/rise-forward-looking-pannel-screen';

  const ForwardLookingPannelScreen({super.key});

  @override
  State<ForwardLookingPannelScreen> createState() => _ForwardLookingPannelScreenState();
}

class _ForwardLookingPannelScreenState extends State<ForwardLookingPannelScreen> {

  loadData() async {
    await Provider.of<EventProvider>(context, listen: false).fetchEventTracks(context, "ForwardLookingPanels").then((value){
      setState(() {

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // var screenHeight = MediaQuery.of(context).size.height;
    // var screenWidth = MediaQuery.of(context).size.width;
    // var topInsets = MediaQuery.of(context).viewInsets.top;
    // var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    // var useableHeight = screenHeight - topInsets - bottomInsets;

    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      drawer: SideNavBar(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Forward Pannel",
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
        // actions: [
        //   Container(
        //     child: IconButton(
        //       onPressed: () {},
        //       icon: Icon(
        //         Icons.person,
        //       ),
        //     ),
        //   ),
        // ],
      ),
      body: ListView(
        children: [
          // SizedBox(
          //   height: 20,
          // ),
          // Align(
          //   child: Container(
          //     padding: EdgeInsets.symmetric(
          //       horizontal: 54.w,
          //     ),
          //     width: 1080.w,
          //     height: 2106.h,
          //     alignment: Alignment.center,
          //     decoration: BoxDecoration(
          //       color: Colors.blue.shade400,
          //     ),
          //     child: RichText(
          //       textAlign: TextAlign.justify,
          //       text: TextSpan(
          //         children: const [
          //           TextSpan(
          //             text:
          //                 ".",
          //           )
          //         ],
          //         style: TextStyle(
          //           fontSize: 70.sp,
          //           color: Colors.white,
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}

// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, unused_import, unnecessary_import, duplicate_import, unused_local_variable, deprecated_member_use, file_names, avoid_print

import 'dart:async';
import 'dart:math';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:riise/components/ThemeCard.dart';
import 'package:riise/modules/EventUtil.dart';
import 'package:riise/screens/Profile/ProfileScreen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../components/EventCard.dart';
import "../../components/SideNavBar.dart";
import '../../modules/ThemeUtil.dart';

import '../../providers/EventsProvider.dart';
import '../../providers/FacultiesProvider.dart';
import "../AddDataScreen/AddSectionScreen.dart";

class HomeScreen extends StatefulWidget {
  static const routeName = '/rise-home-screen';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _auth = FirebaseAuth.instance;
  String userName = "Henansh";
  late TextEditingController searchBarController = TextEditingController();

  ThemeListUtil themes = ThemeListUtil();
  EventListUtil events = EventListUtil();

  @override
  void initState() {
    super.initState();
    // _auth.signOut();
    Provider.of<FacultiesProvider>(context, listen: false)
        .fetchCollegeFaculties(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<FacultiesProvider>(context, listen: false)
        .fetchCollegeFaculties(context);
  }

  @override
  Widget build(BuildContext context) {
    // var padding = MediaQuery.of(context).padding;
    // double width = (MediaQuery.of(context).size.width);
    // double height =
    //     (MediaQuery.of(context).size.height) - padding.top - padding.bottom;

    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      drawer: SideNavBar(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Home",
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
            padding: EdgeInsets.only(right: 5),
            child: IconButton(
              onPressed: () {
                // _auth.signOut();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ProfileScreen(),
                  ),
                );
              },
              icon: Icon(
                Icons.person,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        physics: BouncingScrollPhysics(),
        child: Container(
          padding: EdgeInsets.only(top: 280.h, left: 54.w, right: 54.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hello,",
                style: TextStyle(fontSize: 70.sp, color: Colors.black12),
              ),
              Text(
                userName,
                style: TextStyle(fontSize: 80.sp, color: Colors.black),
              ),
              Container(
                padding: EdgeInsets.only(top: 58.h),
                height: 210.h,
                child: TextField(
                  controller: searchBarController,
                  decoration: InputDecoration(
                    hintText: "Search",
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xffebebeb),
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintStyle: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      fontSize: 45.sp,
                      fontStyle: FontStyle.normal,
                      color: Color(0xff6c757d),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        print("serchpressed");
                      },
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 58.h,
                ),
                child: Text(
                  "Themes",
                  style: TextStyle(fontSize: 70.sp, color: Colors.black),
                ),
              ),
              Container(
                // padding: EdgeInsets.only(top: 58.h),
                margin: EdgeInsets.only(
                  top: 25.h,
                ),
                alignment: Alignment.center,
                // decoration: BoxDecoration(
                //   border: Border.all()
                // ),
                height: 520.h,
                child: ListView.builder(
                  // itemCount: themes.getThemesList().length,
                  itemCount: Provider.of<EventProvider>(context, listen: false)
                      .themesList
                      .length,
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    vertical: 23.h,
                    horizontal: 21.w,
                  ),
                  itemBuilder: (context, position) {
                    return ThemeCard(
                      position: position,
                      themeDetails:
                          Provider.of<EventProvider>(context, listen: false)
                              .themesList[position],
                    );
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 58.h,
                ),
                child: Text(
                  "TimeLine",
                  style: TextStyle(fontSize: 70.sp, color: Colors.black),
                ),
              ),
              Container(
                // padding: EdgeInsets.only(top: 58.h),
                margin: EdgeInsets.only(top: 58.h),
                alignment: Alignment.topCenter,
                // decoration: BoxDecoration(
                //   border: Border.all()
                // ),
                // height: height*1.5,
                child: ListView.builder(
                  itemCount: events.getEventsList().length,
                  // scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.only(top: 23.h),
                  itemBuilder: (context, position) {
                    return EventCard(position: position);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        child: FloatingActionButton.extended(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AddSectionScreen(),
              ),
            );
          },
          icon: Icon(
            Icons.add,
          ),
          label: Text("Add"),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

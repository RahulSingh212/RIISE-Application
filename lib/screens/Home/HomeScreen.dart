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
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:riise/components/ThemeCard.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../components/EventCard.dart';
import "../../components/SideNavBar.dart";
import '../../modules/ThemeCardUtil.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/rise-home-screen';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String userName = "Henansh";
  late TextEditingController searchBarController = TextEditingController();
  ThemeCardListUtil themes = ThemeCardListUtil();

  @override
  Widget build(BuildContext context) {
    var padding = MediaQuery.of(context).padding;
    double width = (MediaQuery.of(context).size.width);
    double height = (MediaQuery.of(context).size.height) - padding.top - padding.bottom;

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
            fontSize: 20,
          ),
          textAlign: TextAlign.center,
        ),
        iconTheme: IconThemeData(
          color: Colors.blue,
          size: 30,
        ),
        actions: [
          Container(
            padding: EdgeInsets.only(right: 5),
            child: IconButton(
              onPressed: () {},
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
          padding: EdgeInsets.only(
              top: height * 0.12, left: width * 0.05, right: width * 0.05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hello,",
                style: TextStyle(fontSize: 20, color: Colors.black12),
              ),
              Text(
                userName,
                style: TextStyle(fontSize: 30, color: Colors.black),
              ),
              Container(
                padding: EdgeInsets.only(top: height * 0.025),
                height: height * 0.09,
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
                      fontSize: 15,
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
              // Container(
              //   margin: EdgeInsets.only(
              //     top: height * 0.025,
              //   ),
              //   child: Text(
              //     "Themes",
              //     style: TextStyle(fontSize: 30, color: Colors.black),
              //   ),
              // ),
              // Container(
              //   // padding: EdgeInsets.only(top: height * 0.025),
              //   margin: EdgeInsets.only(top: height * 0.025),
              //   alignment: Alignment.center,
              //   // decoration: BoxDecoration(
              //   //   border: Border.all()
              //   // ),
              //   height: 0.18 * height,
              //   child: ListView.builder(
              //     itemCount: themes.getThemesList().length,
              //     scrollDirection: Axis.horizontal,
              //     physics: BouncingScrollPhysics(),
              //     padding: EdgeInsets.symmetric(
              //         vertical: 0.01 * height, horizontal: 0.02 * width),
              //     itemBuilder: (context, position) {
              //       return ThemeCard(position: position);
              //     },
              //   ),
              // ),
              Container(
                margin: EdgeInsets.only(
                  top: height * 0.025,
                ),
                child: Text(
                  "TimeLine",
                  style: TextStyle(fontSize: 30, color: Colors.black),
                ),
              ),
              Container(
                // padding: EdgeInsets.only(top: height * 0.025),
                margin: EdgeInsets.only(top: height * 0.025),
                alignment: Alignment.topCenter,
                // decoration: BoxDecoration(
                //   border: Border.all()
                // ),
                // height: height*1.5,
                child: ListView.builder(
                  itemCount: themes.getThemesList().length,
                  // scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.only(top: 0.01 * height),
                  itemBuilder: (context, position) {
                    return EventCard(position: position);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

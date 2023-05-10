// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, unused_import, unnecessary_import, duplicate_import, unused_local_variable, deprecated_member_use, file_names, must_be_immutable

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
import 'package:riise/models/EventInfo.dart';
import 'package:riise/models/ThemeInfo.dart';

import 'package:url_launcher/url_launcher.dart';

import '../../components/SideNavBar.dart';
import '../../components/SpeakerCard.dart';
import '../../models/SpeakerInfo.dart';
import '../helper/HexagonClipper.dart';


class EventDetailScreen extends StatefulWidget {
  static const routeName = '/rise-themes-detail-screen';

  EventDetailScreen({
    Key? key,
    // required this.position,
    required this.eventDetails,
  }) : super(key: key);

  // late int position;
  //Change with provider
  late EventServerInformation eventDetails;

  @override
  State<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,

        extendBodyBehindAppBar: true,
        // drawer: SideNavBar(),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text(
          "Event Details",
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
        body: Container(
          padding: EdgeInsets.only(top: 280.h, left: 20.w, right: 20.w),
          margin: EdgeInsets.symmetric(horizontal: 30.w),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,

            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ClipPath(
                        clipper: HexagonClipper(),
                        child: Container(
                          color: Color(0xff3faea8),
                          child: Image.network(
                            widget.eventDetails.Event_Image_Url,
                            width: 400.r,
                            height: 500.r,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Flexible(
                        child: Text(
                          widget.eventDetails.Event_Name,
                          style: TextStyle(fontSize: 70.sp),
                          softWrap: true,
                          textAlign: TextAlign.center,
                          // maxLines: 100,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 60.h,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "About",
                      style: TextStyle(fontSize: 60.sp),
                      softWrap: true,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    Flexible(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 45.w),
                        child: Text(
                          widget.eventDetails.Event_Info,
                          style: TextStyle(fontSize: 33.sp),
                          softWrap: true,
                          textAlign: TextAlign.justify,
                          // maxLines: 100,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 60.h,
                ),
                widget.eventDetails.EventSpeakersList.isNotEmpty?
                Container(
                  alignment: Alignment.topCenter,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Speakers",
                        style: TextStyle(fontSize: 60.sp),
                        softWrap: true,
                        textAlign: TextAlign.center,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.symmetric(vertical: 40.h),
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, position) {
                          return SpeakerCard(speakerDetails: widget.eventDetails.EventSpeakersList[position],);
                        },
                        itemCount: widget.eventDetails.EventSpeakersList.length,
                      ),
                    ],
                  ),
                ):Container(),
              ],
            ),
          ),
        )
    );
  }
}
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
import 'package:riise/models/SpeakerInfo.dart';
import 'package:riise/modules/SpeakerUtil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../components/SideNavBar.dart';

class SpeakerDetailScreen extends StatefulWidget {
  static const routeName = '/rise-keynote-speaker-detail-screen';

  SpeakerDetailScreen({
    Key? key,
    // required this.position,
    required this.speakerDetails,
  }) : super(key: key);

  // late int position;
  late SpeakerUtil speakerDetails;

  @override
  State<SpeakerDetailScreen> createState() => _SpeakerDetailScreenState();
}

class _SpeakerDetailScreenState extends State<SpeakerDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        extendBodyBehindAppBar: true,
        drawer: SideNavBar(),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          //TODO - Make it flexible
          title: Text(
            "Faculty",
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
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(width: 3),
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.grey
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            widget.speakerDetails.image,
                            width: 450.r,
                            height: 450.r,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Flexible(
                        child: Text(
                          widget.speakerDetails.name,
                          style: TextStyle(fontSize: 70.sp),
                          softWrap: true,
                          textAlign: TextAlign.center,
                          // maxLines: 100,
                        ),
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        // mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.access_time
                            // size: ,
                          ),
                         SizedBox(
                           width: 20.w,
                         ),
                         Flexible(
                            child: Text(
                              "${widget.speakerDetails.getStartTime()} - ${widget.speakerDetails.getEndTime()}",
                              style: TextStyle(
                                  fontSize: 40.sp),
                              softWrap: true,
                              textAlign: TextAlign.left,
                              // maxLines: 100,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                              CupertinoIcons.speaker_1
                            // size: ,
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          Flexible(
                            child: Text(
                              widget.speakerDetails.talkTitle,
                              style: TextStyle(
                                  fontSize: 40.sp),
                              softWrap: true,
                              textAlign: TextAlign.left,
                              // maxLines: 100,
                            ),
                          ),
                        ],
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
                      "Abstract",
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
                          widget.speakerDetails.abstract,
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
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Bio",
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
                          widget.speakerDetails.bio,
                          style: TextStyle(fontSize: 33.sp),
                          softWrap: true,
                          textAlign: TextAlign.justify,
                          // maxLines: 100,
                        ),
                      ),
                    ),
                  ],
                ),

              ],
            ),
          ),
        ));
  }
}
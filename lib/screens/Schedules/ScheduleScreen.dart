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
import 'package:timelines/timelines.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../components/EventCard.dart';
import '../../components/EventCard2.dart';
import '../../components/SideNavBar.dart';
// import '../../components/CategoryEventCard.dart';

import '../../models/EventInfo.dart';
import '../../providers/EventsProvider.dart';

class ScheduleScreen extends StatefulWidget {
  static const routeName = '/rise-schedule-screen';

  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

extension TimeOfDayExtension on TimeOfDay {
  int compareTo(TimeOfDay other) {
    if (hour < other.hour) return -1;
    if (hour > other.hour) return 1;
    if (minute < other.minute) return -1;
    if (minute > other.minute) return 1;
    return 0;
  }
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  List<EventServerInformation> scheduleList = [];
  late TextEditingController searchBarController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // extendBodyBehindAppBar: true,
      drawer: SideNavBar(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Schedule",
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
      body: StreamBuilder(
        stream: Provider.of<EventProvider>(context, listen: false)
            .getEntireListOfEvents(context)
            .asStream(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          print("Inside");
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            print("Snap shot data");
            print(snapshot.data);
            print(snapshot.data.length);
            return SingleChildScrollView(
              child: FixedTimeline.tileBuilder(
                // mainAxisSize: MainAxisSize.max,
                theme: TimelineTheme.of(context).copyWith(
                  nodePosition: 0.5, //50% from Left
                ),
                builder: TimelineTileBuilder.connected(
                  contentsAlign: ContentsAlign.alternating,

                  connectorBuilder: (context, index, lineConnector) => SizedBox(
                    // height: 20.0,
                    child: DecoratedLineConnector(
                      thickness: 21.6.w,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        // color: TimeOfDay.fromDateTime(DateTime.now()).compareTo(snapshot.data[index].Event_Start_Time) < 0
                        //     ? Colors.green
                        //     : Colors.red,
                      ),
                    ),
                  ),
                  indicatorBuilder: (context, index) => ContainerIndicator(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 46.8.h),
                      child: index % 2 == 0
                          ? Icon(
                              Icons.label_important_outline_rounded,
                              size: 100.r,
                              color: Colors.grey,
                            )
                          : Transform.rotate(
                              angle: pi,
                              child: Icon(
                                Icons.label_important_outline_rounded,
                                size: 100.r,
                                color: Colors.grey,
                              ),
                            ),
                    ),
                  ),

                  // oppositeContentsBuilder: (context, index) => Text(appointments.getThemesList()[index].getTime()),
                  contentsBuilder: (context, index) => Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 58.5.h,
                      horizontal: 21.6.w,
                    ),
                    child: EventCard2(
                      position: index,
                      eventDetails: snapshot.data[index],
                    ),
                  ),
                  oppositeContentsBuilder: (context, index) => Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 163.8.h,
                      horizontal: 15.w,
                    ),
                    // decoration: ,
                    child: Card(
                      elevation: 16,
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(
                          vertical: 46.8.h,
                          horizontal: 25,
                        ),
                        decoration: BoxDecoration(
                          border: Border(
                            left: index % 2 == 0
                                ? BorderSide(
                                    color: Colors.greenAccent,
                                    width: 5,
                                  )
                                : BorderSide(color: Colors.transparent),
                            right: index % 2 != 0
                                ? BorderSide(
                                    color: Colors.greenAccent,
                                    width: 5,
                                  )
                                : BorderSide(color: Colors.transparent),
                          ),
                        ),
                        child: Column(
                          children: [
                            Container(
                              child: Text(
                                "${snapshot.data[index].Event_Start_Time.format(context)} - ${snapshot.data[index].Event_End_Time.format(context)}",
                                style: TextStyle(
                                  fontSize: 45.sp,
                                ),
                              ),
                            ),
                            checkEventInterval(snapshot.data[index])
                                ? Container(
                                    margin: EdgeInsets.only(
                                      top: 5,
                                    ),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "On-Going",
                                      style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        color: Colors.green.shade400,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 40.sp,
                                        // decoration: TextDecoration.underline,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  )
                                : SizedBox(
                                    height: 0,
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  itemCount: snapshot.data.length,
                  // connectorStyle:
                ),
              ),
            );
          }
        },
      ),
    );
  }

  bool checkEventInterval(EventServerInformation event1) {
    int d = DateTime.now().day,
        m = DateTime.now().month,
        y = DateTime.now().year;
    int d1 = event1.Event_Date.day,
        m1 = event1.Event_Date.month,
        y1 = event1.Event_Date.year;
    int ts = TimeOfDay.now().hour * 60 + TimeOfDay.now().minute;
    int t1s =
        event1.Event_Start_Time.hour * 60 + event1.Event_Start_Time.minute;
    int t1e = event1.Event_End_Time.hour * 60 + event1.Event_End_Time.minute;

    if (d == d1 && m == m1 && y == y1) {
      if (ts >= t1s && ts <= t1e)
        return true;
      else
        return false;
    } else
      return false;
  }
}

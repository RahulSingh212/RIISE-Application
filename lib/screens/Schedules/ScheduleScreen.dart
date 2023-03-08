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
import 'package:timelines/timelines.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../components/EventCard.dart';
import '../../components/EventCard2.dart';
import '../../components/SideNavBar.dart';
import '../../components/ThemeCard.dart';
import '../../modules/EventUtil.dart';
import '../../modules/ThemeUtil.dart';

class ScheduleScreen extends StatefulWidget {
  static const routeName = '/rise-schedule-screen';

  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  String userName = "Henansh";
  late TextEditingController searchBarController = TextEditingController();
  EventListUtil events = EventListUtil();

  @override
  Widget build(BuildContext context) {
    var padding = MediaQuery.of(context).padding;
    double width = (MediaQuery.of(context).size.width);
    double height =
        (MediaQuery.of(context).size.height) - padding.top - padding.bottom;

    print("Event List ");
    print(events.getEventsList());

    return Scaffold(
        backgroundColor: Colors.white,
        extendBodyBehindAppBar: true,
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
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
          iconTheme: IconThemeData(
            color: Colors.blue,
            size: 30,
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
        body: SingleChildScrollView(
          padding: EdgeInsets.only(top: height * 0.12),
          child: FixedTimeline.tileBuilder(
              // mainAxisSize: MainAxisSize.max,
              theme: TimelineTheme.of(context).copyWith(
                nodePosition: 0.5, //5% from Left
              ),
              builder: TimelineTileBuilder.connected(
                contentsAlign: ContentsAlign.alternating,

                connectorBuilder: (context, index, lineConnector) => SizedBox(
                  // height: 20.0,
                  child: DecoratedLineConnector(
                    thickness: 0.02 * width,
                    decoration: BoxDecoration(

                        color:  DateTime.now().compareTo(events.getEventsList()[index].time ) < 0? Colors.green:Colors.red,

                      ),

                  ),
                ),
                indicatorBuilder: (context, index) => ContainerIndicator(
                    child: Container(
                  padding: EdgeInsets.symmetric(vertical: 0.02 * height),
                  child: index %2 == 0?Icon(
                    Icons.label_important_outline_rounded,
                    size: 30,
                    color: Colors.grey,
                  ):Transform.rotate(angle: pi,child: Icon(
                    Icons.label_important_outline_rounded,
                    size: 30,
                    color: Colors.grey,
                  ),),
                )),

                // oppositeContentsBuilder: (context, index) => Text(appointments.getThemesList()[index].getTime()),
                contentsBuilder: (context, index) => Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 0.025 * height, horizontal: 0.02 * width),
                  child: EventCard2(position: index),
                ),
                oppositeContentsBuilder: (context, index) => Container(
                  padding: EdgeInsets.symmetric(
                      vertical: 0.07 * height, horizontal: 0.07 * width),
                  // decoration: ,
                  child: Card(
                    elevation: 16,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 0.02*height, horizontal: 0.03*width),
                      decoration: BoxDecoration(
                        border: Border(
                          left: index % 2 == 0 ? BorderSide(color: Colors.greenAccent, width: 5) : BorderSide(color: Colors.transparent),
                          right: index % 2 != 0 ? BorderSide(color: Colors.greenAccent, width: 5) : BorderSide(color: Colors.transparent),
                        ),
                      ),
                      child: Text(
                        events.getEventsList()[index].getTime(),
                            style: TextStyle(fontSize: 20),
                      ),
                    ),

                  ),
                ),
                itemCount: events.getEventsList().length,
                // connectorStyle:
              )),
        ));
  }
}

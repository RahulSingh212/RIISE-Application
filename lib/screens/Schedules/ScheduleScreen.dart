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
import '../../components/ThemeCard.dart';

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
  String userName = "Henansh";
  late TextEditingController searchBarController = TextEditingController();

  List<EventServerInformation> eventUtil = [];

  bool isloading = true;

  Future<void> loadDataUtil() async {
    await Provider.of<EventProvider>(context, listen: false).fetchEventTracks(context, "SpeakerTracks");
    await Provider.of<EventProvider>(context, listen: false).fetchEventTracks(context, "PosterTracks");
    await Provider.of<EventProvider>(context, listen: false).fetchEventTracks(context, "PanelDiscussion");
    eventUtil = [
      Provider.of<EventProvider>(context, listen: false).posterTracksList,
      Provider.of<EventProvider>(context, listen: false).speakerTracksList,
      Provider.of<EventProvider>(context, listen: false).panelDiscussionList
    ].expand((x) => x).toList();
  }

  void loadData() async {
    await loadDataUtil().then((value){
      setState(() {
        isloading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  // @override
  // void didChangeDependencies() {
  //   // TODO: implement didChangeDependencies
  //   super.didChangeDependencies();
  //   eventUtilTemp = Provider.of<EventProvider>(context, listen: false);
  //
  //   eventUtilTemp.fetchEventTracks(context, "SpeakerTracks");
  //   eventUtilTemp.fetchEventTracks(context, "PosterTracks");
  //   eventUtilTemp.fetchEventTracks(context, "PanelDiscussion");
  //   eventUtil = [
  //     eventUtilTemp.posterTracksList,
  //     eventUtilTemp.speakerTracksList,
  //     eventUtilTemp.panelDiscussionList
  //   ].expand((x) => x).toList();
  // }

  @override
  Widget build(BuildContext context) {
    // var padding = MediaQuery.of(context).padding;
    // double width = (MediaQuery.of(context).size.width);
    // double height =
    //     (MediaQuery.of(context).size.height) - padding.top - padding.bottom;
    //
    // print("Event List ");
    // print(events.getEventsList());

    if(isloading)
      {
        return Center(child: CircularProgressIndicator(),);
      }
    else
      {
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
            body: SingleChildScrollView(
              padding: EdgeInsets.only(top: 280.8.h),
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
                          color: TimeOfDay.fromDateTime(DateTime.now()).compareTo(
                              eventUtil[index].Event_Start_Time) <
                              0
                              ? Colors.green
                              : Colors.red,
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
                        )),

                    // oppositeContentsBuilder: (context, index) => Text(appointments.getThemesList()[index].getTime()),
                    contentsBuilder: (context, index) => Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 58.5.h,
                        horizontal: 21.6.w,
                      ),
                      child: EventCard2(
                        position: index,
                        eventDetails: eventUtil[index],
                      ),
                    ),
                    oppositeContentsBuilder: (context, index) => Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 163.8.h,
                        horizontal: 25.w,
                      ),
                      // decoration: ,
                      child: Card(
                        elevation: 16,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 46.8.h,
                            horizontal: 32.4,
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
                          child: Text(
                            "${eventUtil[index].Event_Start_Time.format(context)} - ${eventUtil[index].Event_End_Time.format(context)}",
                            style: TextStyle(fontSize: 45.sp),
                          ),
                        ),
                      ),
                    ),
                    itemCount: eventUtil.length,
                    // connectorStyle:
                  )),
            ));
      }
  }
}

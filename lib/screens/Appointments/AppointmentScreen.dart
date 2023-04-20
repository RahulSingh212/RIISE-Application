// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, unused_import, unnecessary_import, duplicate_import, unused_local_variable, deprecated_member_use, file_names

import 'dart:async';
import 'dart:developer';
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
import 'package:riise/modules/AppointmentUtil.dart';
import 'package:riise/providers/FacultiesProvider.dart';
import 'package:timelines/timelines.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../components/AppointmentCard.dart';
import '../../components/EventCard.dart';
import '../../components/SideNavBar.dart';
import '../../providers/CalendarAPI.dart';


class AppointmentScreen extends StatefulWidget {
  static const routeName = '/rise-appointment-screen';

  const AppointmentScreen({super.key});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  String userName = "Henansh";
  late TextEditingController searchBarController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    // var padding = MediaQuery.of(context).padding;
    // double width = (MediaQuery.of(context).size.width);
    // double height =
    //     (MediaQuery.of(context).size.height) - padding.top - padding.bottom;
    //
    // print(DateTime.now().subtract(Duration(minutes: DateTime.now().minute)));
    // print(DateTime.now());
    // print(DateTime.now().compareTo(DateTime.now().subtract(Duration(minutes: DateTime.now().minute))));
    return Scaffold(
        backgroundColor: Colors.white,
        extendBodyBehindAppBar: true,
        drawer: SideNavBar(),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text(
            "Appointments",
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
                padding: EdgeInsets.only(top: 15.h,bottom: 25.h,right: 20.w),
                child: Center(child: Image.network("https://www.iiitd.ac.in/sites/default/files/images/logo/style1colorlarge.jpg",fit: BoxFit.contain,))
            ),
          ],
        ),
        // body: SingleChildScrollView(
        //   scrollDirection: Axis.vertical,
        //   keyboardDismissBehavior : ScrollViewKeyboardDismissBehavior.onDrag,
        //   physics: BouncingScrollPhysics(),
        //   child: Container(
        //     padding: EdgeInsets.only(top: height*0.12,left: width*0.05,right: width*0.05),
        //     child: Column(
        //       mainAxisAlignment: MainAxisAlignment.start,
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         Container(
        //           // padding: EdgeInsets.only(top: height * 0.025),
        //             margin:  EdgeInsets.only(top: height * 0.025),
        //             alignment: Alignment.topCenter,
        //             // decoration: BoxDecoration(
        //             //   border: Border.all()
        //             // ),
        //             // height: height*1.5,
        //             child: ListView.builder(
        //                 itemCount: themes.getThemesList().length,
        //                 // scrollDirection: Axis.horizontal,
        //                 shrinkWrap: true,
        //                 physics: NeverScrollableScrollPhysics(),
        //                 padding: EdgeInsets.only(top: 0.01*height),
        //                 itemBuilder: (context,position) {
        //                   return AppointmentCard(position: position);
        //                 })
        //         ),
        //       ],
        //     ),
        //   ),
        // )
        body: SingleChildScrollView(
          padding: EdgeInsets.only(top: 280.8.h),
          child: FixedTimeline.tileBuilder(
              // mainAxisSize: MainAxisSize.max,
              theme: TimelineTheme.of(context).copyWith(
                nodePosition: 0.05, //5% from Left
              ),
              builder: TimelineTileBuilder.connected(
                contentsAlign: ContentsAlign.basic,

                connectorBuilder: (context, index, lineConnector) => SizedBox(
                  // height: 20.0,
                  child: DecoratedLineConnector(
                    thickness: 25.r,
                    decoration: BoxDecoration(
                      color: DateTime.now().compareTo(
                                  Provider.of<CalenderAPI>(context,listen: false).appointmentList[index].starTime) <
                              0
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),
                ),
                indicatorBuilder: (context, index) => ContainerIndicator(
                    child: Container(
                  padding: EdgeInsets.symmetric(vertical: 46.8.h),
                  child: Icon(
                    Icons.schedule,
                    size: 80.r,
                    color: Colors.grey,
                  ),
                )),

                // oppositeContentsBuilder: (context, index) => Text(Provider.of<CalenderAPI>(context,listen: false).appointmentList[index].getTime()),
                contentsBuilder: (context, index) =>
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.h,horizontal: 20.w),
                      child: AppointmentCard(appointment: Provider.of<CalenderAPI>(context,listen: false).appointmentList[index],),
                    ),
                itemCount: Provider.of<CalenderAPI>(context,listen: false).appointmentList.length,
                // connectorStyle:
              )),
        ));
  }
}

// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, unused_import, unnecessary_import, duplicate_import, unused_local_variable, deprecated_member_use, file_names

import 'dart:async';
import 'dart:developer';
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
import 'package:riise/modules/AppointmentUtil.dart';
import 'package:riise/providers/FacultiesProvider.dart';
import 'package:timelines/timelines.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../components/AppointmentCard.dart';
import '../../components/EventCard.dart';
import '../../components/SideNavBar.dart';
import '../../providers/CalendarAPI.dart';
import '../SingInScreen/LogInSignUpScreen.dart';

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
    var padding = MediaQuery.of(context).padding;
    double width = (MediaQuery.of(context).size.width);
    double height =
        (MediaQuery.of(context).size.height) - padding.top - padding.bottom;

    return Scaffold(
      backgroundColor: Colors.white,
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
      body: FirebaseAuth.instance.currentUser != null
          ? StreamBuilder(
              stream: Provider.of<CalenderAPI>(context, listen: false)
                  .fetchListOfSchedules(context)
                  .asStream(),
              builder: (BuildContext ctx, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {

                  print("Schedule List 001");
                  print(snapshot.data);

                  return Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network(
                          "https://iiitd.ac.in/riise2023/assets/img/riise2022logo15059.png",
                          fit: BoxFit.contain,
                          width: 400.spMin,
                          height: 400.spMin,
                        ),
                        Text(
                          "No Appointment\nAvailable",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.greenAccent.shade700,
                            fontSize: 80.sp,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );

                } else {
                  print("Schedule List 000");
                  print(snapshot.data);
                  return SingleChildScrollView(
                    child: FixedTimeline.tileBuilder(
                      // mainAxisSize: MainAxisSize.max,
                      theme: TimelineTheme.of(context).copyWith(
                        nodePosition: 0.05, //5% from Left
                      ),
                      builder: TimelineTileBuilder.connected(
                        contentsAlign: ContentsAlign.basic,
                        connectorBuilder: (context, index, lineConnector) =>
                            SizedBox(child: DecoratedLineConnector(

                            // thickness: 25.r,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                            ),
                          ),
                        ),
                        indicatorBuilder: (context, index) =>
                            ContainerIndicator(
                          child: Container(
                            color: Colors.transparent,
                            // padding: EdgeInsets.symmetric(vertical: 46.8.h),
                            // child: Icon(
                            //   Icons.schedule,
                            //   size: 80.r,
                            //   color: Colors.greenAccent.shade100,
                            // ),
                          ),
                        ),
                        contentsBuilder: (context, index) => Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 20.h, horizontal: 20.w),

                          child: AppointmentCard(
                            appointment:
                            snapshot.data[index],
                          ),
                        ),
                        itemCount:
                        snapshot.data.length,
                        // connectorStyle:
                      ),
                    ),
                  );
                }
              },
            )
          : Center(
              child: Container(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => LogInSignUpScreen(),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.login_rounded,
                  ),
                  label: Text("Log-in to view appointment"),
                ),
              ),
            ),
    );
  }
}

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
import 'package:new_version/new_version.dart';
import 'package:provider/provider.dart';
import 'package:riise/components/CategoryEventCard.dart';
import 'package:riise/models/ThemeInfo.dart';

import 'package:riise/providers/ThemeProvider.dart';
import 'package:riise/providers/UserDetailsProvider.dart';
import 'package:riise/screens/Profile/ProfileScreen.dart';
import 'package:riise/screens/Schedules/ScheduleScreen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../components/EventCard.dart';
import "../../components/SideNavBar.dart";
import '../../models/EventInfo.dart';

import '../../providers/EventsProvider.dart';
import '../../providers/FacultiesProvider.dart';
import "../AddDataScreen/AddSectionScreen.dart";
import '../BeyondPannel/BeyondCollegePannelScreen.dart';
import '../DemosAndResearchs/DemosAndResearchsHighLightScreen.dart';
import '../ForwardPannel/ForwardLookingPannelScreen.dart';
import '../Keynote/KeynoteSpeakersScreen.dart';
import '../Profile/FacultyProfileScreen.dart';
import '../Profile/GuestProfileScreen.dart';
import '../RNDShowcase/RnDShowcaseAndDemoScreen.dart';
import '../ResearchShowcase/ResearchShowcaseScreen.dart';
import '../SingInScreen/LogInSignUpScreen.dart';
import '../StartupShowcase/StartUpShowcase.dart';
import '../TabScreen.dart';

const FACULTY_USERTYPE = "Faculty";
const GUEST_USERTYPE = "Guest";

class HomeScreen extends StatefulWidget {
  static const routeName = '/rise-home-screen';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // final _auth = FirebaseAuth.instance;
  late TextEditingController searchBarController = TextEditingController();
  final ThemeProvider themeProviderModel = ThemeProvider();

  List<EventServerInformation> eventUtil = [];

  fetchUserProfile() async {
    Provider.of<UserDetailsProvider>(context, listen: false)
        .setUserType(context);
  }

  // void _checkVersionOfApplicatoin() {
  //   final newVersion = NewVersion(
  //     iOSId: "com.example.riise",
  //     androidId: "com.iiitd.riise",
  //   );

  //   newVersion.showAlertIfNecessary(context: context);
  // }

  @override
  void initState() {
    super.initState();

    if (FirebaseAuth.instance.currentUser != null) {
      fetchUserProfile();
    }
    // _checkVersionOfApplicatoin();

    // Provider.of<FacultiesProvider>(context, listen: false).insertListOfFaculties(context);
  }

  List<dynamic> categoryList = [
    [
      "Keynote Address",
      "https://iiitd.ac.in/riise2023/assets/img/riise2022logo15059.png",
      KeynoteSpeakersScreen()
    ],
    [
      "Morning Panels",
      "https://iiitd.ac.in/riise2023/assets/img/riise2022logo15059.png",
      ForwardLookingPannelScreen()
    ],
    [
      "Afternoon Panels",
      "https://iiitd.ac.in/riise2023/assets/img/riise2022logo15059.png",
      BeyondCollegePannelScreen()
    ],
    [
      "Research Showcases",
      "https://iiitd.ac.in/riise2023/assets/img/riise2022logo15059.png",
      ResearchShowcaseScreen()
    ],
  ];

  @override
  Widget build(BuildContext context) {
    // var padding = MediaQuery.of(context).padding;
    // double width = (MediaQuery.of(context).size.width);
    // double height =
    //     (MediaQuery.of(context).size.height) - padding.top - padding.bottom;

    return Scaffold(
      backgroundColor: Colors.white,
      // extendBodyBehindAppBar: true,
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
            padding: EdgeInsets.only(top: 15.h, bottom: 25.h),
            child: Center(
              child: Image.network(
                "https://www.iiitd.ac.in/sites/default/files/images/logo/style1colorlarge.jpg",
                fit: BoxFit.contain,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 5),
            child: IconButton(
              onPressed: () async {
                if (FirebaseAuth.instance.currentUser != null) {
                  if (Provider.of<UserDetailsProvider>(context, listen: false)
                          .userType ==
                      "Guest") {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => GuestProfileScreen(),
                      ),
                    );
                  } else {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => FacultyProfileScreen(),
                      ),
                    );
                  }
                } else {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => LogInSignUpScreen(),
                    ),
                  );
                }
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
          padding: EdgeInsets.only(left: 54.w, right: 54.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(top: 60.h, left: 40.w, right: 40.w),
                width: double.infinity,
                height: 380.h,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: NetworkImage(
                      "https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/DefaultImages%2FIllstration.png?alt=media&token=c2319412-6f5b-47fa-a12b-e70029f8fa2e"),
                  fit: BoxFit.fill,
                )
                    // color: Colors.red,
                    ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hello,",
                      style: TextStyle(
                        fontSize: 70.sp,
                        color: Colors.black12,
                      ),
                    ),
                    Text(
                      FirebaseAuth.instance.currentUser != null
                          ? FirebaseAuth.instance.currentUser?.displayName
                              as String
                          : "Guest User",
                      style: TextStyle(
                        fontSize: 80.sp,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        top: 58.h,
                      ),
                      child: Text(
                        "Themes",
                        style: TextStyle(
                          fontSize: 70.sp,
                          color: Colors.black,
                        ),
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
                        itemCount: categoryList.length,
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        padding: EdgeInsets.symmetric(
                          vertical: 23.h,
                          horizontal: 21.w,
                        ),
                        itemBuilder: (context, position) {
                          return CategoryEventCard(
                              // position: position,
                              eventDetail: categoryList[position]
                              //     Provider.of<EventProvider>(context, listen: false)
                              //         .themesList[position],
                              );
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: 58.h,
                      ),
                      child: Text(
                        "Schedule",
                        style: TextStyle(fontSize: 70.sp, color: Colors.black),
                      ),
                    ),
                    StreamBuilder(
                        stream:
                            Provider.of<EventProvider>(context, listen: false)
                                .getEntireListOfEvents(context)
                                .asStream(),
                        builder: (BuildContext ctx, AsyncSnapshot snapshot) {
                          if (!snapshot.hasData) {
                            return Container(
                              height: 750.spMin,
                              alignment: Alignment.center,
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          } else {
                            return Container(
                              alignment: Alignment.topCenter,
                              child: ListView.builder(
                                itemCount: snapshot.data.length,
                                // scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.only(top: 10.h),
                                itemBuilder: (context, position) {
                                  return EventCard(
                                    eventDetails: snapshot.data[position],
                                  );
                                },
                              ),
                            );
                          }
                        }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      // floatingActionButton: SizedBox(
      //   child: FloatingActionButton.extended(
      //     onPressed: () {
      //       Navigator.of(context).push(
      //         MaterialPageRoute(
      //           builder: (context) => AddSectionScreen(),
      //         ),
      //       );
      //     },
      //     icon: Icon(
      //       Icons.add,
      //     ),
      //     label: Text("Add"),
      //   ),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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

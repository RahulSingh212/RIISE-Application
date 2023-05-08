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
import 'package:riise/components/CategoryEventCard.dart';
import 'package:riise/models/ThemeInfo.dart';

import 'package:riise/providers/ThemeProvider.dart';
import 'package:riise/providers/UserDetailsProvider.dart';
import 'package:riise/screens/Profile/ProfileScreen.dart';
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
  final _auth = FirebaseAuth.instance;
  late TextEditingController searchBarController = TextEditingController();
  final ThemeProvider themeProviderModel = ThemeProvider();

  List<EventServerInformation> eventUtil = [];

  fetchUserProfile() async {
    Provider.of<UserDetailsProvider>(context, listen: false).setUserType(context);
  }

  List<dynamic> categoryList = [
    [
      "Keynote Address",
      "https://iiitd.ac.in/riise2023/assets/img/riise2022logo15059.png",
      KeynoteSpeakersScreen()
    ],
    [
      "Forward Panels",
      "https://iiitd.ac.in/riise2023/assets/img/riise2022logo15059.png",
      ForwardLookingPannelScreen()
    ],
    [
      "Beyond Panels",
      "https://iiitd.ac.in/riise2023/assets/img/riise2022logo15059.png",
      BeyondCollegePannelScreen()
    ],
    // [
    //   "Start-UP Showcases",
    //   "https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/DefaultImages%2Fartificial-intelligence.png?alt=media&token=bcdabc98-e730-46a4-87d6-f921517e9ae8",
    //   StartUpShowcaseScreen()
    // ],
    // [
    //   "Demos And Researches",
    //   "https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/DefaultImages%2Fartificial-intelligence.png?alt=media&token=bcdabc98-e730-46a4-87d6-f921517e9ae8",
    //   DemosAndResearchHighlightScreen()
    // ],
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
                      _auth.currentUser?.displayName as String,
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
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            return Container(
                              // padding: EdgeInsets.only(top: 58.h),
                              margin: EdgeInsets.only(top: 58.h),
                              alignment: Alignment.topCenter,
                              // decoration: BoxDecoration(
                              //   border: Border.all()
                              // ),
                              // height: height*1.5,
                              child: ListView.builder(
                                itemCount: snapshot.data.length,
                                // scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.only(top: 23.h),
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

      // StreamBuilder(
      //   stream: Provider.of<EventProvider>(context, listen: false).getEntireListOfEvents(context).asStream(),
      //   builder: (BuildContext context, AsyncSnapshot snapshot) {
      //     if (!snapshot.hasData) {
      //       return Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     } else {
      //       return SingleChildScrollView(
      //         scrollDirection: Axis.vertical,
      //         keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      //         physics: BouncingScrollPhysics(),
      //         child: Container(
      //           padding: EdgeInsets.only(top: 280.h, left: 54.w, right: 54.w),
      //           child: Column(
      //             mainAxisAlignment: MainAxisAlignment.start,
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             children: [
      //               Container(
      //                 padding:
      //                     EdgeInsets.only(top: 60.h, left: 40.w, right: 40.w),
      //                 width: double.infinity,
      //                 height: 380.h,
      //                 decoration: BoxDecoration(
      //                     image: DecorationImage(
      //                   image: NetworkImage(
      //                       "https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/DefaultImages%2FIllstration.png?alt=media&token=c2319412-6f5b-47fa-a12b-e70029f8fa2e"),
      //                   fit: BoxFit.fill,
      //                 )
      //                     // color: Colors.red,
      //                     ),
      //                 child: Column(
      //                   mainAxisAlignment: MainAxisAlignment.start,
      //                   crossAxisAlignment: CrossAxisAlignment.start,
      //                   children: [
      //                     Text(
      //                       "Hello,",
      //                       style: TextStyle(
      //                         fontSize: 70.sp,
      //                         color: Colors.black12,
      //                       ),
      //                     ),
      //                     Text(
      //                       _auth.currentUser?.displayName as String,
      //                       style: TextStyle(
      //                         fontSize: 80.sp,
      //                         color: Colors.black,
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //               Container(
      //                 child: Column(
      //                   crossAxisAlignment: CrossAxisAlignment.start,
      //                   mainAxisAlignment: MainAxisAlignment.start,
      //                   children: [
      //                     Container(
      //                       margin: EdgeInsets.only(
      //                         top: 58.h,
      //                       ),
      //                       child: Text(
      //                         "Themes",
      //                         style: TextStyle(
      //                           fontSize: 70.sp,
      //                           color: Colors.black,
      //                         ),
      //                       ),
      //                     ),
      //                     Container(
      //                       // padding: EdgeInsets.only(top: 58.h),
      //                       margin: EdgeInsets.only(
      //                         top: 25.h,
      //                       ),
      //                       alignment: Alignment.center,
      //                       // decoration: BoxDecoration(
      //                       //   border: Border.all()
      //                       // ),
      //                       height: 520.h,
      //                       child: ListView.builder(
      //                         // itemCount: themes.getThemesList().length,
      //                         itemCount: categoryList.length,
      //                         scrollDirection: Axis.horizontal,
      //                         physics: BouncingScrollPhysics(),
      //                         padding: EdgeInsets.symmetric(
      //                           vertical: 23.h,
      //                           horizontal: 21.w,
      //                         ),
      //                         itemBuilder: (context, position) {
      //                           return CategoryEventCard(
      //                               // position: position,
      //                               eventDetail: categoryList[position]
      //                               //     Provider.of<EventProvider>(context, listen: false)
      //                               //         .themesList[position],
      //                               );
      //                         },
      //                       ),
      //                     ),
      //                     Container(
      //                       margin: EdgeInsets.only(
      //                         top: 58.h,
      //                       ),
      //                       child: Text(
      //                         "Schedule",
      //                         style: TextStyle(
      //                             fontSize: 70.sp, color: Colors.black),
      //                       ),
      //                     ),
      //                     Container(
      //                       // padding: EdgeInsets.only(top: 58.h),
      //                       margin: EdgeInsets.only(top: 58.h),
      //                       alignment: Alignment.topCenter,
      //                       // decoration: BoxDecoration(
      //                       //   border: Border.all()
      //                       // ),
      //                       // height: height*1.5,
      //                       child: ListView.builder(
      //                         itemCount: eventUtil.length,
      //                         // scrollDirection: Axis.horizontal,
      //                         shrinkWrap: true,
      //                         physics: NeverScrollableScrollPhysics(),
      //                         padding: EdgeInsets.only(top: 23.h),
      //                         itemBuilder: (context, position) {
      //                           return EventCard(
      //                             eventDetails: eventUtil[position],
      //                           );
      //                         },
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ),
      //       );
      //     }
      //   },
      // ),

      // SingleChildScrollView(
      //   scrollDirection: Axis.vertical,
      //   keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      //   physics: BouncingScrollPhysics(),
      //   child: Container(
      //     padding: EdgeInsets.only(top: 280.h, left: 54.w, right: 54.w),
      //     child: Column(
      //       mainAxisAlignment: MainAxisAlignment.start,
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: [
      //         Text(
      //           "Hello,",
      //           style: TextStyle(fontSize: 70.sp, color: Colors.black12),
      //         ),
      //         Text(
      //           userName,
      //           style: TextStyle(fontSize: 80.sp, color: Colors.black),
      //         ),
      //         Container(
      //           padding: EdgeInsets.only(top: 58.h),
      //           height: 210.h,
      //           child: TextField(
      //             controller: searchBarController,
      //             decoration: InputDecoration(
      //               hintText: "Search",
      //               border: OutlineInputBorder(),
      //               enabledBorder: OutlineInputBorder(
      //                 borderSide: BorderSide(
      //                   color: Color(0xffebebeb),
      //                 ),
      //                 borderRadius: BorderRadius.circular(12),
      //               ),
      //               hintStyle: TextStyle(
      //                 fontFamily: 'Roboto',
      //                 fontWeight: FontWeight.w400,
      //                 fontSize: 45.sp,
      //                 fontStyle: FontStyle.normal,
      //                 color: Color(0xff6c757d),
      //               ),
      //               suffixIcon: IconButton(
      //                 icon: Icon(Icons.search),
      //                 onPressed: () {
      //                   print("serchpressed");
      //                 },
      //               ),
      //             ),
      //           ),
      //         ),
      //         Container(
      //           margin: EdgeInsets.only(
      //             top: 58.h,
      //           ),
      //           child: Text(
      //             "Themes",
      //             style: TextStyle(fontSize: 70.sp, color: Colors.black),
      //           ),
      //         ),
      //         Container(
      //           // padding: EdgeInsets.only(top: 58.h),
      //           margin: EdgeInsets.only(
      //             top: 25.h,
      //           ),
      //           alignment: Alignment.center,
      //           // decoration: BoxDecoration(
      //           //   border: Border.all()
      //           // ),
      //           height: 520.h,
      //           child: ListView.builder(
      //             // itemCount: themes.getThemesList().length,
      //             itemCount: themeUtil.themesList.length,
      //             scrollDirection: Axis.horizontal,
      //             physics: BouncingScrollPhysics(),
      //             padding: EdgeInsets.symmetric(
      //               vertical: 23.h,
      //               horizontal: 21.w,
      //             ),
      //             itemBuilder: (context, position) {
      //               return ThemeCard(
      //                   // position: position,
      //                   themeDetails: themeUtil.themesList[position]
      //                   //     Provider.of<EventProvider>(context, listen: false)
      //                   //         .themesList[position],
      //                   );
      //             },
      //           ),
      //         ),
      //         Container(
      //           margin: EdgeInsets.only(
      //             top: 58.h,
      //           ),
      //           child: Text(
      //             "TimeLine",
      //             style: TextStyle(fontSize: 70.sp, color: Colors.black),
      //           ),
      //         ),
      //         Container(
      //           // padding: EdgeInsets.only(top: 58.h),
      //           margin: EdgeInsets.only(top: 58.h),
      //           alignment: Alignment.topCenter,
      //           // decoration: BoxDecoration(
      //           //   border: Border.all()
      //           // ),
      //           // height: height*1.5,
      //           child: ListView.builder(
      //             itemCount: eventUtil.length,
      //             // scrollDirection: Axis.horizontal,
      //             shrinkWrap: true,
      //             physics: NeverScrollableScrollPhysics(),
      //             padding: EdgeInsets.only(top: 23.h),
      //             itemBuilder: (context, position) {
      //               return EventCard(
      //                 eventDetails: eventUtil[position],
      //               );
      //             },
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),

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

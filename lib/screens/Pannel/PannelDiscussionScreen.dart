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
import 'package:riise/providers/EventsProvider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../components/FacultyCard.dart';
import '../../components/SideNavBar.dart';
import '../../components/SpeakerCard.dart';
import '../../modules/SpeakerUtil.dart';
import '../../providers/FacultiesProvider.dart';

class PannelDiscussionScreen extends StatefulWidget {
  static const routeName = '/rise-pannel-discussion-screen';

  const PannelDiscussionScreen({super.key});

  @override
  State<PannelDiscussionScreen> createState() => _PannelDiscussionScreenState();
}

class _PannelDiscussionScreenState extends State<PannelDiscussionScreen> {
  late TextEditingController searchBarController = TextEditingController();
  late String filterValue = "";

  List<SpeakerUtil> speakerList = <SpeakerUtil>[
    SpeakerUtil(
        "Swati Tiwari",
        "Entrepreneurship is a common keyword but belief in your idea is strongest motivation to be called as an Entrepreneur. The interesting part of the journey has been leaving an established career to a new journey and finding the customer. The key mantra is for growth and strategy is continuous innovation.",
        "Swati has taken a lead in solving the real time Safety and security of workman and industrial assets using Artificial Intelligence and Deep Learning through her Startup Arcturus Business Solutions. A domain expert in India Power and Energy Sector she has held various leadership roles solving some real complex challenges. She is an Engineer and management postgraduate with formal flavour of Entrepreneurship education from Stanford Business School and University of California",
        "https://iiitd.ac.in/riise2022/assets/img/swatitiwari235.jpg",
        "Entrepreneurship - Finding Customers and Continuous Innovation",
        DateTime.now(),
        DateTime.now()),
    SpeakerUtil(
        "Swati Tiwari",
        "Entrepreneurship is a common keyword but belief in your idea is strongest motivation to be called as an Entrepreneur. The interesting part of the journey has been leaving an established career to a new journey and finding the customer. The key mantra is for growth and strategy is continuous innovation.",
        "Swati has taken a lead in solving the real time Safety and security of workman and industrial assets using Artificial Intelligence and Deep Learning through her Startup Arcturus Business Solutions. A domain expert in India Power and Energy Sector she has held various leadership roles solving some real complex challenges. She is an Engineer and management postgraduate with formal flavour of Entrepreneurship education from Stanford Business School and University of California",
        "https://iiitd.ac.in/riise2022/assets/img/swatitiwari235.jpg",
        "Entrepreneurship - Finding Customers and Continuous Innovation",
        DateTime.now(),
        DateTime.now()),
    SpeakerUtil(
        "Swati Tiwari",
        "Entrepreneurship is a common keyword but belief in your idea is strongest motivation to be called as an Entrepreneur. The interesting part of the journey has been leaving an established career to a new journey and finding the customer. The key mantra is for growth and strategy is continuous innovation.",
        "Swati has taken a lead in solving the real time Safety and security of workman and industrial assets using Artificial Intelligence and Deep Learning through her Startup Arcturus Business Solutions. A domain expert in India Power and Energy Sector she has held various leadership roles solving some real complex challenges. She is an Engineer and management postgraduate with formal flavour of Entrepreneurship education from Stanford Business School and University of California",
        "https://iiitd.ac.in/riise2022/assets/img/swatitiwari235.jpg",
        "Entrepreneurship - Finding Customers and Continuous Innovation",
        DateTime.now(),
        DateTime.now()),
    SpeakerUtil(
        "Swati Tiwari",
        "Entrepreneurship is a common keyword but belief in your idea is strongest motivation to be called as an Entrepreneur. The interesting part of the journey has been leaving an established career to a new journey and finding the customer. The key mantra is for growth and strategy is continuous innovation.",
        "Swati has taken a lead in solving the real time Safety and security of workman and industrial assets using Artificial Intelligence and Deep Learning through her Startup Arcturus Business Solutions. A domain expert in India Power and Energy Sector she has held various leadership roles solving some real complex challenges. She is an Engineer and management postgraduate with formal flavour of Entrepreneurship education from Stanford Business School and University of California",
        "https://iiitd.ac.in/riise2022/assets/img/swatitiwari235.jpg",
        "Entrepreneurship - Finding Customers and Continuous Innovation",
        DateTime.now(),
        DateTime.now()),
    SpeakerUtil(
        "Swati Tiwari",
        "Entrepreneurship is a common keyword but belief in your idea is strongest motivation to be called as an Entrepreneur. The interesting part of the journey has been leaving an established career to a new journey and finding the customer. The key mantra is for growth and strategy is continuous innovation.",
        "Swati has taken a lead in solving the real time Safety and security of workman and industrial assets using Artificial Intelligence and Deep Learning through her Startup Arcturus Business Solutions. A domain expert in India Power and Energy Sector she has held various leadership roles solving some real complex challenges. She is an Engineer and management postgraduate with formal flavour of Entrepreneurship education from Stanford Business School and University of California",
        "https://iiitd.ac.in/riise2022/assets/img/swatitiwari235.jpg",
        "Entrepreneurship - Finding Customers and Continuous Innovation",
        DateTime.now(),
        DateTime.now()),
    SpeakerUtil(
        "Swati Tiwari",
        "Entrepreneurship is a common keyword but belief in your idea is strongest motivation to be called as an Entrepreneur. The interesting part of the journey has been leaving an established career to a new journey and finding the customer. The key mantra is for growth and strategy is continuous innovation.",
        "Swati has taken a lead in solving the real time Safety and security of workman and industrial assets using Artificial Intelligence and Deep Learning through her Startup Arcturus Business Solutions. A domain expert in India Power and Energy Sector she has held various leadership roles solving some real complex challenges. She is an Engineer and management postgraduate with formal flavour of Entrepreneurship education from Stanford Business School and University of California",
        "https://iiitd.ac.in/riise2022/assets/img/swatitiwari235.jpg",
        "Entrepreneurship - Finding Customers and Continuous Innovation",
        DateTime.now(),
        DateTime.now()),
    SpeakerUtil(
        "Swati Tiwari",
        "Entrepreneurship is a common keyword but belief in your idea is strongest motivation to be called as an Entrepreneur. The interesting part of the journey has been leaving an established career to a new journey and finding the customer. The key mantra is for growth and strategy is continuous innovation.",
        "Swati has taken a lead in solving the real time Safety and security of workman and industrial assets using Artificial Intelligence and Deep Learning through her Startup Arcturus Business Solutions. A domain expert in India Power and Energy Sector she has held various leadership roles solving some real complex challenges. She is an Engineer and management postgraduate with formal flavour of Entrepreneurship education from Stanford Business School and University of California",
        "https://iiitd.ac.in/riise2022/assets/img/swatitiwari235.jpg",
        "Entrepreneurship - Finding Customers and Continuous Innovation",
        DateTime.now(),
        DateTime.now()),
    SpeakerUtil(
        "Swati Tiwari",
        "Entrepreneurship is a common keyword but belief in your idea is strongest motivation to be called as an Entrepreneur. The interesting part of the journey has been leaving an established career to a new journey and finding the customer. The key mantra is for growth and strategy is continuous innovation.",
        "Swati has taken a lead in solving the real time Safety and security of workman and industrial assets using Artificial Intelligence and Deep Learning through her Startup Arcturus Business Solutions. A domain expert in India Power and Energy Sector she has held various leadership roles solving some real complex challenges. She is an Engineer and management postgraduate with formal flavour of Entrepreneurship education from Stanford Business School and University of California",
        "https://iiitd.ac.in/riise2022/assets/img/swatitiwari235.jpg",
        "Entrepreneurship - Finding Customers and Continuous Innovation",
        DateTime.now(),
        DateTime.now()),
    SpeakerUtil(
        "Swati Tiwari",
        "Entrepreneurship is a common keyword but belief in your idea is strongest motivation to be called as an Entrepreneur. The interesting part of the journey has been leaving an established career to a new journey and finding the customer. The key mantra is for growth and strategy is continuous innovation.",
        "Swati has taken a lead in solving the real time Safety and security of workman and industrial assets using Artificial Intelligence and Deep Learning through her Startup Arcturus Business Solutions. A domain expert in India Power and Energy Sector she has held various leadership roles solving some real complex challenges. She is an Engineer and management postgraduate with formal flavour of Entrepreneurship education from Stanford Business School and University of California",
        "https://iiitd.ac.in/riise2022/assets/img/swatitiwari235.jpg",
        "Entrepreneurship - Finding Customers and Continuous Innovation",
        DateTime.now(),
        DateTime.now()),
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    Provider.of<EventProvider>(context, listen: false).fetchEventTracks(
      context,
      "PanelDiscussion",
    );
  }

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
          title: Text(
            "Pannel Discussion",
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
          padding: EdgeInsets.only(top: 280.h, left: 54.w, right: 54.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(top: 58.5.h),
                height: 210.6.h,
                child: TextField(
                  controller: searchBarController,
                  onChanged: (value) => {
                    setState(() {
                      filterValue = value;
                      print(filterValue);
                    })
                  },
                  decoration: InputDecoration(
                    hintText: "Search",
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xffebebeb),
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blue,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintStyle: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      fontSize: 45.sp,
                      fontStyle: FontStyle.normal,
                      color: Color(0xff6c757d),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        // setState(() {
                        //   recentSearch.insert(0, searchBarController.text);
                        //   if (recentSearch.length > 5) {
                        //     recentSearch.removeLast();
                        //   }
                        // });
                        print("serchpressed");
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 46.8.h,
              ),
              SizedBox(
                height: 46.8.h,
              ),
              Text(
                "KeyNote Speakers",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 46.8.h,
              ),
              Expanded(
                // padding: EdgeInsets.zero,
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: speakerList.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (isvalidFaculty(filterValue, index)) {
                      return SpeakerCard(speakerDetails: speakerList[index]);
                    } else {
                      return Container();
                    }
                  },
                ),
              )
            ],
          ),
        ));
  }

  bool isvalidFaculty(filterValue, index) {
    //TODO - use this when Dept is ready
    // return facultyProider.facultiesList[index].faculty_Name
    //     .toLowerCase()
    //      .contains(filterValue.toLowerCase()) && (facultyProider.facultiesList[index].faculty_Name
    //     .toLowerCase().compareTo(dropdownValue.toString()) == 0 || facultyProider.facultiesList[index].faculty_Name
    //     .toLowerCase().compareTo("ALL") == 0);

    return speakerList[index]
        .name
        .toLowerCase()
        .contains(filterValue.toLowerCase());
  }
}

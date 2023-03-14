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
import 'package:url_launcher/url_launcher.dart';

import '../../components/FacultyCard.dart';
import '../../components/SideNavBar.dart';
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

  late var facultyProider =
  Provider.of<FacultiesProvider>(context, listen: false);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    Provider.of<FacultiesProvider>(context, listen: false)
        .fetchCollegeFaculties(context);
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
              "Faculties",
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
                itemCount: Provider.of<FacultiesProvider>(context, listen: false).facultiesList.length,
                itemBuilder: (BuildContext context, int index) {
                  if (isvalidFaculty(filterValue, index)) {
                    return FacultyCard(
                      position: index,
                      facultyDetails: Provider.of<FacultiesProvider>(context, listen: false).facultiesList[index],
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            )
          ],
        ),
      )
    );
  }

  bool isvalidFaculty(filterValue, index) {
    //TODO - use this when Dept is ready
    // return facultyProider.facultiesList[index].faculty_Name
    //     .toLowerCase()
    //      .contains(filterValue.toLowerCase()) && (facultyProider.facultiesList[index].faculty_Name
    //     .toLowerCase().compareTo(dropdownValue.toString()) == 0 || facultyProider.facultiesList[index].faculty_Name
    //     .toLowerCase().compareTo("ALL") == 0);

    return facultyProider.facultiesList[index].faculty_Name
        .toLowerCase()
        .contains(filterValue.toLowerCase());
  }

}
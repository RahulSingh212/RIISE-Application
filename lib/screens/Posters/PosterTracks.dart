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

import '../../components/EventCard3.dart';
import '../../components/SideNavBar.dart';


import '../../providers/EventsProvider.dart';

class PosterTracksScreen extends StatefulWidget {
  static const routeName = '/rise-poster-tracks-screen';

  const PosterTracksScreen({super.key});

  @override
  State<PosterTracksScreen> createState() => _PosterTracksScreenState();
}

class _PosterTracksScreenState extends State<PosterTracksScreen> {

  loadData() async {
    await Provider.of<EventProvider>(context, listen: false).fetchEventTracks(context, "PosterTracks").then((value){
      setState(() {
      });
    });
  }

  @override
  void initState() {
    super.initState();
    // eventUtil = Provider.of<EventProvider>(context, listen: false);
    loadData();

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
          "Poster Tracks",
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
      body: Padding(
        padding: EdgeInsets.only(top: 220.h),
        child: ListView.builder(
          itemCount: Provider.of<EventProvider>(context, listen: false).posterTracksList.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: false,
          // physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(vertical: 83.h, horizontal: 20.w),
          itemBuilder: (context, position) {
            return Padding(
              padding: EdgeInsets.symmetric(
                  vertical: 50.5.h, horizontal: 60.w),
              child: EventCard3(eventDetails: Provider.of<EventProvider>(context, listen: false).posterTracksList[position],),
            );
          },
        ),
      )
    );
  }
}




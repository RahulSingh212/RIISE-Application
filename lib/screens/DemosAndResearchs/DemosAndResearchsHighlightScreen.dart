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

import '../../components/NewEventCard.dart';
import '../../components/SideNavBar.dart';
import '../../providers/EventsProvider.dart';

class DemosAndResearchHighlightScreen extends StatefulWidget {
  static const routeName = '/rise-demos-and-research-highlight-screen';

  const DemosAndResearchHighlightScreen({super.key});

  @override
  State<DemosAndResearchHighlightScreen> createState() =>
      _DemosAndResearchHighlightScreenState();
}

class _DemosAndResearchHighlightScreenState
    extends State<DemosAndResearchHighlightScreen> {
  bool isLoading = true;

  loadData() async {
    await Provider.of<EventProvider>(context, listen: false)
        .fetchEventTracks(context, "DemosAndResearchesHighlights")
        .then((value) async {
      setState(() {
        isLoading = false;
        print(
            "HEllo this is length of RND LIST -> ${Provider.of<EventProvider>(context, listen: false).demosAndResearchesHighlightsList.length}");
      });

      // List<EventServerInformation> list = await Provider.of<EventProvider>(context,listen: false).getEventList(context, "RNDShowcasesAndDemos");
      // print("List ->-> $list");
    });
  }

  @override
  void initState() {
    print("RND INIT CALLED");
    super.initState();
    loadData();
    // Provider.of<EventProvider>(context, listen: false).fetchEventTracks(context, "RNDShowcasesAndDemos");
  }

  @override
  Widget build(BuildContext context) {
    // var screenHeight = MediaQuery.of(context).size.height;
    // var screenWidth = MediaQuery.of(context).size.width;
    // var topInsets = MediaQuery.of(context).viewInsets.top;
    // var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    // var useableHeight = screenHeight - topInsets - bottomInsets;

    return isLoading
        ? Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            backgroundColor: Colors.white,
            extendBodyBehindAppBar: true,
            drawer: SideNavBar(),
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              title: Text(
                "Demos & Research Highlights",
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
                    padding:
                        EdgeInsets.only(top: 15.h, bottom: 25.h, right: 20.w),
                    child: Center(
                        child: Image.network(
                      "https://www.iiitd.ac.in/sites/default/files/images/logo/style1colorlarge.jpg",
                      fit: BoxFit.contain,
                    ))),
              ],
            ),
            body: Padding(
              padding: EdgeInsets.only(top: 220.h),
              child: ListView.builder(
                itemCount: Provider.of<EventProvider>(context)
                    .demosAndResearchesHighlightsList
                    .length,
                scrollDirection: Axis.vertical,
                shrinkWrap: false,
                // physics: NeverScrollableScrollPhysics(),
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(vertical: 83.h, horizontal: 20.w),
                itemBuilder: (context, position) {
                  return Container(
                    height: 1000.spMin,
                    // color: MediaQuery.of(context).size.width > 1080.w ? Colors.blue : Colors.orange,
                    padding: EdgeInsets.only(left: 86.w, right: 86.w, top: 80.h),
                    child: NewEventCard(
                      eventDetails: Provider.of<EventProvider>(context)
                          .demosAndResearchesHighlightsList[position],
                    ),
                  );
                },
              ),
            ),
          );
  }
}

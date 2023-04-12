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

import '../../components/SideNavBar.dart';
import '../../models/CoordinateInfo.dart';
import '../../providers/LocationProvider.dart';
import './ListOfListedLocationScreen.dart';
import 'CoordinationDetailScreen.dart';

class DirectionScreen extends StatefulWidget {
  static const routeName = '/rise-direction-screen';

  const DirectionScreen({super.key});

  @override
  State<DirectionScreen> createState() => _DirectionScreenState();
}

class _DirectionScreenState extends State<DirectionScreen> {

  loadData() async {
    await Provider.of<LocationProvider>(context, listen: false)
        .fetchLocationList(
      context,
    )
        .then((value) {
      setState(() {});
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //
  //   Provider.of<LocationProvider>(context, listen: false).fetchLocationList(
  //     context,
  //   );
  // }

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
          "Map",
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
      body: ListView.builder(
        itemCount: Provider.of<LocationProvider>(context, listen: false)
            .coordinateDirectionsList
            .length,
        itemBuilder: (ctx, index) {
          return coordinateDetailInfoWidget(
            context,
            Provider.of<LocationProvider>(context, listen: false)
                .coordinateDirectionsList[index],
          );
        },
      ),
      // floatingActionButton: SizedBox(
      //   child: FloatingActionButton.extended(
      //     onPressed: () {
      //       Navigator.of(context).push(
      //         MaterialPageRoute(
      //           builder: (context) => ListOfListedLocationScreen(),
      //         ),
      //       );
      //     },
      //     icon: Icon(
      //       Icons.directions,
      //     ),
      //     label: Text("Location List"),
      //   ),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget coordinateDetailInfoWidget(
    BuildContext context,
    CoordinateServerInformation coordinateDetails,
  ) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;
    var minDimension = min(screenWidth, screenHeight);
    var maxDimension = max(screenWidth, screenHeight);

    return InkWell(
      onTap: () {
        //   Navigator.of(context).push(
        //     MaterialPageRoute(
        //       builder: (context) => CoordinationDetailScreen(
        //         coordinateDetails: coordinateDetails,
        //       ),
        //     ),
        //   );
        _launchDirectionsUrl(
          coordinateDetails.coordinate_Latitude,
          coordinateDetails.coordinate_Longitude,
        );
      },
      child: Align(
        child: Card(
          elevation: 2.5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.5),
            // side: BorderSide(
            //   width: 5,
            //   color: Colors.green,
            // ),
          ),
          child: Container(
            width: screenWidth * 0.95,
            height: maxDimension * 0.125,
            padding: EdgeInsets.symmetric(
              horizontal: minDimension * 0.0125,
              vertical: maxDimension * 0.00625,
            ),
            margin: EdgeInsets.only(
              bottom: maxDimension * 0.0025,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white70,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: minDimension * 0.2,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/images/icons/location-icon.png',
                      ),
                    ),
                    // image: doctorDetails.doctor_ProfilePicUrl == ""
                    //     ? DecorationImage(
                    //         image: AssetImage(
                    //           'assets/images/surgeon.png',
                    //         ),
                    //         fit: BoxFit.fill,
                    //       )
                    //     : DecorationImage(
                    //         image:
                    //             NetworkImage(doctorDetails.doctor_ProfilePicUrl),
                    //         fit: BoxFit.fill,
                    //       ),
                    // border: Border.all(
                    //   color: Color.fromARGB(255, 233, 218, 218),
                    //   width: 1,
                    // ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: Text(
                          coordinateDetails.coordinate_Name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _launchDirectionsUrl(
    double latitude,
    double longitude,
  ) async {
    Uri url = Uri.parse(
        'https://www.google.com/maps/dir/?api=1&destination=$latitude,$longitude&travelmode=walking');

    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }
}

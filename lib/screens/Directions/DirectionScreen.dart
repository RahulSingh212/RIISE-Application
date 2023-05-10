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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // extendBodyBehindAppBar: true,
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
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("CoordinationInformation")
            .snapshots(),
        // initialData: initialData,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (ctx, index) {
                return coordinateDetailInfoWidget(
                  context,
                  new CoordinateServerInformation(
                    coordinate_Unique_Id: snapshot.data!.docs[index]
                        .data()['coordinate_Unique_Id'],
                    coordinate_Longitude: double.parse(snapshot
                        .data!.docs[index]
                        .data()['coordinate_Longitude']),
                    coordinate_Latitude: double.parse(snapshot.data!.docs[index]
                        .data()['coordinate_Latitude']),
                    coordinate_Name:
                        snapshot.data!.docs[index].data()['coordinate_Name'],
                    coordinate_Address:
                        snapshot.data!.docs[index].data()['coordinate_Address'],
                    coordinate_Code_Name: snapshot.data!.docs[index]
                        .data()['coordinate_Code_Name'],
                    coordinate_Landmark: snapshot.data!.docs[index]
                        .data()['coordinate_Landmark'],
                    Images_List:
                        snapshot.data!.docs[index].data()['Images_List'],
                  ),
                );
              },
            );
          }
        },
      ),
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
        _launchDirectionsUrl(
          coordinateDetails.coordinate_Latitude,
          coordinateDetails.coordinate_Longitude,
        );
      },
      child: Align(
        child: Card(
          elevation: 1.5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.5),
            // side: BorderSide(
            //   width: 5,
            //   color: Colors.green,
            // ),
          ),
          child: Container(
            width: screenWidth * 0.925,
            height: maxDimension * 0.175,
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: minDimension * 0.45,
                  height: minDimension * 0.35,
                  margin: EdgeInsets.only(right: 20),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(coordinateDetails.Images_List[0]),
                      fit: BoxFit.fill,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                Container(
                  width: screenWidth * 0.375,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        child: Text(
                          coordinateDetails.coordinate_Name,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.italic,
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(7.5),
                        decoration: BoxDecoration(
                          // color: Colors.greenAccent.shade100,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Icon(
                          Icons.location_on_outlined,
                          color: Colors.blue,
                          size: 35,
                        ),
                      ),

                      // Container(
                      //     child: Row(
                      //   mainAxisAlignment: MainAxisAlignment.end,
                      //   children: [
                      //     InkWell(
                      //       onTap: () {
                      //
                      //       },
                      //       child: Container(
                      //         padding: EdgeInsets.all(7.5),
                      //         decoration: BoxDecoration(
                      //             // color: Colors.greenAccent.shade100,
                      //             borderRadius: BorderRadius.circular(50)),
                      //         child: Icon(
                      //           Icons.location_on_outlined,
                      //           color: Colors.blue,
                      //           size: 50,
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // )),
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

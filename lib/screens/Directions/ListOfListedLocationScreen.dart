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
import 'package:riise/models/CoordinateInfo.dart';
import 'package:riise/providers/LocationProvider.dart';
import 'package:url_launcher/url_launcher.dart';

import "../../providers/LocationProvider.dart";
import 'CoordinationDetailScreen.dart';

class ListOfListedLocationScreen extends StatefulWidget {
  static const routeName = '/rise-list-of-listed-location-screen';

  const ListOfListedLocationScreen({super.key});

  @override
  State<ListOfListedLocationScreen> createState() =>
      _ListOfListedLocationScreenState();
}

class _ListOfListedLocationScreenState
    extends State<ListOfListedLocationScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    Provider.of<LocationProvider>(context, listen: false).fetchLocationList(
      context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        // backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Listed Locations",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 60.sp,
          ),
          textAlign: TextAlign.center,
        ),
        // iconTheme: IconThemeData(
        //   color: Colors.blue,
        //   size: 80.r,
        // ),
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
        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (context) => CoordinationDetailScreen(
        //       coordinateDetails: coordinateDetails,
        //     ),
        //   ),
        // );
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
            height: maxDimension * 0.15,
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
                  width: minDimension * 0.25,
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

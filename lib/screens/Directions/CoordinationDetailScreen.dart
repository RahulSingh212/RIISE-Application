// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, unused_import, unnecessary_import, duplicate_import, unused_local_variable, deprecated_member_use, file_names, must_be_immutable

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
import 'package:url_launcher/url_launcher.dart';

class CoordinationDetailScreen extends StatefulWidget {
  static const routeName = '/rise-coordination-detail-screen';

  CoordinationDetailScreen({
    Key? key,
    required this.coordinateDetails,
  }) : super(key: key);

  // late int position;
  late CoordinateServerInformation coordinateDetails;

  @override
  State<CoordinationDetailScreen> createState() =>
      _CoordinationDetailScreenState();
}

class _CoordinationDetailScreenState extends State<CoordinationDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.coordinateDetails.coordinate_Name,
        ),
      ),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 10,
            ),
            // child: ListView.builder(
            //   // itemCount: themes.getThemesList().length,
            //   itemCount: widget.coordinateDetails.Images_List.length,
            //   scrollDirection: Axis.horizontal,
            //   physics: BouncingScrollPhysics(),
            //   padding: EdgeInsets.symmetric(
            //     vertical: 23.h,
            //     horizontal: 21.w,
            //   ),
            //   itemBuilder: (context, position) {
            //     return Card(
            //       elevation: 1.5,
            //       child: Container(

            //         decoration: BoxDecoration(
            //           image: DecorationImage(
            //             image: NetworkImage(
            //               widget.coordinateDetails.Images_List[position],
            //             ),
            //           ),
            //         ),
            //       ),
            //     );
            //   },
            // ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _launchDirectionsUrl();
        },
        backgroundColor: const Color.fromARGB(255, 63, 173, 168),
        splashColor: Colors.yellow,
        label: Text(
            "Get Directions to ${widget.coordinateDetails.coordinate_Name}"),
        icon: const Icon(
          Icons.arrow_circle_right_outlined,
          size: 40.0,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        elevation: 10.0,
      ),
    );
  }

  Future<void> _launchDirectionsUrl() async {
    Uri url = Uri.parse(
        'https://www.google.com/maps/dir/?api=1&destination=${widget.coordinateDetails.coordinate_Latitude},${widget.coordinateDetails.coordinate_Longitude}&travelmode=walking');

    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }
}

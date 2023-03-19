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
  final EventTitle = [
    'Welcome Tea/ Coffee',
    'Inauguration',
    'Artificial Intelligence (Speaker Track)',
    'Artificial Intelligence (Poster Track)',
    'Sustainability (Speaker Track)',
    'Technology as a Public Good	 (Poster Track)',
    'Healthcare (Speaker Track)',
    'Core Research (Poster Track)',
    'Design (Speaker Track)',
    'Cyberphysical Systems	 (Poster Track)',
    'Lunch',
    'Artificial Intelligence (Speaker Track)',
    'Artificial Intelligence (Poster Track)',
    'Technology as a Public Good (Speaker Track)',
    'Sustainability	 (Poster Track)',
    'Core Research (Speaker Track)',
    'Healthcare (Poster Track)',
    'Cyberphysical Systems (Speaker Track)',
    'Design	 (Poster Track)'
  ];

  final EventSubtitle = [
    "Time - 9:00 AM to 9:15 AM \nLocation - Ground Floor, RnD Block",
    "Time - 9:15 AM to	9:25 AM \nLocation - A007, Ground Floor, RnD Block",
    "Time - 9:35 AM to 11:55 AM \nLocation - A007, RnD Block",
    "Time - 9:35 AM to 11:55 AM \nLocation - 5th Floor, RnD Block",
    "Time - 9:35 AM to 11:55 AM \nLocation - A006, RnD Block",
    "Time - 9:35 AM to 11:55 AM \nLocation - B-Wing, 6th Floor, RnD Block",
    "Time - 9:35 AM to 11:55 AM \nLocation - A106, RnD Block",
    "Time - 9:35 AM to 11:55 AM \nLocation - B-Wing, 3rd and 4th Floor, RnD Block",
    "Time - 9:35 AM to 11:55 AM \nLocation - B105, RnD Block",
    "Time - 9:35 AM to 11:55 AM \nLocation - A-Wing, 6th Floor, RnD Block",
    "Time - 1:00 PM to	2:00 PM \nLocation - Ground Floor, RnD Block",
    "Time - 2:05 PM to	4:15 PM \nLocation - A007, RnD Block",
    "Time - 2:05 PM to	4:15 PM \nLocation - 5th Floor, RnD Block",
    "Time - 2:05 PM to	4:15 PM \nLocation - A006, RnD Block",
    "Time - 2:05 PM to	4:15 PM \nLocation - 2nd Floor, RnD Block",
    "Time - 2:05 PM to	4:15 PM \nLocation - A106, RnD Block",
    "Time - 2:05 PM to	4:15 PM \nLocation - 3rd and 4th Floor, RnD Block",
    "Time - 2:05 PM to	4:15 PM \nLocation - B105, RnD Block",
    "Time - 2:05 PM to	4:15 PM \nLocation - A-Wing, 4th Floor, RnD Block"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.coordinateDetails.coordinate_Name,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SizedBox(
          height: 670.0,
          child: ListView.builder(
            padding: const EdgeInsets.all(5.0),
            itemCount: EventTitle.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                elevation: 8.0,
                shadowColor: const Color.fromARGB(255, 63, 173, 168),
                child: ListTile(
                  title: Text(
                    EventTitle[index],
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  leading: Text(
                    (index + 1).toString(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(EventSubtitle[index]),
                  isThreeLine: true,
                  onTap: () {},
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _launchDirectionsUrl();
        },
        backgroundColor: const Color.fromARGB(255, 63, 173, 168),
        splashColor: Colors.yellow,
        label: Text("Get Directions to ${widget.coordinateDetails.coordinate_Name}"),
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

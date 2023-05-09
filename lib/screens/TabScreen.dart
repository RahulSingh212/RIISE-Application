// ignore_for_file: unused_import, unused_field, prefer_final_fields, unused_element, unused_local_variable, file_names, deprecated_member_use, unnecessary_string_interpolations, unnecessary_brace_in_string_interps, avoid_unnecessary_containers

import 'dart:async';

import 'dart:math';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis_auth/auth.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart';
import 'package:new_version/new_version.dart';
import 'package:provider/provider.dart';
import 'package:riise/main.dart';
import 'package:riise/models/FacultyInfo.dart';
import 'package:riise/providers/DynamicLinkProvider.dart';
import 'package:riise/providers/UserDetailsProvider.dart';
import 'package:riise/providers/UserLoginProvider.dart';
import 'package:riise/screens/Faculty/FacultyDetailScreen.dart';
import 'package:riise/screens/QrCode/QrCodeGenerator.dart';
import 'package:riise/screens/ScannerScreen/QRCodeScannerScreen.dart';

import '../models/EventInfo.dart';
import '../providers/CalendarAPI.dart';
import '../providers/EventsProvider.dart';
import '../providers/FacultiesProvider.dart';
import '../providers/LocationProvider.dart';
import '../providers/ThemeProvider.dart';
import "./Home/HomeScreen.dart";
import "./Faculty/FacultyScreen.dart";
import "./Schedules/ScheduleScreen.dart";
import "./Appointments/AppointmentScreen.dart";
import "./Directions/DirectionScreen.dart";
import "../providers/ScreenControllerProvider.dart";
import 'package:googleapis/calendar/v3.dart' as cal;
import 'package:http/http.dart' as http;

class TabScreen extends StatefulWidget {
  static const routeName = '/rise-tab-screen';

  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen>
    with SingleTickerProviderStateMixin {
  late List<Map<String, Object>> _pages;

  late final AnimationController _controller;
  late final Animation<double> _animation;

  final _appScreens = [
    const HomeScreen(),
    const FacultyScreen(),
    const ScheduleScreen(),
    const DirectionScreen(),
    const AppointmentScreen(),
    // const QRCodeScannerScreen(),
  ];

  final FirebaseAuth _auth = FirebaseAuth.instance;

  

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
    _animation = Tween<double>(
      begin: 0,
      end: pi * 2,
    ).animate(_controller);

    _pages = [
      {
        'page': HomeScreen(),
        'title': 'Home',
      },
      {
        'page': FacultyScreen(),
        'title': 'Faculties',
      },
      {
        'page': ScheduleScreen(),
        'title': 'Schedules',
      },
      {
        'page': DirectionScreen(),
        'title': 'Directions',
      },
      {
        'page': AppointmentScreen(),
        'title': 'Appointments',
      },
      // {
      //   'page': QRCodeScannerScreen(),
      //   'title': 'QR Scanner',
      // },
    ];

    Future.delayed(Duration.zero, () async {
      final initialLink = DynamicLinkProvider.initialLink;

      print("Final Dynamic Link = $initialLink");

      if (initialLink != null) {
        final Uri deepLink = initialLink.link;

        FacultyServerInformation faculty =
            await Provider.of<FacultiesProvider>(context, listen: false)
                .getFacultyDetails(deepLink.path);
        // Example of using the dynamic link to push the user to a different screen
        DynamicLinkProvider.initialLink = null;
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => FacultyDetailScreen(
              facultyDetails: faculty,
            ),
          ),
        );
      }
    });
  }

  void _selectPage(int index) {
    setState(() {
      Provider.of<ScreenControllerProvider>(context, listen: false)
          .selectedPageIndex = index;
      Provider.of<ScreenControllerProvider>(context, listen: false)
          .selectedPageIndex = index;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final iconItemsInActive = <Widget>[
      Icon(
        Icons.home_outlined,
        color: Colors.green,
        size: 80.r,
      ),
      Icon(
        Icons.person_search_outlined,
        color: Colors.green,
        size: 80.r,
      ),
      Icon(
        Icons.access_time_outlined,
        color: Colors.green,
        size: 80.r,
      ),
      Icon(
        Icons.map_outlined,
        color: Colors.green,
        size: 80.r,
      ),
      Icon(
        Icons.meeting_room_outlined,
        color: Colors.green,
        size: 80.r,
      ),
      // Icon(
      //   Icons.qr_code_scanner_outlined,
      //   color: Colors.green,
      //   size: 80.r,
      // ),
    ];

    final iconItemsActive = <Widget>[
      Icon(
        Icons.home_rounded,
        color: Colors.green,
        size: 80.r,
      ),
      Icon(
        Icons.person_search_rounded,
        color: Colors.green,
        size: 80.r,
      ),
      Icon(
        Icons.access_time,
        color: Colors.green,
        size: 80.r,
      ),
      Icon(
        Icons.map_rounded,
        color: Colors.green,
        size: 80.r,
      ),
      Icon(
        Icons.meeting_room_rounded,
        color: Colors.green,
        size: 80.r,
      ),
      // Icon(
      //   Icons.qr_code_scanner_rounded,
      //   color: Colors.green,
      //   size: 80.r,
      // ),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: IndexedStack(
        index: Provider.of<ScreenControllerProvider>(context, listen: false)
            .selectedPageIndex,
        children: _appScreens,
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          backgroundColor: const Color(0xff42ccc3),
        ),
        child: CurvedNavigationBar(
          onTap: _selectPage,
          backgroundColor: Colors.transparent,
          color: Colors.greenAccent,
          buttonBackgroundColor: Colors.blueGrey,
          index: Provider.of<ScreenControllerProvider>(
            context,
            listen: false,
          ).selectedPageIndex,
          height: 163.8.h,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(
            milliseconds: 300,
          ),
          items: iconItemsActive,
        ),
      ),
    );
  }

  Future<void> _checkForLogout(
      BuildContext context, String titleText, String contextText,
      {bool popVal = false}) async {
    // var screenHeight = MediaQuery.of(context).size.height;
    // var screenWidth = MediaQuery.of(context).size.width;
    // var topInsets = MediaQuery.of(context).viewInsets.top;
    // var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    // var useableHeight = screenHeight - topInsets - bottomInsets;

    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('${titleText}'),
        content: Text('${contextText}'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.dangerous_rounded,
              color: Color(0xff42ccc3),
            ),
            iconSize: 130.r,
            color: Colors.brown,
            onPressed: () {
              setState(() {
                if (popVal == false) {
                  Navigator.pop(ctx);
                }
              });
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.check_circle_rounded,
              color: Color(0xff42ccc3),
            ),
            iconSize: 130.r,
            color: Colors.brown,
            onPressed: () {
              setState(() {
                if (popVal == false) {
                  Navigator.pop(ctx);
                  // _auth.signOut();
                  // Navigator.of(context).pushNamedAndRemoveUntil(
                  //     SelectLanguageScreenPatient.routeName, (route) => false);
                }
              });
            },
          ),
        ],
      ),
    );
  }

  Future<void> _checkForError(
      BuildContext context, String titleText, String contextText,
      {bool popVal = false}) async {
    // var screenHeight = MediaQuery.of(context).size.height;
    // var screenWidth = MediaQuery.of(context).size.width;
    // var topInsets = MediaQuery.of(context).viewInsets.top;
    // var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    // var useableHeight = screenHeight - topInsets - bottomInsets;

    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('${titleText}'),
        content: Text('${contextText}'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.check_circle_rounded,
              color: Color(0xff42ccc3),
            ),
            iconSize: 130.r,
            color: Colors.brown,
            onPressed: () {
              setState(() {
                if (popVal == false) {
                  Navigator.pop(ctx);
                }
              });
            },
          ),
        ],
      ),
    );
  }
}

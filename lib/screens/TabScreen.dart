// ignore_for_file: unused_import, unused_field, prefer_final_fields, unused_element, unused_local_variable, file_names, deprecated_member_use, unnecessary_string_interpolations, unnecessary_brace_in_string_interps, avoid_unnecessary_containers

import 'dart:async';
import 'dart:math';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import "./Home/HomeScreen.dart";
import "./Faculty/FacultyScreen.dart";
import "./Schedules/ScheduleScreen.dart";
import "./Appointments/AppointmentScreen.dart";
import "./Directions/DirectionScreen.dart";

class TabScreen extends StatefulWidget {
  static const routeName = '/rise-tab-screen';

  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  late List<Map<String, Object>> _pages;
  int _selectedPageIndex = 0;

  final _appScreens = [
    const HomeScreen(),
    const FacultyScreen(),
    const ScheduleScreen(),
    const DirectionScreen(),
    const AppointmentScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _pages = [
      {
        'page': const HomeScreen(),
        'title': 'Home',
      },
      {
        'page': const FacultyScreen(),
        'title': 'Faculties',
      },
      {
        'page': const ScheduleScreen(),
        'title': 'Schedules',
      },
      {
        'page': const DirectionScreen(),
        'title': 'Directions',
      },
      {
        'page': const AppointmentScreen(),
        'title': 'Appointments',
      },
    ];
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;

    final iconItemsInActive = <Widget>[
      const Icon(
        Icons.home_outlined,
        color: Colors.green,
        size: 30,
      ),
      const Icon(
        Icons.person_search_outlined,
        color: Colors.green,
        size: 30,
      ),
      const Icon(
        Icons.access_time_outlined,
        color: Colors.green,
        size: 30,
      ),
      const Icon(
        Icons.location_on_outlined,
        color: Colors.green,
        size: 30,
      ),
      const Icon(
        Icons.meeting_room_outlined,
        color: Colors.green,
        size: 30,
      ),
    ];

    final iconItemsActive = <Widget>[
      const Icon(
        Icons.home_rounded,
        color: Color(0xff42ccc3),
        size: 30,
      ),
      const Icon(
        Icons.person_search_rounded,
        color: Color(0xff42ccc3),
        size: 30,
      ),
      const Icon(
        Icons.access_time,
        color: Color(0xff42ccc3),
        size: 30,
      ),
      const Icon(
        Icons.location_pin,
        color: Color(0xff42ccc3),
        size: 30,
      ),
      const Icon(
        Icons.meeting_room_rounded,
        color: Color(0xff42ccc3),
        size: 30,
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: IndexedStack(
        index: _selectedPageIndex,
        children: _appScreens,
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: const Color(0xff42ccc3),
        ),
        child: CurvedNavigationBar(
          onTap: _selectPage,
          backgroundColor: Colors.transparent,
          color: Colors.greenAccent,
          // buttonBackgroundColor: Theme.of(context).primaryColor,
          buttonBackgroundColor: Colors.blueGrey,
          index: 0,
          height: screenHeight * 0.070,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 300),
          items: iconItemsInActive,
        ),
      ),
    );
  }

  Future<void> _checkForLogout(
      BuildContext context, String titleText, String contextText,
      {bool popVal = false}) async {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;

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
            iconSize: 50,
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
            iconSize: 50,
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

  // Widget sideMenuBar(BuildContext context) {
  //   return Padding(
  //     padding: const EdgeInsets.only(
  //       left: 10,
  //     ),
  //     child: Align(
  //       alignment: Alignment.centerLeft,
  //       child: Column(
  //         mainAxisSize: MainAxisSize.min,
  //         mainAxisAlignment: MainAxisAlignment.spaceAround,
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: const [
  //           Text(
  //             "Home",
  //             style: TextStyle(
  //               color: Colors.white,
  //               fontSize: 20,
  //             ),
  //           ),
  //           SizedBox(
  //             height: 10,
  //           ),
  //           Text(
  //             "Faculty",
  //             style: TextStyle(
  //               color: Colors.white,
  //               fontSize: 20,
  //             ),
  //           ),
  //           SizedBox(
  //             height: 10,
  //           ),
  //           Text(
  //             "Schedule",
  //             style: TextStyle(
  //               color: Colors.white,
  //               fontSize: 20,
  //             ),
  //           ),
  //           SizedBox(
  //             height: 10,
  //           ),
  //           Text(
  //             "Locations",
  //             style: TextStyle(
  //               color: Colors.white,
  //               fontSize: 20,
  //             ),
  //           ),
  //           SizedBox(
  //             height: 10,
  //           ),
  //           Text(
  //             "Appointments",
  //             style: TextStyle(
  //               color: Colors.white,
  //               fontSize: 20,
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Future<void> _checkForError(
      BuildContext context, String titleText, String contextText,
      {bool popVal = false}) async {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;

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
            iconSize: 50,
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

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
// import 'package:googleapis/calendar/v3.dart';
// import 'package:googleapis/calendar/v3.dart';
// import 'package:googleapis/calendar/v3.dart';
import 'package:googleapis_auth/auth.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:riise/main.dart';
import 'package:riise/models/FacultyInfo.dart';
import 'package:riise/providers/DynamicLinkProvider.dart';
import 'package:riise/providers/UserLoginProvider.dart';
import 'package:riise/screens/Faculty/FacultyDetailScreen.dart';
import 'package:riise/screens/QrCode/QrCodeGenerator.dart';

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

class _TabScreenState extends State<TabScreen> {
  late List<Map<String, Object>> _pages;

  final _appScreens = [
    const HomeScreen(),
    const FacultyScreen(),
    const ScheduleScreen(),
    const DirectionScreen(),
    const AppointmentScreen(),
  ];

  bool isLoading = true;

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //
  //   // Provider.of<ThemeProvider>(
  //   //   context,
  //   //   listen: false,
  //   // ).fetchThemes(
  //   //   context,
  //   // );
  //
  //   // print("tab screen");
  //   // Provider.of<FacultiesProvider>(
  //   //   context,
  //   //   listen: false,
  //   // ).fetchCollegeFaculties(
  //   //   context,
  //   // );
  //   // Provider.of<LocationProvider>(
  //   //   context,
  //   //   listen: false,
  //   // ).fetchLocationList(
  //   //   context,
  //   // );
  // }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<EventServerInformation> eventUtil = [];

  load() async {
    // await Provider.of<ThemeProvider>(
    //   context,
    //   listen: false,
    // ).fetchThemes(context);

    print("Hello there loading started");
    // print("EMAIL -> ${FirebaseAuth.instance.currentUser?.refreshToken}");
    print(isLoading);
    // TODO - Add Event Provider fetch

    await Provider.of<EventProvider>(context, listen: false)
        .fetchEventTracks(context, "StartUpShowcase")
        .then((value) async {
      await Provider.of<EventProvider>(context, listen: false)
          .fetchEventTracks(context, "RNDShowcasesAndDemos")
          .then((value) async {
        await Provider.of<EventProvider>(context, listen: false)
            .fetchEventTracks(context, "ResearchShowcases")
            .then((Value) async {
          await Provider.of<EventProvider>(context, listen: false)
              .fetchEventTracks(context, "ForwardLookingPanels")
              .then((value) async {
            await Provider.of<EventProvider>(context, listen: false)
                .fetchEventTracks(context, "DemosAndResearchesHighlights")
                .then((value) async {
              await Provider.of<EventProvider>(context, listen: false)
                  .fetchEventTracks(context, "BeyondCollegePanels")
                  .then((value) async {
                await Provider.of<FacultiesProvider>(context, listen: false)
                    .fetchCollegeFaculties(context)
                    .then((value) async {
                  print("Faculty loading finished");
                  await Provider.of<LocationProvider>(context, listen: false)
                      .fetchLocationList(
                    context,
                  )
                      .then((value) async {
                    await Provider.of<CalenderAPI>(context, listen: false)
                        .fetchEvent(context)
                        .then((value) {
                      setState(() {
                        isLoading = false;
                        print("Hello there loading finished");
                        print(isLoading);
                      });
                    });
                  });
                });
              });
            });
          });
        });
      });
    });
  }

  @override
  void initState() {
    super.initState();

    // final initialLink = Provider.of<DynamicLinkProvider>(context,listen: false).initialLink;

    // initializeCalendar();
    print("initState TABSCREEN");

    _pages = [
      {
        'page': HomeScreen(),
        'title': 'Home',
      },
      {
        'page': FacultyScreen(),
        'title': 'Faculties',
        'fetch': Provider.of<FacultiesProvider>(
          context,
          listen: false,
        ).fetchCollegeFaculties(
          context,
        ),
      },
      {
        'page': ScheduleScreen(),
        'title': 'Schedules',
      },
      {
        'page': DirectionScreen(),
        'title': 'Directions',
        'fetch': Provider.of<FacultiesProvider>(
          context,
          listen: false,
        ).fetchCollegeFaculties(
          context,
        ),
      },
      {
        'page': AppointmentScreen(),
        'title': 'Appointments',
      },
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
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                FacultyDetailScreen(facultyDetails: faculty)));
      }
    });
    load();
  }

  void _selectPage(int index) {
    // setState(() {
    //   if (index == 0) {
    //   } else if (index == 1) {
    //     Provider.of<FacultiesProvider>(
    //       context,
    //       listen: false,
    //     ).fetchCollegeFaculties(
    //       context,
    //     );
    //   } else if (index == 2) {
    //   } else if (index == 3) {
    //     Provider.of<LocationProvider>(
    //       context,
    //       listen: false,
    //     ).fetchLocationList(
    //       context,
    //     );
    //   } else if (index == 4) {}
    // });

    setState(() {
      Provider.of<ScreenControllerProvider>(context, listen: false)
          .selectedPageIndex = index;
    });
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
    ];

    print("Loading : $isLoading");

    return isLoading
        ? Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: Image.asset("assets/images/Riise.png"),
            ))
        : Scaffold(
            backgroundColor: Colors.white,
            body: IndexedStack(
              index:
                  Provider.of<ScreenControllerProvider>(context, listen: false)
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
                // buttonBackgroundColor: Theme.of(context).primaryColor,
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

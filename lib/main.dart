// ignore_for_file: unnecessary_this, use_key_in_widget_constructors, unused_field, prefer_final_fields, prefer_const_constructors, use_build_context_synchronously, deprecated_member_use, prefer_const_literals_to_create_immutables, unused_import, must_be_immutable, unused_local_variable, duplicate_import, unused_element, unnecessary_import, no_leading_underscores_for_local_identifiers

import 'dart:async';
import 'dart:math';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import "package:flutter/services.dart";
import 'package:riise/providers/CalendarAPI.dart';
import 'package:riise/providers/DynamicLinkProvider.dart';
import 'package:riise/screens/Faculty/FacultyDetailScreen.dart';
import 'package:riise/screens/QrCode/QrCodeGenerator.dart';

import "./screens/TabScreen.dart";
import './screens/Home/HomeScreen.dart';
import "./screens/Faculty/FacultyScreen.dart";
import "./screens/Schedules/ScheduleScreen.dart";
import "./screens/Directions/DirectionScreen.dart";
import "./screens/Appointments/AppointmentScreen.dart";
import './screens/SingInScreen/LogInSignUpScreen.dart';
import "./screens/ScannerScreen/QRCodeScannerScreen.dart";

import "./providers/FirebaseProvider.dart";
import "./providers/FacultiesProvider.dart";
import "./providers/EventsProvider.dart";
import './providers/UserDetailsProvider.dart';
import './providers/UserLoginProvider.dart';
import './providers/AddSectionsProvider.dart';
import './providers/ScreenControllerProvider.dart';
import './providers/LocationProvider.dart';
import './providers/PanelDiscussionProvider.dart';
import './providers/ThemeProvider.dart';
import 'models/FacultyInfo.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await Firebase.initializeApp();

  final PendingDynamicLinkData? initialLink =
      await FirebaseDynamicLinks.instance.getInitialLink();
  DynamicLinkProvider.initialLink = initialLink;

  FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
    FacultyServerInformation faculty = FacultyServerInformation(
        faculty_Unique_Id: "null",
        faculty_Authorization: false,
        faculty_Mobile_Messaging_Token_Id: "null",
        faculty_Name: "null",
        faculty_Position: "null",
        faculty_College: "null",
        faculty_Department: "null",
        faculty_Mobile_Number: "null",
        faculty_Teaching_Interests: "null",
        faculty_Research_Interests: "null",
        faculty_Affiliated_Centers_And_Labs: "null",
        faculty_EmailId: "null",
        faculty_Gender: "null",
        faculty_Bio: "null",
        faculty_Image_Url: "null",
        faculty_LinkedIn_Url: "null",
        faculty_Website_Url: "null",
        faculty_Office_Navigation_Url: "null",
        faculty_Office_Address: "null",
        faculty_Office_Longitude: 0,
        faculty_Office_Latitude: 0);
    // Example of using the dynamic link to push the user to a different screen
    navigatorKey.currentState?.push(MaterialPageRoute(
        builder: (context) => FacultyDetailScreen(
              facultyDetails: faculty,
              qrIdentifier: dynamicLinkData.link.path,
            )));
  }).onError((error) {
    // Handle errors
  });

  runApp(
    ScreenUtilInit(
      builder: (BuildContext context, Widget? child) => MaterialApp(
        home: MyApp(),
      ),
      designSize: const Size(1080, 2340),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    late UserCredential userCred;
    final _auth = FirebaseAuth.instance;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: CalenderAPI()),
        ChangeNotifierProvider.value(value: ScreenControllerProvider()),
        ChangeNotifierProvider.value(
          value: FirebaseProvider(),
        ),
        ChangeNotifierProvider.value(
          value: UserLoginProvider(),
        ),
        ChangeNotifierProvider.value(
          value: UserDetailsProvider(),
        ),
        ChangeNotifierProvider.value(
          value: FacultiesProvider(),
        ),
        ChangeNotifierProvider.value(
          value: ThemeProvider(),
        ),
        ChangeNotifierProvider.value(
          value: PanelDiscussionProvider(),
        ),
        ChangeNotifierProvider.value(
          value: EventProvider(),
        ),
        ChangeNotifierProvider.value(
          value: AddSectionsProvider(),
        ),
        ChangeNotifierProvider.value(
          value: LocationProvider(),
        ),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'RIISE',
        theme: ThemeData(
          primaryColor: const Color(0xFFfbfcff),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          canvasColor: Color.fromRGBO(255, 254, 229, 0.9),
          hoverColor: Colors.transparent,
          fontFamily: 'Raleway',
          textTheme: ThemeData.light().textTheme.copyWith(
                bodyText1: const TextStyle(
                  color: Color.fromRGBO(20, 51, 51, 1),
                ),
                bodyText2: const TextStyle(
                  color: Color.fromRGBO(20, 51, 51, 1),
                ),
                headline6: const TextStyle(
                  fontSize: 18,
                  fontFamily: 'RobotoCondensed',
                  fontWeight: FontWeight.bold,
                ),
              ),
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.blue,
          ).copyWith(
            secondary: Color.fromARGB(255, 84, 83, 77),
          ),
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (ctx, userSnapShot) {
            if (userSnapShot.hasData) {
              return TabScreen();
            } else {
              return TabScreen();
            }
          },
        ),
        routes: {
          TabScreen.routeName: (ctx) => TabScreen(),
          HomeScreen.routeName: (ctx) => HomeScreen(),
          FacultyScreen.routeName: (ctx) => FacultyScreen(),
          ScheduleScreen.routeName: (ctx) => ScheduleScreen(),
          DirectionScreen.routeName: (ctx) => DirectionScreen(),
          AppointmentScreen.routeName: (ctx) => AppointmentScreen(),
          QRCodeScannerScreen.routeName: (ctx) => QRCodeScannerScreen(),
        },
      ),
    );
  }
}

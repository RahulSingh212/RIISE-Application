// ignore_for_file: unnecessary_this, use_key_in_widget_constructors, unused_field, prefer_final_fields, prefer_const_constructors, use_build_context_synchronously, deprecated_member_use, prefer_const_literals_to_create_immutables, unused_import, must_be_immutable, unused_local_variable, duplicate_import, unused_element, unnecessary_import, no_leading_underscores_for_local_identifiers

import 'dart:async';
import 'dart:math';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "package:flutter/services.dart";

import "./screens/TabScreen.dart";
import './screens/Home/HomeScreen.dart';
import "./screens/Faculty/FacultyScreen.dart";
import "./screens/Schedules/ScheduleScreen.dart";
import "./screens/Directions/DirectionScreen.dart";
import "./screens/Appointments/AppointmentScreen.dart";

import "./providers/FirebaseProvider.dart";
import "./providers/EventsProvider.dart";
import './providers/ScreenControllerProvider.dart';
import './providers/AddSectionsProvider.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await Firebase.initializeApp();

  runApp(
    MaterialApp(
      home: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    late UserCredential userCred;
    final _auth = FirebaseAuth.instance;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: FirebaseProvider(),
        ),
        ChangeNotifierProvider.value(
          value: ScreenControllerProvider(),
        ),
        ChangeNotifierProvider.value(
          value: EventProvider(),
        ),
        ChangeNotifierProvider.value(
          value: AddSectionsProvider(),
        ),
      ],
      child: MaterialApp(
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
          stream: _auth.authStateChanges(),
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
        },
      ),
    );
  }
}

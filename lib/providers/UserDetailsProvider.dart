// ignore_for_file: file_names, unused_import, avoid_print, use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:riise/screens/TabScreen.dart';
import 'FirebaseProvider.dart';

class UserDetailsProvider with ChangeNotifier {
  Future<void> uploadInformationOfNewFaculty(
    BuildContext context,
    String loggedInUserUniqueId,
    String userName,
    String userEmailId,
  ) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference usersRef = db.collection("FacultiesInformationList");

    try {
      await usersRef.doc(loggedInUserUniqueId).set(
        {
          "faculty_Unique_Id": loggedInUserUniqueId,
          "faculty_Mobile_Messaging_Token_Id": "",
          "faculty_Name": userName,
          "faculty_Position": "",
          "faculty_College": "",
          "faculty_Mobile_Number": "",
          "faculty_Research_Interests": "",
          "faculty_Affiliated_Centers_And_Labs": "",
          "faculty_EmailId": userEmailId,
          "faculty_Gender": "",
          "faculty_Bio": "",
          "faculty_Image_Url": "",
          "faculty_LinkedIn_Url": "",
          "faculty_Website_Url": "",
          "faculty_Office_Address": "",
          "faculty_Office_Longitude": "",
          "faculty_Office_Latitude": "",
        },
      );

      Navigator.of(context).pushNamedAndRemoveUntil(
        TabScreen.routeName,
        (route) => false,
      );
    } catch (errorVal) {
      print(errorVal);
    }
  }

  Future<void> uploadInformationOfNewGuest(
    BuildContext context,
    String loggedInUserUniqueId,
    String userName,
    String userEmailId,
  ) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference usersRef = db.collection("GuestsInformationList");

    try {
      await usersRef.doc(loggedInUserUniqueId).set({
        "guest_Unique_Id": loggedInUserUniqueId,
        "guest_Mobile_Messaging_Token_Id": "",
        "guest_Name": "",
        "guest_EmailId": "",
        "guest_Mobile_Number": "",
        "guest_Gender": "",
        "guest_LinkedIn_Url": "",
        "guest_Bio": "",
        "guest_Research_Interests": "",
      });

      Navigator.of(context).pushNamedAndRemoveUntil(
        TabScreen.routeName,
        (route) => false,
      );
    } catch (errorVal) {
      print(errorVal);
    }
  }
}

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

const FACULTY_USERTYPE = "Faculty";
const GUEST_USERTYPE = "Guest";
const FACULTY_COLLECTION_NAME = "FacultiesInformationList";
const GUEST_COLLECTION_NAME = "GuestsInformationList";

class UserDetailsProvider with ChangeNotifier {
  String userType = "Faculty";

  Map<String, String> userMapping = {
    'faculty_Unique_Id': '',
    'faculty_Authorization': '',
    'faculty_Name': "",
    'faculty_EmailId': "",
    'faculty_Department': '',
    'faculty_Position': '',
    'faculty_Gender': '',
    'faculty_Affiliated_Centers_And_Labs': '',
    'faculty_Bio': '',
    'faculty_College': '',
    'faculty_Image_Url': "",
    'faculty_LinkedIn_Url': '',
    'faculty_Website_Url': '',
    'faculty_Mobile_Messaging_Token_Id': '',
    'faculty_Mobile_Number': "",
    'faculty_Office_Address': '',
    'faculty_Office_Latitude': '',
    'faculty_Office_Longitude': '',
    'faculty_Office_Navigation_Url': '',
    'faculty_Research_Interests': '',
    'faculty_Teaching_Interests': '',
    'faculty_Dynamic_Links': '',
    'faculty_Website_Page': '',
    'faculty_QR_Code_Image_Url': "",
    "faculty_Google_Auth_Token_Id": "",
    "guest_Unique_Id": "",
    "guest_Mobile_Messaging_Token_Id": "",
    "guest_Google_Auth_Token_Id": "",
    "guest_Name": "",
    "guest_EmailId": "",
    "guest_Mobile_Number": "",
    "guest_Gender": "",
    "guest_LinkedIn_Url": "",
    "guest_Image_Url": "",
    "guest_Bio": "",
    "guest_Research_Interests": "",
  };

  Future<void> fetchFacultyProfile(
    BuildContext context,
  ) async {
    var currLoggedInUser = FirebaseAuth.instance.currentUser;
    var userEmailId = currLoggedInUser?.email as String;

    await FirebaseFirestore.instance
        .collection(FACULTY_COLLECTION_NAME)
        // .doc(facultyDatabaseUniqueId)
        .doc(userEmailId)
        .get()
        .then((DocumentSnapshot ds) {
      userMapping['faculty_Unique_Id'] = ds.get('faculty_Unique_Id').toString();
      userMapping['faculty_Authorization'] = ds.get('faculty_Authorization').toString();
      userMapping['faculty_Name'] = ds.get('faculty_Name').toString();
      userMapping['faculty_EmailId'] = ds.get('faculty_EmailId').toString();
      userMapping['faculty_Department'] = ds.get('faculty_Department').toString();
      userMapping['faculty_Position'] = ds.get('faculty_Position').toString();
      userMapping['faculty_Gender'] = ds.get('faculty_Gender').toString();
      userMapping['faculty_Affiliated_Centers_And_Labs'] = ds.get('faculty_Affiliated_Centers_And_Labs').toString();
      userMapping['faculty_Bio'] = ds.get('faculty_Bio').toString();
      userMapping['faculty_College'] = ds.get('faculty_College').toString();
      userMapping['faculty_Image_Url'] = ds.get('faculty_Image_Url').toString();
      userMapping['faculty_LinkedIn_Url'] = ds.get('faculty_LinkedIn_Url').toString();
      userMapping['faculty_Website_Url'] = ds.get('faculty_Website_Url').toString();
      userMapping['faculty_Mobile_Messaging_Token_Id'] = ds.get('faculty_Mobile_Messaging_Token_Id').toString();
      userMapping['faculty_Mobile_Number'] = ds.get('faculty_Mobile_Number').toString();
      userMapping['faculty_Office_Address'] = ds.get('faculty_Office_Address').toString();
      userMapping['faculty_Office_Latitude'] = ds.get('faculty_Office_Latitude').toString();
      userMapping['faculty_Office_Longitude'] = ds.get('faculty_Office_Longitude').toString();
      userMapping['faculty_Office_Navigation_Url'] = ds.get('faculty_Office_Navigation_Url').toString();
      userMapping['faculty_Research_Interests'] = ds.get('faculty_Research_Interests').toString();
      userMapping['faculty_Teaching_Interests'] = ds.get('faculty_Teaching_Interests').toString();
      userMapping['faculty_Dynamic_Links'] = ds.get('faculty_Dynamic_Links').toString();
      userMapping['faculty_Website_Page'] = ds.get('faculty_Website_Page').toString();
      userMapping['faculty_QR_Code_Image_Url'] = ds.get('faculty_QR_Code_Image_Url').toString();
      userMapping['faculty_Google_Auth_Token_Id'] = ds.get('faculty_Google_Auth_Token_Id').toString();
    });
    notifyListeners();
  }

  Future<void> fetchGuestProfile(
    BuildContext context,
  ) async {
    var currLoggedInUser = FirebaseAuth.instance.currentUser;
    var userEmailId = currLoggedInUser?.email as String;

    await FirebaseFirestore.instance
        .collection(GUEST_COLLECTION_NAME)
        // .doc(facultyDatabaseUniqueId)
        .doc(userEmailId)
        .get()
        .then((DocumentSnapshot ds) {

      userMapping['guest_Unique_Id'] = ds.get('guest_Unique_Id').toString();
      userMapping['guest_Name'] = ds.get('guest_Name').toString();
      userMapping['guest_EmailId'] = ds.get('guest_EmailId').toString();
      userMapping['guest_Gender'] = ds.get('guest_Gender').toString();
      userMapping['guest_Mobile_Messaging_Token_Id'] = ds.get('guest_Mobile_Messaging_Token_Id').toString();
      userMapping['guest_Google_Auth_Token_Id'] = ds.get('guest_Google_Auth_Token_Id').toString();
      userMapping['guest_Mobile_Number'] = ds.get('guest_Mobile_Number').toString();
      userMapping['guest_LinkedIn_Url'] = ds.get('guest_LinkedIn_Url').toString();
      userMapping['guest_Image_Url'] = ds.get('guest_Image_Url').toString();
      userMapping['guest_Bio'] = ds.get('guest_Bio').toString();
      userMapping['guest_Research_Interests'] = ds.get('guest_Research_Interests').toString();
    });
    notifyListeners();
  }

  Future<void> setUserType(
    BuildContext context,
  ) async {
    String? userEmailId = await FirebaseAuth.instance.currentUser?.email.toString();

    FirebaseFirestore db = FirebaseFirestore.instance;
    var facultyRef = await db.collection("FacultiesInformationList").doc(userEmailId).get();
    var guestRef = await db.collection("GuestsInformationList").doc(userEmailId).get();
    bool facultyExistance = facultyRef.exists;
    bool guestExistance = guestRef.exists;

    if (facultyExistance) {
      userType = FACULTY_USERTYPE;
      fetchFacultyProfile(context);
    } else if (guestExistance) {
      userType = GUEST_USERTYPE;
      fetchGuestProfile(context);
    }
  }

  Future<void> updateUserPersonalInformation(
    BuildContext context,
    String collectionName,
    String labelText,
    String updatedText,
  ) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference usersRef = db.collection(collectionName);

    var currLoggedInUser = await FirebaseAuth.instance.currentUser;
    var userEmailId = currLoggedInUser?.email as String;

    usersRef.doc(userEmailId).update({labelText: updatedText}).then((value) {
      userMapping[labelText] = updatedText;
    });

    notifyListeners();
    // Navigator.of(context).pushNamedAndRemoveUntil(TabsScreenDoctor.routeName, (route) => false);
  }

  Future<void> uploadInformationOfNewFaculty(
    BuildContext context,
    String loggedInUserUniqueId,
    String userName,
    String userEmailId,
    String userImageUrl,
    String userPhoneNumber,
    String userRefreshToken,
  ) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference usersRef = db.collection("FacultiesInformationList");

    try {
      await usersRef.doc(loggedInUserUniqueId).set(
        {
          'faculty_Unique_Id': loggedInUserUniqueId,
          'faculty_Authorization': 'false',
          'faculty_Name': userName,
          'faculty_EmailId': userEmailId,
          'faculty_Department': '',
          'faculty_Position': '',
          'faculty_Gender': '',
          'faculty_Affiliated_Centers_And_Labs': '',
          'faculty_Bio': '',
          'faculty_College': '',
          'faculty_Image_Url': userImageUrl,
          'faculty_LinkedIn_Url': '',
          'faculty_Website_Url': '',
          'faculty_Mobile_Messaging_Token_Id': '',
          'faculty_Mobile_Number': userPhoneNumber,
          'faculty_Office_Address': '',
          'faculty_Office_Latitude': '',
          'faculty_Office_Longitude': '',
          'faculty_Office_Navigation_Url': '',
          'faculty_Research_Interests': '',
          'faculty_Teaching_Interests': '',
          'faculty_Dynamic_Links': '',
          'faculty_Website_Page': '',
          'faculty_QR_Code_Image_Url': "",
          "faculty_Google_Auth_Token_Id": userRefreshToken,
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
    String userRefreshToken,
    String userName,
    String userEmailId,
    String userImageUrl,
  ) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference usersRef = db.collection("GuestsInformationList");

    try {
      await usersRef.doc(loggedInUserUniqueId).set({
        "guest_Unique_Id": loggedInUserUniqueId,
        "guest_Mobile_Messaging_Token_Id": "",
        "guest_Google_Auth_Token_Id": userRefreshToken,
        "guest_Name": userName,
        "guest_EmailId": userEmailId,
        "guest_Mobile_Number": "",
        "guest_Gender": "",
        "guest_LinkedIn_Url": "",
        "guest_Image_Url": userImageUrl,
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

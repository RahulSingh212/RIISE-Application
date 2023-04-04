// ignore_for_file: file_names, unused_import, use_build_context_synchronously, unnecessary_brace_in_string_interps, avoid_print
// import 'package:eosdart/eosdart.dart' as eos;
// import 'package:flutter/material.dart' hide Action;

import 'dart:convert';
import 'dart:io';
import 'dart:io' as ui;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:riise/providers/FirebaseProvider.dart';

import '../models/SpeakerInfo.dart';
import "../models/FacultyInfo.dart";

class FacultiesProvider with ChangeNotifier {
  List<FacultyServerInformation> facultiesList = [
    // FacultyServerInformation(
    //   faculty_Unique_Id: "1",
    //   faculty_Name: "Henansh",
    //   faculty_Position: "CEO",
    //   faculty_EmailId: "temp@gmail.com",
    //   faculty_Gender: "Male",
    //   faculty_Bio: "BIO",
    //   faculty_Image_Url: "assets/images/icons/profile.png",
    //   faculty_LinkedIn_Url: "assets/images/icons/profile.png",
    //   faculty_Website_Url: "assets/images/icons/profile.png",
    //   faculty_Office_Address: "addr",
    //   faculty_Office_Latitude: 12.5,
    //   faculty_Office_Longitude: 10.2,
    //   faculty_Mobile_Messaging_Token_Id: 'dsafasdfsa',
    //   faculty_Affiliated_Centers_And_Labs:
    //       'fasdf, dsfasd, fsdfsdf, dasfasd, fadsfsad',
    //   faculty_College: 'IIIT Delhi',
    //   faculty_Mobile_Number: '123456789',
    //   faculty_Research_Interests: 'd d d d d d',
    // ),
  ];

  Future<FacultyServerInformation> getFacultDetails(String facultyDatabaseUniqueId) async {
  late FacultyServerInformation facultyInfo;

    await FirebaseFirestore.instance
        .collection('FacultiesInformationList')
        // .doc(facultyDatabaseUniqueId)
        .doc(qrIdentifierMap[facultyDatabaseUniqueId])
        .get()
        .then((DocumentSnapshot ds) {
      facultyInfo = new FacultyServerInformation(
        faculty_Unique_Id: ds.get('faculty_Unique_Id').toString(),
        faculty_Authorization: ds.get('faculty_Authorization').toString() == 'true',
        faculty_Mobile_Messaging_Token_Id: ds.get('faculty_Mobile_Messaging_Token_Id').toString(),
        faculty_Name: ds.get('faculty_Name').toString(),
        faculty_Position: ds.get('faculty_Position').toString(),
        faculty_College: ds.get('faculty_College').toString(),
        faculty_Department: ds.get('faculty_Department').toString(),
        faculty_Mobile_Number: ds.get('faculty_Mobile_Number').toString(),
        faculty_Teaching_Interests: ds.get('faculty_Teaching_Interests').toString(),
        faculty_Research_Interests: ds.get('faculty_Research_Interests').toString(),
        faculty_Affiliated_Centers_And_Labs: ds.get('faculty_Affiliated_Centers_And_Labs').toString(),
        faculty_EmailId: ds.get('faculty_EmailId').toString(),
        faculty_Gender: ds.get('faculty_Gender').toString(),
        faculty_Bio: ds.get('faculty_Bio').toString(),
        faculty_Image_Url: ds.get('faculty_Image_Url').toString(),
        faculty_LinkedIn_Url: ds.get('faculty_LinkedIn_Url').toString(),
        faculty_Website_Url: ds.get('faculty_Website_Url').toString(),
        faculty_Office_Navigation_Url: ds.get('faculty_Office_Navigation_Url').toString(),
        faculty_Office_Address: ds.get('faculty_Office_Address').toString(),
        faculty_Office_Longitude: checkIfDouble(ds.get('faculty_Office_Longitude').toString()),
        faculty_Office_Latitude: checkIfDouble(ds.get('faculty_Office_Latitude').toString()),
      );

      return facultyInfo;
    });

    return facultyInfo;
  }

  Map<String, String> qrIdentifierMap = {
    "/subramanyam": "AJy7XCMPL0ZTpCLKT7FVzNsRUli1",
  };

  Future<void> fetchCollegeFaculties(
    BuildContext context,
  ) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference facultiesRef =
        db.collection("FacultiesInformationList");

    List<FacultyServerInformation> listOfFaculties = [];
    try {
      await facultiesRef.get().then(
        (ds) async {
          ds.docs.forEach(
            (facultyDetails) async {
              final facultyMap = facultyDetails.data() as Map<String, dynamic>;

              FacultyServerInformation facultyInfo = FacultyServerInformation(
                faculty_Unique_Id: facultyMap["faculty_Unique_Id"],
                faculty_Name: facultyMap["faculty_Name"],
                faculty_Position: facultyMap["faculty_Position"],
                faculty_EmailId: facultyMap["faculty_EmailId"],
                faculty_Gender: facultyMap["faculty_Gender"],
                faculty_Bio: facultyMap["faculty_Bio"],
                faculty_Teaching_Interests:
                    facultyMap["faculty_Teaching_Interests"],
                faculty_Authorization:
                    facultyMap["faculty_Authorization"] == "true",
                faculty_Image_Url: facultyMap["faculty_Image_Url"],
                faculty_LinkedIn_Url: facultyMap["faculty_LinkedIn_Url"],
                faculty_Website_Url: facultyMap["faculty_Website_Url"],
                faculty_Office_Navigation_Url:
                    facultyMap["faculty_Office_Navigation_Url"],
                faculty_Office_Address: facultyMap["faculty_Office_Address"],
                faculty_Office_Longitude:
                    checkIfDouble(facultyMap["faculty_Office_Longitude"]),
                faculty_Office_Latitude:
                    checkIfDouble(facultyMap["faculty_Office_Latitude"]),
                faculty_Mobile_Messaging_Token_Id:
                    facultyMap['faculty_Mobile_Messaging_Token_Id'],
                faculty_Affiliated_Centers_And_Labs:
                    facultyMap['faculty_Affiliated_Centers_And_Labs'],
                faculty_College: facultyMap['faculty_College'],
                faculty_Mobile_Number: facultyMap['faculty_Mobile_Number'],
                faculty_Research_Interests:
                    facultyMap['faculty_Research_Interests'],
                faculty_Department: facultyMap['faculty_Department'],
              );

              listOfFaculties.add(facultyInfo);
            },
          );
        },
      );

      facultiesList = listOfFaculties;
      notifyListeners();
    } catch (errorVal) {
      print(errorVal);
    }

    // return listOfFaculties;
  }

  double checkIfDouble(String val) {
    if (double.tryParse(val).toString() != 'null') {
      return double.parse(val);
    } else if (val == 'null' ||
        val == '' ||
        int.tryParse(val).toString() == 'null' ||
        double.tryParse(val).toString() == 'null') {
      return 0.0;
    } else {
      return double.parse(val);
    }
  }
}

// ignore_for_file: file_names, unused_import, use_build_context_synchronously, unnecessary_brace_in_string_interps, avoid_print
import 'package:eosdart/eosdart.dart' as eos;
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
  List<FacultyServerInformation> facultiesList = [];

  void fetchCollegeFaculties(
    BuildContext context,
  ) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference facultiesRef = db.collection("Faculties");

    try {
      List<FacultyServerInformation> listOfFaculties = [];

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
                faculty_Image_Url: facultyMap["faculty_Image_Url"],
                faculty_LinkedIn_Url: facultyMap["faculty_LinkedIn_Url"],
                faculty_Website_Url: facultyMap["faculty_Website_Url"],
                faculty_Office_Address: facultyMap["faculty_Office_Address"],
                faculty_Office_Longitude: double.parse(facultyMap["faculty_Office_Longitude"]),
                faculty_Office_Latitude: double.parse(facultyMap["faculty_Office_Latitude"]),
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
  }
}

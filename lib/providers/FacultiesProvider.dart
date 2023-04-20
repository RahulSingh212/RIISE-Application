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
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:riise/providers/FirebaseProvider.dart';
import 'package:riise/screens/Faculty/FacultyDetailScreen.dart';

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

  Future<FacultyServerInformation> getFacultyDetails(
      String facultyDatabaseUniqueId) async {
    late FacultyServerInformation facultyInfo;

    await FirebaseFirestore.instance
        .collection('FacultiesInformationList')
        // .doc(facultyDatabaseUniqueId)
        .doc(qrIdentifierMap[facultyDatabaseUniqueId])
        .get()
        .then((DocumentSnapshot ds) {
      facultyInfo = new FacultyServerInformation(
        faculty_Unique_Id: ds.get('faculty_Unique_Id').toString(),
        faculty_Authorization:
            ds.get('faculty_Authorization').toString() == 'true',
        faculty_Mobile_Messaging_Token_Id:
            ds.get('faculty_Mobile_Messaging_Token_Id').toString(),
        faculty_Name: ds.get('faculty_Name').toString(),
        faculty_Position: ds.get('faculty_Position').toString(),
        faculty_College: ds.get('faculty_College').toString(),
        faculty_Department: ds.get('faculty_Department').toString(),
        faculty_Mobile_Number: ds.get('faculty_Mobile_Number').toString(),
        faculty_Teaching_Interests:
            ds.get('faculty_Teaching_Interests').toString(),
        faculty_Research_Interests:
            ds.get('faculty_Research_Interests').toString(),
        faculty_Affiliated_Centers_And_Labs:
            ds.get('faculty_Affiliated_Centers_And_Labs').toString(),
        faculty_EmailId: ds.get('faculty_EmailId').toString(),
        faculty_Gender: ds.get('faculty_Gender').toString(),
        faculty_Bio: ds.get('faculty_Bio').toString(),
        faculty_Image_Url: ds.get('faculty_Image_Url').toString(),
        faculty_LinkedIn_Url: ds.get('faculty_LinkedIn_Url').toString(),
        faculty_Website_Url: ds.get('faculty_Website_Url').toString(),
        faculty_Office_Navigation_Url:
            ds.get('faculty_Office_Navigation_Url').toString(),
        faculty_Office_Address: ds.get('faculty_Office_Address').toString(),
        faculty_Office_Longitude:
            checkIfDouble(ds.get('faculty_Office_Longitude').toString()),
        faculty_Office_Latitude:
            checkIfDouble(ds.get('faculty_Office_Latitude').toString()),
      );
    });

    notifyListeners();
    return facultyInfo;
  }



  Future<void> facultyQRCodeNavigator(
    BuildContext context,
    String facultyDatabaseUniqueId,
  ) async {
    late FacultyServerInformation facultyInfo;

    await FirebaseFirestore.instance
        .collection('FacultiesInformationList')
        // .doc(facultyDatabaseUniqueId)
        .doc(qrIdentifierMap[facultyDatabaseUniqueId])
        .get()
        .then((DocumentSnapshot ds) {
      facultyInfo = new FacultyServerInformation(
        faculty_Unique_Id: ds.get('faculty_Unique_Id').toString(),
        faculty_Authorization:
            ds.get('faculty_Authorization').toString() == 'true',
        faculty_Mobile_Messaging_Token_Id:
            ds.get('faculty_Mobile_Messaging_Token_Id').toString(),
        faculty_Name: ds.get('faculty_Name').toString(),
        faculty_Position: ds.get('faculty_Position').toString(),
        faculty_College: ds.get('faculty_College').toString(),
        faculty_Department: ds.get('faculty_Department').toString(),
        faculty_Mobile_Number: ds.get('faculty_Mobile_Number').toString(),
        faculty_Teaching_Interests:
            ds.get('faculty_Teaching_Interests').toString(),
        faculty_Research_Interests:
            ds.get('faculty_Research_Interests').toString(),
        faculty_Affiliated_Centers_And_Labs:
            ds.get('faculty_Affiliated_Centers_And_Labs').toString(),
        faculty_EmailId: ds.get('faculty_EmailId').toString(),
        faculty_Gender: ds.get('faculty_Gender').toString(),
        faculty_Bio: ds.get('faculty_Bio').toString(),
        faculty_Image_Url: ds.get('faculty_Image_Url').toString(),
        faculty_LinkedIn_Url: ds.get('faculty_LinkedIn_Url').toString(),
        faculty_Website_Url: ds.get('faculty_Website_Url').toString(),
        faculty_Office_Navigation_Url:
            ds.get('faculty_Office_Navigation_Url').toString(),
        faculty_Office_Address: ds.get('faculty_Office_Address').toString(),
        faculty_Office_Longitude:
            checkIfDouble(ds.get('faculty_Office_Longitude').toString()),
        faculty_Office_Latitude:
            checkIfDouble(ds.get('faculty_Office_Latitude').toString()),
      );
    });

    // Navigator.of(context).pushAndRemoveUntil(
    //   MaterialPageRoute(
    //     builder: (context) => FacultyDetailScreen(
    //       facultyDetails: facultyInfo,
    //     ),
    //   ),
    //   (route) => false,
    // );
  }

  Map<String, String> qrIdentifierMap ={
    "/subramanyam": "subramanyam@iiitd.ac.in",
    "/aasim": "aasim@iiitd.ac.in",
    "/abhijit": "abhijit@iiitd.ac.in",
    "/aman": "aman@iiitd.ac.in",
    "/anand": "anand@iiitd.ac.in",
    "/angshul": "angshul@iiitd.ac.in",
    "/anmol": "anmol@iiitd.ac.in",
    "/anubha": "anubha@iiitd.ac.in",
    "/anujg": "anujg@iiitd.ac.in",
    "/anuradha": "anuradha@iiitd.ac.in",
    "/arani": "arani@iiitd.ac.in",
    "/arjun": "arjun@iiitd.ac.in",
    "/arunb": "arunb@iiitd.ac.in",
    "/ashishk": "ashishk@iiitd.ac.in",
    "/bapi": "bapi@iiitd.ac.in",
    "/chanekar": "chanekar@iiitd.ac.in",
    "/dbera": "dbera@iiitd.ac.in",
    "/debarka": "debarka@iiitd.ac.in",
    "/debika": "debika@iiitd.ac.in",
    "/dhruv": "dhruv.kumar@iiitd.ac.in",
    "/diptapriyo": "diptapriyo@iiitd.ac.in",
    "/donghoon": "donghoon@iiitd.ac.in",
    "/raghava": "raghava@iiitd.ac.in",
    "/bagler": "bagler@iiitd.ac.in",
    "/gauravahuja": "gauravahuja@iiitd.ac.in",
    "/gaurava": "gauravahuja@iiitd.ac.in",
    "/gayatri": "gayatri@iiitd.ac.in",
    "/jainendra": "jainendra@iiitd.ac.in",
    "/jaspreet": "jaspreet@iiitd.ac.in",
    "/kaushik": "kaushik@iiitd.ac.in",
    "/kanjilal": "kanjilal@iiitd.ac.in",
    "/koteswar": "koteswar@iiitd.ac.in",
    "/manohark": "manohark@iiitd.ac.in",
    "/manuj": "manuj@iiitd.ac.in",
    "/shad": "shad@iiitd.ac.in",
    "/monika": "monika@iiitd.ac.in",
    "/mrinmoy": "mrinmoy@iiitd.ac.in",
    "/mukesh": "mukesh@iiitd.ac.in",
    "/mukulika": "mukulika@iiitd.ac.in",
    "/arulmurugan": "arulmurugan@iiitd.ac.in",
    "/nishad": "nishad@iiitd.ac.in",
    "/ojaswa": "ojaswa@iiitd.ac.in",
    "/jalote": "jalote@iiitd.ac.in",
    "/paro": "paro@iiitd.ac.in",
    "/piyus": "piyus@iiitd.ac.in",
    "/praveen": "praveen@iiitd.ac.in",
    "/praveshb": "praveshb@iiitd.ac.in",
    "/pushpendra": "pushpendra@iiitd.ac.in",
    "/rajiv": "rajiv@iiitd.ac.in",
    "/rajivratn": "rajivratn@iiitd.ac.in",
    "/rakesh": "rakesh@iiitd.ac.in",
    "/rkghosh": "rkghosh@iiitd.ac.in",
    "/bose": "bose@iiitd.ac.in",
    "/ranjitha": "ranjitha@iiitd.ac.in",
    "/richagupta": "richagupta@iiitd.ac.in",
    "/rinku": "rinku@iiitd.ac.in",
    "/anands": "anands@iiitd.ac.in",
    "/sambuddho": "sambuddho@iiitd.ac.in",
    "/samrithram": "samrithram@iiitd.ac.in",
    "/sanat": "sanat@iiitd.ac.in",
    "/skkaul": "skkaul@iiitd.ac.in",
    "/sankha": "sankha@iiitd.ac.in",
    "/sarthok": "sarthok@iiitd.ac.in",
    "/satish": "satish@iiitd.ac.in",
    "/sayak": "sayak@iiitd.ac.in",
    "/sayan": "sayan@iiitd.ac.in",
    "/shobha": "shobha@iiitd.ac.in",
    "/smriti": "smriti@iiitd.ac.in",
    "/sneh": "sneh@iiitd.ac.in",
    "/sneha": "sneha@iiitd.ac.in",
    "/sonia": "sonia@iiitd.ac.in",
    "/souvik": "souvik@iiitd.ac.in",
    "/sriram": "sriram@iiitd.ac.in",
    "/subhabrata": "subhabrata@iiitd.ac.in",
    "/subhashreem": "subhashreem@iiitd.ac.in",
    "/sdeb": "sdeb@iiitd.ac.in",
    "/sumit": "sumit@iiitd.ac.in",
    "/syamantak": "syamantak@iiitd.ac.in",
    "/tammam": "tammam@iiitd.ac.in",
    "/tanmoy": "tanmoy@iiitd.ac.in",
    "/tarini": "tarini@iiitd.ac.in",
    "/tavpritesh": "tavpritesh@iiitd.ac.in",
    "/raghavam": "raghavam@iiitd.ac.in",
    "/ratan": "ratan@iiitd.ac.in",
    "/vibhork": "vibhork@iiitd.ac.in",
    "/vikram": "vikram@iiitd.ac.in",
    "/vabrol": "vabrol@iiitd.ac.in",
    "/vivek": "vivek@iiitd.ac.in",
    "/vivekk": "vivekk@iiitd.ac.in"
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

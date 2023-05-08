// ignore_for_file: file_names, unused_import, use_build_context_synchronously, unnecessary_brace_in_string_interps

import 'dart:convert';
import 'dart:io';
import 'dart:io' as ui;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:riise/providers/FirebaseProvider.dart';
import 'package:riise/screens/TabScreen.dart';

import '../models/CoordinateInfo.dart';

class LocationProvider with ChangeNotifier {
  List<CoordinateServerInformation> coordinateDirectionsList = [];

  Future<void> fetchLocationList(BuildContext context) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference coordinateRef = db.collection("CoordinationInformation");

    List<CoordinateServerInformation> listOfCoordinateList = [];
    try {
      await coordinateRef.get().then(
        (ds) async {
          ds.docs.forEach(
            (facultyDetails) async {
              final coordinateMap = facultyDetails.data() as Map<String, dynamic>;

              CoordinateServerInformation coordinateInfo = CoordinateServerInformation(
                coordinate_Unique_Id: coordinateMap['coordinate_Unique_Id'],
                coordinate_Longitude: double.parse(coordinateMap['coordinate_Longitude']),
                coordinate_Latitude: double.parse(coordinateMap['coordinate_Latitude']),
                coordinate_Name: coordinateMap['coordinate_Name'],
                coordinate_Address: coordinateMap['coordinate_Address'],
                coordinate_Code_Name: coordinateMap['coordinate_Code_Name'],
                coordinate_Landmark: coordinateMap['coordinate_Landmark'],
                Images_List: coordinateMap['Images_List'],
              );

              listOfCoordinateList.add(coordinateInfo);
            },
          );
        },
      );

      coordinateDirectionsList = listOfCoordinateList;
      notifyListeners();
    } catch (errorVal) {
      print(errorVal);
    }
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

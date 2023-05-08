// ignore_for_file: non_constant_identifier_names, file_names
import 'package:flutter/material.dart';

// class CoordinateServerInformation {
//   final double coordinate_Longitude;
//   final double coordinate_Latitude;

//   CoordinateServerInformation(this.coordinate_Longitude, {
//     required this.coordinate_Latitude,
//     required this.coordinate_Latitude,
//   });
// }

class CoordinateServerInformation {
  final String coordinate_Unique_Id;
  final double coordinate_Longitude;
  final double coordinate_Latitude;
  final String coordinate_Name;
  final String coordinate_Address;
  final String coordinate_Code_Name;
  final String coordinate_Landmark;
  final List<dynamic> Images_List;

  CoordinateServerInformation({
    required this.coordinate_Unique_Id,
    required this.coordinate_Longitude,
    required this.coordinate_Latitude,
    required this.coordinate_Name,
    required this.coordinate_Address,
    required this.coordinate_Code_Name,
    required this.coordinate_Landmark,
    required this.Images_List,
  });
}
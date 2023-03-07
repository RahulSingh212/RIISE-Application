// ignore_for_file: non_constant_identifier_names, file_names
import 'package:flutter/material.dart';

import "./SpeakerInfo.dart";

class ThemeServerInformation {
  final String Theme_Unique_Id;
  final String Theme_Image_Url;
  final String Theme_Name;
  final String Theme_Info;
  final DateTime Theme_Date;
  final TimeOfDay Theme_Start_Time;
  final TimeOfDay Theme_End_Time;
  final List<SpeakerServerInformation> themeSpeakersList;

  ThemeServerInformation({
    required this.Theme_Unique_Id,
    required this.Theme_Image_Url,
    required this.Theme_Name,
    required this.Theme_Info,
    required this.Theme_Date,
    required this.Theme_Start_Time,
    required this.Theme_End_Time,
    required this.themeSpeakersList,
  });
}
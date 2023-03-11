// ignore_for_file: non_constant_identifier_names, file_names
import 'package:flutter/material.dart';

import "./SpeakerInfo.dart";

class EventServerInformation {
  final String Event_Unique_Id;
  final String Event_Image_Url;
  final String Event_Name;
  final String Event_Info;
  final String Event_Address;
  final String Event_Longitude;
  final String Event_Latitude;
  final DateTime Event_Date;
  final TimeOfDay Event_Start_Time;
  final TimeOfDay Event_End_Time;
  final List<SpeakerServerInformation> EventSpeakersList;

  EventServerInformation({
    required this.Event_Unique_Id,
    required this.Event_Image_Url,
    required this.Event_Name,
    required this.Event_Info,
    required this.Event_Address,
    required this.Event_Longitude,
    required this.Event_Latitude,
    required this.Event_Date,
    required this.Event_Start_Time,
    required this.Event_End_Time,
    required this.EventSpeakersList,
  });
}
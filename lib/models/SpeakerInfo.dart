// ignore_for_file: non_constant_identifier_names, file_names

import 'dart:io';

import 'package:flutter/material.dart';

class SpeakerServerInformation {
  final String speaker_Unique_Id;
  final String speaker_Name;
  final String speaker_Position;
  final String speaker_Talk_Title;
  final String speaker_Abstract;
  final String speaker_Bio;
  final TimeOfDay speaker_Start_Time;
  final TimeOfDay speaker_End_Time;
  final String speaker_Image_Url;
  final String speaker_LinkedIn_Url;
  final String speaker_Website_Url;

  SpeakerServerInformation({
    required this.speaker_Unique_Id,
    required this.speaker_Name,
    required this.speaker_Position,
    required this.speaker_Talk_Title,
    required this.speaker_Abstract,
    required this.speaker_Bio,
    required this.speaker_Start_Time,
    required this.speaker_End_Time,
    required this.speaker_Image_Url,
    required this.speaker_LinkedIn_Url,
    required this.speaker_Website_Url,
  });
}

class SpeakerLocalInformation {
  final String speaker_Unique_Id;
  final String speaker_Name;
  final String speaker_Position;
  final String speaker_Talk_Title;
  final String speaker_Abstract;
  final String speaker_Bio;
  final TimeOfDay speaker_Start_Time;
  final TimeOfDay speaker_End_Time;
  final File speaker_Image_File;
  final String speaker_LinkedIn_Url;
  final String speaker_Website_Url;

  SpeakerLocalInformation({
    required this.speaker_Unique_Id,
    required this.speaker_Name,
    required this.speaker_Position,
    required this.speaker_Talk_Title,
    required this.speaker_Abstract,
    required this.speaker_Bio,
    required this.speaker_Start_Time,
    required this.speaker_End_Time,
    required this.speaker_Image_File,
    required this.speaker_LinkedIn_Url,
    required this.speaker_Website_Url,
  });
}

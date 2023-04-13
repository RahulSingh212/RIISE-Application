// ignore_for_file: file_names, unnecessary_import, unused_import, non_constant_identifier_names, avoid_print

import "dart:collection";

import "package:cloud_firestore/cloud_firestore.dart";
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";

import "../models/SpeakerInfo.dart";
import "../models/ThemeInfo.dart";

class ThemeProvider with ChangeNotifier {
  int cnt = 0;
  List<ThemeServerInformation> themesList = [];

  Future<void> fetchThemes(
    BuildContext context,
  ) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference themesRef = db.collection("Themes");

    try {
      List<ThemeServerInformation> listOfThemes = [];
      await themesRef.get().then(
        (ds) async {
          ds.docs.forEach(
            (themeDetails) async {
              // var themeMap = HashMap.from(themeDetails.data());
              // print(themeDetails.data());

              final themeMap = themeDetails.data() as Map<String, dynamic>;

              String Theme_Unique_Id = themeMap["Theme_Unique_Id"].toString();
              String Theme_Name = themeMap["Theme_Name"].toString();
              String Theme_Info = themeMap["Theme_Info"].toString();
              String Theme_Image_Url = themeMap["Theme_Image_Url"].toString();
              DateTime Theme_Date = DateTime.parse(themeMap["Theme_Date"].toString());
              TimeOfDay Theme_Start_Time = convertStringToTimeOfDay(themeMap["Theme_Start_Time"].toString());
              TimeOfDay Theme_End_Time = convertStringToTimeOfDay(themeMap["Theme_End_Time"].toString());

              List<SpeakerServerInformation> themeSpeakersList =
                  await fetchSpeakers(
                context,
                Theme_Unique_Id,
              );

              // print(themeSpeakersList);

              ThemeServerInformation themeInfo = ThemeServerInformation(
                Theme_Unique_Id: Theme_Unique_Id,
                Theme_Name: Theme_Name,
                Theme_Info: Theme_Info,
                Theme_Image_Url: Theme_Image_Url,
                Theme_Date: Theme_Date,
                Theme_Start_Time: Theme_Start_Time,
                Theme_End_Time: Theme_End_Time,
                themeSpeakersList: themeSpeakersList,
              );

              listOfThemes.add(themeInfo);
            },
          );
        },
      );

      themesList = listOfThemes;

      notifyListeners();
    } catch (errorVal) {
      print(errorVal);
    }
  }

  Future<List<SpeakerServerInformation>> fetchSpeakers(
    BuildContext context,
    String Theme_Unique_Id,
  ) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference speakersRef = db.collection("Themes/$Theme_Unique_Id/Speakers");

    List<SpeakerServerInformation> speakerList = [];
    try {
      await speakersRef.get().then(
        (ds) async {
          ds.docs.forEach(
            (themeDetails) async {
              // var themeMap = HashMap.from(themeDetails.data());
              // print(themeDetails.data());

              final speakersMap = themeDetails.data() as Map<String, dynamic>;

              String speaker_Unique_Id = speakersMap["speaker_Unique_Id"].toString();
              String speaker_Name = speakersMap["speaker_Name"].toString();
              String speaker_Position = speakersMap["speaker_Position"].toString();
              String speaker_Talk_Title = speakersMap["speaker_Talk_Title"].toString();
              String speaker_Bio = speakersMap["speaker_Bio"].toString();
              String speaker_Abstract = speakersMap["speaker_Abstract"].toString();
              String speaker_Image_Url = speakersMap["speaker_Image_Url"].toString();
              String speaker_LinkedIn_Url = speakersMap["speaker_LinkedIn_Url"].toString();
              String speaker_Website_Url = speakersMap["speaker_Website_Url"].toString();
              TimeOfDay speaker_Start_Time = convertStringToTimeOfDay(speakersMap["speaker_Start_Time"].toString());
              TimeOfDay speaker_End_Time = convertStringToTimeOfDay(speakersMap["speaker_End_Time"].toString());

              SpeakerServerInformation speakerInfo = SpeakerServerInformation(
                speaker_Unique_Id: speaker_Unique_Id,
                speaker_Name: speaker_Name,
                speaker_Position: speaker_Position,
                speaker_Talk_Title: speaker_Talk_Title,
                speaker_Abstract: speaker_Abstract,
                speaker_Bio: speaker_Bio,
                speaker_Start_Time: speaker_Start_Time,
                speaker_End_Time: speaker_End_Time,
                speaker_Image_Url: speaker_Image_Url,
                speaker_LinkedIn_Url: speaker_LinkedIn_Url,
                speaker_Website_Url: speaker_Website_Url,
              );

              speakerList.add(speakerInfo);
            },
          );
        },
      );
    } catch (errorVal) {
      print(errorVal);
    }

    return speakerList;
  }

  TimeOfDay convertStringToTimeOfDay(String givenTime) {
    int hrVal = int.parse(givenTime.split(":")[0].substring(10));
    int minVal = int.parse(givenTime.split(":")[1].substring(0, 2));
    TimeOfDay time = TimeOfDay(hour: hrVal, minute: minVal);

    return time;
  }
}

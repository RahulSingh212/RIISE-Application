// ignore_for_file: file_names, unnecessary_import, unused_import, non_constant_identifier_names, avoid_print

import "dart:collection";

import "package:cloud_firestore/cloud_firestore.dart";
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";

import "../models/EventInfo.dart";
import "../models/SpeakerInfo.dart";
import "../models/ThemeInfo.dart";

class PanelDiscussionProvider with ChangeNotifier {
  List<EventServerInformation> panelDiscussionList = [];

  Future<void> fetchPanelDiscussion(
    BuildContext context,
    // String collectionName,
  ) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference speakerTracksRef = db.collection("PanelDiscussion");

    // var cnt = 0;
    // if (collectionName == "SpeakerTracks") cnt += 1;
    // if (collectionName == "PosterTracks") cnt += 1;
    // if (collectionName == "PanelDiscussion") cnt += 1;

    // if (cnt < 1) return;

    try {
      List<EventServerInformation> listOfEventTracks = [];
      await speakerTracksRef.get().then(
        (ds) async {
          ds.docs.forEach(
            (themeDetails) async {
              // var themeMap = HashMap.from(themeDetails.data());
              // print(themeDetails.data());

              final eventMap = themeDetails.data() as Map<String, dynamic>;

              String Event_Unique_Id = eventMap["Event_Unique_Id"].toString();
              String Event_Name = eventMap["Event_Name"].toString();
              String Event_Info = eventMap["Event_Info"].toString();
              String Event_Address = eventMap["Event_Address"].toString();
              String Event_Image_Url = eventMap["Event_Image_Url"].toString();
              String Event_Latitude = eventMap["Event_Latitude"].toString();
              String Event_Longitude = eventMap["Event_Longitude"].toString();
              DateTime Event_Date = DateTime.parse(eventMap["Event_Date"].toString());
              TimeOfDay Event_Start_Time = convertStringToTimeOfDay(eventMap["Event_Start_Time"].toString());
              TimeOfDay Event_End_Time = convertStringToTimeOfDay(eventMap["Event_End_Time"].toString());

              List<SpeakerServerInformation> eventSpeakersList =
                  await fetchSpeakers(
                context,
                "PanelDiscussion",
                Event_Unique_Id,
              );

              EventServerInformation eventInfo = EventServerInformation(
                Event_Unique_Id: Event_Unique_Id,
                Event_Image_Url: Event_Image_Url,
                Event_Name: Event_Name,
                Event_Info: Event_Info,
                Event_Address: Event_Address,
                Event_Longitude: Event_Longitude,
                Event_Latitude: Event_Latitude,
                Event_Date: Event_Date,
                Event_Start_Time: Event_Start_Time,
                Event_End_Time: Event_End_Time,
                EventSpeakersList: eventSpeakersList,
              );

              panelDiscussionList.add(eventInfo);
              print(eventInfo.Event_Name);
            },
          );
        },
      );

      // panelDiscussionList = listOfEventTracks;
      // print(listOfEventTracks);

      notifyListeners();
    } catch (errorVal) {
      print(errorVal);
    }
  }

  Future<List<SpeakerServerInformation>> fetchSpeakers(
    BuildContext context,
    String eventCollectionName,
    String Event_Unique_Id,
  ) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference speakersRef = db.collection("$eventCollectionName/$Event_Unique_Id/Speakers");

    List<SpeakerServerInformation> speakerList = [];
    try {
      await speakersRef.get().then(
        (ds) async {
          ds.docs.forEach(
            (eventDetails) async {
              final speakersMap = eventDetails.data() as Map<String, dynamic>;

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
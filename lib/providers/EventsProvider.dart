// ignore_for_file: file_names, unnecessary_import, unused_import, non_constant_identifier_names, avoid_print

import "dart:collection";

import "package:cloud_firestore/cloud_firestore.dart";
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import "package:riise/screens/Schedules/ScheduleScreen.dart";

import "../models/EventInfo.dart";
import "../models/SpeakerInfo.dart";
import "../models/ThemeInfo.dart";

class EventProvider with ChangeNotifier {
  List<EventServerInformation> collectionOfAllEventList = [];
  List<EventServerInformation> posterTracksList = [];
  List<SpeakerServerInformation> keynoteSpeakersList = [];

  List<EventServerInformation> speakerTracksList = [];
  List<EventServerInformation> rndShowcasesAndDemosList = [];
  List<EventServerInformation> forwardLookingPanelsList = [];
  List<EventServerInformation> beyondCollegePanelsList = [];
  List<EventServerInformation> startUpShowcaseList = [];
  List<EventServerInformation> demosAndResearchesHighlightsList = [];
  List<EventServerInformation> researchShowcasesList = [];
  List<EventServerInformation> panelDiscussionList = [];
  List<EventServerInformation> extraEventsList = [];

  List<String> firebaseCollectionsList = [
    "SpeakerTracks",
    "ForwardLookingPanels",
    "BeyondCollegePanels",
    "ResearchShowcases",
    "Extra-Events",
  ];

  late Map<String, dynamic> firebaseCollectionsMap = {
    "SpeakerTracks": speakerTracksList,
    "RNDShowcasesAndDemos": rndShowcasesAndDemosList,
    "ForwardLookingPanels": forwardLookingPanelsList,
    "BeyondCollegePanels": beyondCollegePanelsList,
    "StartUpShowcase": startUpShowcaseList,
    "DemosAndResearchesHighlights": demosAndResearchesHighlightsList,
    "ResearchShowcases": researchShowcasesList,
    "PanelDiscussion": panelDiscussionList,
    "Extra-Events": extraEventsList,
  };

  EventProvider() {
    firebaseCollectionsMap = {
      "SpeakerTracks": speakerTracksList,
      "RNDShowcasesAndDemos": rndShowcasesAndDemosList,
      "ForwardLookingPanels": forwardLookingPanelsList,
      "BeyondCollegePanels": beyondCollegePanelsList,
      "StartUpShowcase": startUpShowcaseList,
      "DemosAndResearchesHighlights": demosAndResearchesHighlightsList,
      "ResearchShowcases": researchShowcasesList,
      "PanelDiscussion": panelDiscussionList,
    };
  }

  Future<void> fetchExtraEventTracks(
    BuildContext context,
    String collectionName,
  ) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference eventsTracksRef = db.collection(collectionName);

    List<EventServerInformation> listOfEventTracks = [];
    try {
      await eventsTracksRef.get().then(
        (ds) async {
          for (var themeDetails in ds.docs) {
            final eventMap = themeDetails.data() as Map<String, dynamic>;

            String Event_Unique_Id = eventMap["Event_Unique_Id"].toString();
            String Event_Name = eventMap["Event_Name"].toString();
            String Event_Info = eventMap["Event_Info"].toString();
            String Event_Address = eventMap["Event_Address"].toString();
            String Event_Image_Url = eventMap["Event_Image_Url"].toString();
            String Event_Latitude = eventMap["Event_Latitude"].toString();
            String Event_Longitude = eventMap["Event_Longitude"].toString();
            DateTime Event_Date =
                DateTime.parse(eventMap["Event_Date"].toString());
            TimeOfDay Event_Start_Time = convertStringToTimeOfDay(
                eventMap["Event_Start_Time"].toString());
            TimeOfDay Event_End_Time =
                convertStringToTimeOfDay(eventMap["Event_End_Time"].toString());

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
              EventSpeakersList: [],
            );

            listOfEventTracks.add(eventInfo);
          }
        },
      );
    } catch (errorVal) {}

    extraEventsList = listOfEventTracks;
  }

  Future<void> fetchEventTracks(
    BuildContext context,
    String collectionName,
  ) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference eventsTracksRef = db.collection(collectionName);

    int cnt = 0;

    if (collectionName == "SpeakerTracks")
      cnt += 1;
    else if (collectionName == "RNDShowcasesAndDemos")
      cnt += 1;
    else if (collectionName == "ForwardLookingPanels")
      cnt += 1;
    else if (collectionName == "BeyondCollegePanels")
      cnt += 1;
    else if (collectionName == "StartUpShowcase")
      cnt += 1;
    else if (collectionName == "DemosAndResearchesHighlights")
      cnt += 1;
    else if (collectionName == "ResearchShowcases")
      cnt += 1;
    else if (collectionName == "PanelDiscussion") cnt += 1;

    if (cnt < 1) return;

    try {
      List<EventServerInformation> listOfEventTracks = [];

      await eventsTracksRef.get().then(
        (ds) async {
          for (var themeDetails in ds.docs) {
            final eventMap = themeDetails.data() as Map<String, dynamic>;

            String Event_Unique_Id = eventMap["Event_Unique_Id"].toString();
            String Event_Name = eventMap["Event_Name"].toString();
            String Event_Info = eventMap["Event_Info"].toString();
            String Event_Address = eventMap["Event_Address"].toString();
            String Event_Image_Url = eventMap["Event_Image_Url"].toString();
            String Event_Latitude = eventMap["Event_Latitude"].toString();
            String Event_Longitude = eventMap["Event_Longitude"].toString();
            DateTime Event_Date =
                DateTime.parse(eventMap["Event_Date"].toString());
            TimeOfDay Event_Start_Time = convertStringToTimeOfDay(
                eventMap["Event_Start_Time"].toString());
            TimeOfDay Event_End_Time =
                convertStringToTimeOfDay(eventMap["Event_End_Time"].toString());

            await fetchSpeakers(
              context,
              collectionName,
              Event_Unique_Id,
            ).then((value) async {
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
                EventSpeakersList: value,
              );

              listOfEventTracks.add(eventInfo);
            });
          }

          if (collectionName == "SpeakerTracks") {
            speakerTracksList = listOfEventTracks;
          } else if (collectionName == "RNDShowcasesAndDemos") {
            rndShowcasesAndDemosList = listOfEventTracks;
          } else if (collectionName == "ForwardLookingPanels") {
            forwardLookingPanelsList = listOfEventTracks;
          } else if (collectionName == "BeyondCollegePanels") {
            beyondCollegePanelsList = listOfEventTracks;
          } else if (collectionName == "StartUpShowcase") {
            startUpShowcaseList = listOfEventTracks;
          } else if (collectionName == "DemosAndResearchesHighlights") {
            demosAndResearchesHighlightsList = listOfEventTracks;
          } else if (collectionName == "ResearchShowcases") {
            researchShowcasesList = listOfEventTracks;
          } else if (collectionName == "PanelDiscussion") {
            panelDiscussionList = listOfEventTracks;
          }
        },
      );
    } catch (errorVal) {
      print(errorVal);
    }

    notifyListeners();
  }

  Future<List<EventServerInformation>> getEventList(
    BuildContext context,
    String collectionName,
  ) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference eventsTracksRef = db.collection(collectionName);

    List<EventServerInformation> listOfEventTracks = [];
    try {
      await eventsTracksRef.get().then(
        (ds) async {
          for (var themeDetails in ds.docs) {
            final eventMap = themeDetails.data() as Map<String, dynamic>;

            String Event_Unique_Id = eventMap["Event_Unique_Id"].toString();
            String Event_Name = eventMap["Event_Name"].toString();
            String Event_Info = eventMap["Event_Info"].toString();
            String Event_Address = eventMap["Event_Address"].toString();
            String Event_Image_Url = eventMap["Event_Image_Url"].toString();
            String Event_Latitude = eventMap["Event_Latitude"].toString();
            String Event_Longitude = eventMap["Event_Longitude"].toString();
            DateTime Event_Date =
                DateTime.parse(eventMap["Event_Date"].toString());
            TimeOfDay Event_Start_Time = convertStringToTimeOfDay(
                eventMap["Event_Start_Time"].toString());
            TimeOfDay Event_End_Time =
                convertStringToTimeOfDay(eventMap["Event_End_Time"].toString());

            await fetchSpeakers(
              context,
              collectionName,
              Event_Unique_Id,
            ).then((value) {
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
                EventSpeakersList: value,
              );

              listOfEventTracks.add(eventInfo);
            });
          }
        },
      ).then((value) {
        print("Above Return TRY CATCH -> ) $listOfEventTracks");
        notifyListeners();
        return listOfEventTracks;
      });
    } catch (errorVal) {
      print("ERROR HERE -> $errorVal");
    }

    return [];
  }

  Future<void> getFullListOfEvents(
    BuildContext context,
  ) async {
    List<EventServerInformation> allEventsList = [];

    for (var collectionName in firebaseCollectionsList) {
      await fetchEventTracks(context, collectionName).then((value) {
        allEventsList.addAll(firebaseCollectionsMap[collectionName]);
      });
    }

    collectionOfAllEventList = allEventsList;
  }

  Future<List<EventServerInformation>> fetchEventListFirestore(
    BuildContext context,
    String collectionName,
  ) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference eventsTracksRef = db.collection(collectionName);

    List<EventServerInformation> allEventsList = [];
    try {
      await eventsTracksRef.get().then((ds) async {
        for (var themeDetails in ds.docs) {
          final eventMap = themeDetails.data() as Map<String, dynamic>;

          String Event_Unique_Id = eventMap["Event_Unique_Id"].toString();
          String Event_Name = eventMap["Event_Name"].toString();
          String Event_Info = eventMap["Event_Info"].toString();
          String Event_Address = eventMap["Event_Address"].toString();
          String Event_Image_Url = eventMap["Event_Image_Url"].toString();
          String Event_Latitude = eventMap["Event_Latitude"].toString();
          String Event_Longitude = eventMap["Event_Longitude"].toString();

          DateTime Event_Date =
              DateTime.parse(eventMap["Event_Date"].toString());

          TimeOfDay Event_Start_Time =
              convertStringToTimeOfDay(eventMap["Event_Start_Time"].toString());

          TimeOfDay Event_End_Time =
              convertStringToTimeOfDay(eventMap["Event_End_Time"].toString());

          await fetchSpeakers(
            context,
            collectionName,
            Event_Unique_Id,
          ).then((value) async {
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
              EventSpeakersList: value,
            );

            allEventsList.add(eventInfo);
          });
        }
      });
    } catch (error) {}

    allEventsList.sort((a, b) => compareEvent(a, b) * -1);

    return allEventsList;
  }

  Future<List<EventServerInformation>> getEntireListOfEvents(
    BuildContext context,
  ) async {
    List<EventServerInformation> allEventsList = [];

    for (var collectionName in firebaseCollectionsList) {
      List<EventServerInformation> list = await fetchEventListFirestore(
        context,
        collectionName,
      );
      if (collectionName == "Extra-Events") {
        print(";klghjfgdzcxvhjkl;kjgfdxgchjklo;pkljfbvx");
        print(list);
        print(list[0].Event_Name);
      }

      allEventsList = new List.from(allEventsList)..addAll(list);

      print("listingssss");
      print(allEventsList);
    }

    allEventsList.sort((a, b) => compareEvent(a, b));

    return allEventsList;
  }

  Future<List<EventServerInformation>> getEntireListOfEvents2(
      BuildContext context,
      ) async {
    List<EventServerInformation> allEventsList = [];

    for (var collectionName in firebaseCollectionsList) {
      List<EventServerInformation> list = await fetchEventListFirestore(
        context,
        collectionName,
      );
      if (collectionName == "Extra-Events") {
        print(";klghjfgdzcxvhjkl;kjgfdxgchjklo;pkljfbvx");
        print(list);
        print(list[0].Event_Name);
      }

      allEventsList = new List.from(allEventsList)..addAll(list);

      print("listingssss");
      print(allEventsList);
    }

    allEventsList.sort((a, b) => compareEvent(a, b));

    List<EventServerInformation> retList = allEventsList.where((element) =>

    element.Event_Date.isAtSameMomentAs(DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day,)) == 0?

    element.Event_End_Time.compareTo(TimeOfDay.fromDateTime(DateTime.now().subtract(Duration(minutes: 5))))>0 : true )
        .toList();


    return retList;
  }

  int compareEvent(
      EventServerInformation event1, EventServerInformation event2) {
    int d1 = event1.Event_Date.day,
        m1 = event1.Event_Date.month,
        y1 = event1.Event_Date.year;
    int d2 = event2.Event_Date.day,
        m2 = event2.Event_Date.month,
        y2 = event2.Event_Date.year;
    int t1 =
        (event1.Event_Start_Time.hour * 60) + event1.Event_Start_Time.minute;
    int t2 =
        (event2.Event_Start_Time.hour * 60) + event2.Event_Start_Time.minute;

    if (d1 == d2 && m1 == m2 && y1 == y2) {
      if (t1 <= t2)
        return -1;
      else
        return 1;
    } else {
      if (event1.Event_Date.isBefore(event2.Event_Date))
        return -1;
      else
        return 1;
    }
  }

  Future<void> fetchKeynoteSpeaker(
    BuildContext context,
  ) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference keynoteSpeakersRef = db.collection("KeynoteSpeakers");

    List<SpeakerServerInformation> speakerList = [];
    try {
      await keynoteSpeakersRef.get().then(
        (ds) async {
          ds.docs.forEach(
            (eventDetails) async {
              final speakersMap = eventDetails.data() as Map<String, dynamic>;

              String speaker_Unique_Id =
                  speakersMap["speaker_Unique_Id"].toString();
              String speaker_Name = speakersMap["speaker_Name"].toString();
              String speaker_Position =
                  speakersMap["speaker_Position"].toString();
              String speaker_Talk_Title =
                  speakersMap["speaker_Talk_Title"].toString();
              String speaker_Bio = speakersMap["speaker_Bio"].toString();
              String speaker_Abstract =
                  speakersMap["speaker_Abstract"].toString();
              String speaker_Image_Url =
                  speakersMap["speaker_Image_Url"].toString();
              String speaker_LinkedIn_Url =
                  speakersMap["speaker_LinkedIn_Url"].toString();
              String speaker_Website_Url =
                  speakersMap["speaker_Website_Url"].toString();
              TimeOfDay speaker_Start_Time = convertStringToTimeOfDay(
                  speakersMap["speaker_Start_Time"].toString());
              TimeOfDay speaker_End_Time = convertStringToTimeOfDay(
                  speakersMap["speaker_End_Time"].toString());

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

    keynoteSpeakersList = speakerList;
  }

  Future<List<SpeakerServerInformation>> fetchSpeakers(
    BuildContext context,
    String eventCollectionName,
    String Event_Unique_Id,
  ) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference speakersRef =
        db.collection("$eventCollectionName/$Event_Unique_Id/Speakers");

    List<SpeakerServerInformation> speakerList = [];
    try {
      await speakersRef.get().then(
        (ds) async {
          ds.docs.forEach(
            (eventDetails) async {
              final speakersMap = eventDetails.data() as Map<String, dynamic>;

              String speaker_Unique_Id =
                  speakersMap["speaker_Unique_Id"].toString();
              String speaker_Name = speakersMap["speaker_Name"].toString();
              String speaker_Position =
                  speakersMap["speaker_Position"].toString();
              String speaker_Talk_Title =
                  speakersMap["speaker_Talk_Title"].toString();
              String speaker_Bio = speakersMap["speaker_Bio"].toString();
              String speaker_Abstract =
                  speakersMap["speaker_Abstract"].toString();
              String speaker_Image_Url =
                  speakersMap["speaker_Image_Url"].toString();
              String speaker_LinkedIn_Url =
                  speakersMap["speaker_LinkedIn_Url"].toString();
              String speaker_Website_Url =
                  speakersMap["speaker_Website_Url"].toString();
              TimeOfDay speaker_Start_Time = convertStringToTimeOfDay(
                  speakersMap["speaker_Start_Time"].toString());
              TimeOfDay speaker_End_Time = convertStringToTimeOfDay(
                  speakersMap["speaker_End_Time"].toString());

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

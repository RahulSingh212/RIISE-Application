// ignore_for_file: file_names, unused_import, use_build_context_synchronously, unnecessary_brace_in_string_interps
import 'package:eosdart/eosdart.dart' as eos;
// import 'package:flutter/material.dart' hide Action;

import 'dart:convert';
// import 'dart:html';
import 'dart:io';
import 'dart:io' as ui;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:riise/providers/FirebaseProvider.dart';

import '../models/SpeakerInfo.dart';

class AddSectionsProvider with ChangeNotifier {
  List<SpeakerLocalInformation> speakerListForEvents = [];

  void addNewEventForTheme(
    BuildContext context,
    Map<String, dynamic> profileInfoMapping,
    List<SpeakerLocalInformation> speakerList,
  ) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference themesRef = db.collection("Themes");

    String themeId = "";

    try {
      var eventResponse1 = await themesRef.add(
        {
          "Theme_Name": profileInfoMapping["Theme_Name"].text.toString(),
          "Theme_Info": profileInfoMapping["Theme_Info"].text.toString(),
          "Theme_Date": profileInfoMapping["Theme_Date"].toString(),
          "Theme_Start_Time": profileInfoMapping["Theme_Start_Time"].toString(),
          "Theme_End_Time": profileInfoMapping["Theme_End_Time"].toString(),
          "Theme_Unique_Id": "",
          "Theme_Image_Url": "",
        },
      ).then(
        (value) async {
          themesRef.doc(value.id).update({"Theme_Unique_Id": value.id});
          themeId = value.id;
          // value.get().then(((DocumentSnapshot ds) {
          //   print(ds.data());
          // }));

          String imagePath = "${value.id}/Icons";

          final themeImgResponse = uploadImage(
            context,
            "Themes",
            value.id,
            imagePath,
            "themeIcon",
            "Theme_Image_Url",
            profileInfoMapping["Theme_Image_File"],
          );

          for (var speaker in speakerList) {
            addSpeakerInformation(
              context,
              value.id,
              speaker,
            );
          }
        },
      );

      notifyListeners();
    } catch (errorVal) {
      print(errorVal);
    }
  }

  void addSpeakerInformation(
    BuildContext context,
    String themeId,
    SpeakerLocalInformation speakerDetails,
  ) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference speakersRef = db.collection("Themes").doc(themeId).collection("Speakers");


    String speakerId = "";

    try {
      var eventResponse1 = await speakersRef.add(
        {
          "speaker_Unique_Id": "",
          "speaker_Name": speakerDetails.speaker_Name,
          "speaker_Position": speakerDetails.speaker_Position,
          "speaker_Talk_Title": speakerDetails.speaker_Talk_Title,
          "speaker_Abstract": speakerDetails.speaker_Abstract,
          "speaker_Bio": speakerDetails.speaker_Bio,
          "speaker_End_Time": speakerDetails.speaker_End_Time.toString(),
          "speaker_Start_Time": speakerDetails.speaker_Start_Time.toString(),
          "speaker_Image_Url": "",
          "speaker_LinkedIn_Url": speakerDetails.speaker_LinkedIn_Url,
          "speaker_Website_Url": speakerDetails.speaker_Website_Url,
        },
      ).then(
        (value) async {
          speakersRef.doc(value.id).update({"speaker_Unique_Id": value.id});
          speakerId = value.id;
          // value.get().then(((DocumentSnapshot ds) {
          //   print(ds.data());
          // }));

          String imagePath = "${value.id}/Images";

          final themeImgResponse = uploadImage(
            context,
            "Themes/$themeId/Speakers",
            value.id,
            imagePath,
            "profileImage",
            "speaker_Image_Url",
            speakerDetails.speaker_Image_File,
          );
        },
      );

      notifyListeners();
    } catch (errorVal) {
      print(errorVal);
    }
  }

  void uploadImage(
    BuildContext context,
    String collectionName,
    String uniqueId,
    String imagePath,
    String imageNickName,
    String contextName,
    File profilePicFile,
  ) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    // CollectionReference usersRef = db.collection("DoctorUsersPersonalInformation");

    String imageName = "${uniqueId}_${imageNickName}.jpg";
    final profilePicture = FirebaseStorage.instance
        .ref()
        .child("$collectionName/$imagePath")
        .child(imageName);

    try {
      final imageUploadResponse = await profilePicture.putFile(profilePicFile);
      String imageDownloadLink = await profilePicture.getDownloadURL();

      db.collection(collectionName).doc(uniqueId).update(
        {
          contextName: imageDownloadLink,
        },
      );
    } catch (errorVal) {
      print(errorVal);
    }
  }
}

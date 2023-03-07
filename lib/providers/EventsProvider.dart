// ignore_for_file: file_names

import "dart:collection";

import "package:cloud_firestore/cloud_firestore.dart";
import 'package:flutter/cupertino.dart';

import "../models/SpeakerInfo.dart";
import "../models/ThemeInfo.dart";

class EventProvider with ChangeNotifier {
  List<ThemeServerInformation> themesList = [];

  void fetchThemes(
    BuildContext context,
  ) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference themesRef = db.collection("Themes");

    try {
      themesRef.get().then(
        (ds) async {
          ds.docs.forEach(
            (themeDetails) async {
              // var themeMap = HashMap.from(themeDetails.data());
              var themeMap = themeDetails.data() as HashMap<String, String>;

              

            },
          );
        },
      );
    } catch (errorVal) {
      print(errorVal);
    }
  }
}

// ignore_for_file: unnecessary_this, unused_import, unused_local_variable, file_names

import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FirebaseProvider with ChangeNotifier {
  String firebaseUrlInUse = "riise-application-default-rtdb.firebaseio.com/";

  String firebaseWebApiKey = "AIzaSyCCQUfxLC-4U8cCjXpt5prvxAdm206I0jY";

  String getFirebaseUrl() {
    return firebaseUrlInUse;
  }

  String getFirebaseWebApiKey() {
    return firebaseWebApiKey;
  }

  Uri getFirebasePathUrl(String pathLocation) {
    Uri url = Uri.https(
      firebaseUrlInUse,
      pathLocation,
    );

    return url;
  }
}
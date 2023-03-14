// ignore_for_file: file_names, unused_import, avoid_print, use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../screens/TabScreen.dart';
import 'FirebaseProvider.dart';
import 'UserDetailsProvider.dart';

class UserLoginProvider with ChangeNotifier {
  String guestType = "guest";
  String facultyType = "faculty";
  bool checkExecution = true;
  String userType = "Guest";
  late UserCredential loggedInUserCredentials;
  late String _emailToken;
  late String _patientExpiryDateTime;
  late String _patientUniqueId;
  String errorMessageValue = "";

  Future<bool> checkIfEmailIdExistsInDatabase(
    String collectionName,
    String givenUserType,
    String enteredEmailId,
  ) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference collectionRef = db.collection(collectionName);

    bool chk = false;
    try {
      await collectionRef.get().then(
        (ds) async {
          ds.docs.forEach(
            (userDetails) async {
              final facultyMap = userDetails.data() as Map<String, dynamic>;

              String emailId =
                  facultyMap["$givenUserType${"_"}EmailId"].toString();
              if (emailId == enteredEmailId) {
                chk = true;
              }
            },
          );
        },
      );

      notifyListeners();
    } catch (errorVal) {
      print(errorVal);
    }

    return chk;
  }

  Future<void> addUserEmailToExistingList(
    String collectionName,
    String givenUserType,
    String userEmailId,
    String userUniqueId,
  ) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference userRef = db.collection(collectionName);

    try {
      await userRef.add(
        {
          "$givenUserType${"_"}EmailId": userEmailId.toString(),
          "$givenUserType${"_"}UniqueId": userUniqueId.toString(),
        },
      );

      notifyListeners();
    } catch (errorVal) {
      print(errorVal);
    }
  }

  Future<UserCredential> signUpWithGoogle(
    BuildContext context,
  ) async {
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    AuthCredential authCredential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(
      authCredential,
    );

    loggedInUserCredentials = userCredential;

    print(userCredential.user?.displayName);
    print(userCredential.user?.email);

    return userCredential;
  }

  void signInWithGoogle(
    BuildContext context,
  ) async {
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    AuthCredential authCredential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(
      authCredential,
    );

    loggedInUserCredentials = userCredential;

    print(userCredential.user?.displayName);
    print(userCredential.user?.email);
  }

  void signOutWithGoogle(BuildContext context) async {
    // GoogleSignInAccount? googleUser = await GoogleSignIn().signOut();
    // FirebaseAuth.instance.signOut();
  }

  Future<void> signIn(
    BuildContext context,
    String email,
    String password,
  ) async {
    String firebaseDatabaseUniqueKey =
        Provider.of<FirebaseProvider>(context, listen: false)
            .getFirebaseWebApiKey();
    String signInUrl =
        "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$firebaseDatabaseUniqueKey";

    try {
      final signInResponse = await http.post(
        Uri.parse(signInUrl),
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      final responseData = json.decode(signInResponse.body);

      // print(responseData['UID']);
      responseData.forEach((key, value) {
        print("Key: $key,\nValue: $value");
      });

      if (responseData['error'] != null) {
        // errorMessageValue = responseData['error']['message'];
        notifyListeners();
      } else {
        /// sign in the user
      }
    } catch (errorVal) {
      throw errorVal;
    }
  }

  Future<void> checkPointsWhenButtonIsPressed(BuildContext context) async {
    UserCredential userCredential = await signUpWithGoogle(context);

    var currLoggedInUser = FirebaseAuth.instance.currentUser;
    var userUniqueId = currLoggedInUser?.uid as String;

    String? userEmailId = userCredential.user?.email;
    String? userName = userCredential.user?.displayName;
    String collectionName =
        userType == "Guest" ? "GuestsEmailingList" : "FacultiesEmailingList";
    String givenUserType = userType == "Guest" ? guestType : facultyType;

    bool checkIfUserExists = await checkIfEmailIdExistsInDatabase(
      collectionName,
      givenUserType,
      userEmailId!,
    );

    // print("User Type: $userType");
    // print("Collection Name: $collectionName");
    // print("Given User Name: $givenUserType");

    if (checkIfUserExists) {
      Navigator.of(context).pushNamedAndRemoveUntil(
        TabScreen.routeName,
        (route) => false,
      );
    } else {
      await addUserEmailToExistingList(
        collectionName,
        givenUserType,
        userEmailId,
        userUniqueId,
      );

      if (userType == "Guest") {
        Provider.of<UserDetailsProvider>(context, listen: false)
            .uploadInformationOfNewGuest(
          context,
          userUniqueId,
          userName!,
          userEmailId,
        );
      } else {
        Provider.of<UserDetailsProvider>(context, listen: false)
            .uploadInformationOfNewFaculty(
          context,
          userUniqueId,
          userName!,
          userEmailId,
        );
      }
    }
  }
}

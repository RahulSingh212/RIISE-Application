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
import 'package:googleapis/calendar/v3.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import '../screens/TabScreen.dart';
import 'FirebaseProvider.dart';
import 'UserDetailsProvider.dart';
import 'package:googleapis_auth/googleapis_auth.dart' as auth;

const FACULTY_USERTYPE = "Faculty";
const GUEST_USERTYPE = "Guest";
const FACULTY_COLLECTION_NAME = "FacultiesInformationList";
const GUEST_COLLECTION_NAME = "GuestsInformationList";

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
  late GoogleSignInAccount? staticGoogleUser;

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
    await GoogleSignIn().signOut();

    // TODO - Try Storing this
    GoogleSignInAccount? googleUser =
        await GoogleSignIn(scopes: ['https://www.googleapis.com/auth/calendar'])
            .signIn();

    staticGoogleUser = googleUser;
    print("Static Google User -> $staticGoogleUser");

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

    // print("ACCESS TOKEN -> ${googleAuth?.accessToken}");
    // print("ACCESS TOKEN -> ${googleAuth?.idToken}");
    print(userCredential.user?.displayName);
    print(userCredential.user?.email);

    final accessToken = await googleAuth?.accessToken;

    print("ACCESS TOKEN ON TABSCREEN = $accessToken");

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
    await GoogleSignIn().signOut();
    FirebaseAuth.instance.signOut();
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
    loggedInUserCredentials = userCredential;

    var currLoggedInUser = FirebaseAuth.instance.currentUser;
    var userUniqueId = currLoggedInUser?.uid as String;

    String? userEmailId = userCredential.user?.email;
    String? userName = userCredential.user?.displayName;
    String? userRefreshToken = userCredential.user?.refreshToken;
    String? userImageUrl = userCredential.user?.photoURL;
    String? userPhoneNumber = userCredential.user?.phoneNumber;
    String collectionName = userType == "Guest" ? "GuestsEmailingList" : "FacultiesEmailingList";
    String givenUserType = userType == "Guest" ? guestType : facultyType;

    print("Refresh Token: ");
    print(userCredential.user?.refreshToken);

    // bool checkIfUserExists = await checkIfEmailIdExistsInDatabase(
    //   collectionName,
    //   givenUserType,
    //   userEmailId!,
    // );
    FirebaseFirestore db = FirebaseFirestore.instance;
    var facultyRef = await db.collection("FacultiesInformationList").doc(userEmailId).get();
    var guestRef = await db.collection("GuestsInformationList").doc(userEmailId).get();
    bool facultyExistance = facultyRef.exists;
    bool guestExistance = guestRef.exists;

    if (facultyExistance) {
      Provider.of<UserDetailsProvider>(context, listen: false).userType = "Faculty";
    }
    else {
      Provider.of<UserDetailsProvider>(context, listen: false).userType = "Guest";
    }

    if (facultyExistance || guestExistance) {
      Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => TabScreen(),
      ),
    );
    } else {
      uploadInformationOfNewGuest(
        context,
        userUniqueId,
        userName!,
        userEmailId!,
        userRefreshToken.toString(),
        userImageUrl.toString(),
        userPhoneNumber.toString(),
      );
      // if (userType == "Guest") {
      //   uploadInformationOfNewGuest(
      //     context,
      //     userUniqueId,
      //     userName!,
      //     userEmailId!,
      //     userRefreshToken.toString(),
      //     userImageUrl.toString(),
      //     userPhoneNumber.toString(),
      //   );
      // } else {
      //   uploadInformationOfNewFaculty(
      //     context,
      //     userUniqueId,
      //     userName!,
      //     userEmailId!,
      //     userRefreshToken.toString(),
      //     userImageUrl.toString(),
      //     userPhoneNumber.toString(),
      //   );
      // }
    }
  }

  Future<void> uploadInformationOfNewFaculty(
    BuildContext context,
    String loggedInUserUniqueId,
    String userName,
    String userEmailId,
    String userRefreshToken,
    String userImageUrl,
    String userPhoneNumber,
  ) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference usersRef = db.collection("FacultiesInformationList");

    try {
      await usersRef.doc(userEmailId).set(
        {
          'faculty_Unique_Id': loggedInUserUniqueId,
          'faculty_Authorization': 'false',
          'faculty_Name': userName,
          'faculty_EmailId': userEmailId,
          'faculty_Department': '',
          'faculty_Position': '',
          'faculty_Gender': '',
          'faculty_Affiliated_Centers_And_Labs': '',
          'faculty_Bio': '',
          'faculty_College': '',
          'faculty_Image_Url': userImageUrl,
          'faculty_LinkedIn_Url': '',
          'faculty_Website_Url': '',
          'faculty_Mobile_Messaging_Token_Id': '',
          'faculty_Mobile_Number': userPhoneNumber,
          'faculty_Office_Address': '',
          'faculty_Office_Latitude': '',
          'faculty_Office_Longitude': '',
          'faculty_Office_Navigation_Url': '',
          'faculty_Research_Interests': '',
          'faculty_Teaching_Interests': '',
          'faculty_Dynamic_Links': '',
          'faculty_Website_Page': '',
          'faculty_QR_Code_Image_Url': "",
          "faculty_Google_Auth_Token_Id": userRefreshToken,
        },
      );

      Navigator.of(context).pushNamedAndRemoveUntil(
        TabScreen.routeName,
        (route) => false,
      );
    } catch (errorVal) {
      print(errorVal);
    }
  }

  Future<void> uploadInformationOfNewGuest(
    BuildContext context,
    String loggedInUserUniqueId,
    String userName,
    String userEmailId,
    String userRefreshToken,
    String userImageUrl,
    String userPhoneNumber,
  ) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference usersRef = db.collection("GuestsInformationList");

    try {
      await usersRef.doc(userEmailId).set({
        "guest_Unique_Id": loggedInUserUniqueId,
        "guest_Mobile_Messaging_Token_Id": "",
        "guest_Google_Auth_Token_Id": userRefreshToken,
        "guest_Name": userName,
        "guest_EmailId": userEmailId,
        "guest_Mobile_Number": "",
        "guest_Gender": "",
        "guest_LinkedIn_Url": "",
        "guest_Image_Url": userImageUrl,
        "guest_Bio": "",
        "guest_Research_Interests": "",
      });

      Navigator.of(context).pushNamedAndRemoveUntil(
        TabScreen.routeName,
        (route) => false,
      );
    } catch (errorVal) {
      print(errorVal);
    }
  }
}

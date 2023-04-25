// ignore_for_file: unused_import, deprecated_member_use, unnecessary_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:googleapis/cloudsearch/v1.dart';
import 'package:googleapis_auth/auth.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:riise/models/FacultyInfo.dart';
import 'package:riise/modules/AppointmentUtil.dart';
import 'package:riise/providers/UserLoginProvider.dart';

import '../models/CalendarSchedule.dart';
import 'FacultiesProvider.dart';

class CalenderAPI extends ChangeNotifier {
  List<CalendarScheduleServerInformation> facultyScheduleList = [];
  List<CalendarScheduleServerInformation> guestScheduleList = [];

  Future<bool> checkForFacultyScheduleConflicts(
    BuildContext context,
    DateTime startTime,
    DateTime endTime,
  ) async {
    for (int i = 0; i < facultyScheduleList.length; i++) {
      DateTime sst = facultyScheduleList[i].schedule_Start_Time;
      DateTime set = facultyScheduleList[i].schedule_End_Time;

      int day = facultyScheduleList[i].schedule_Start_Time.day;
      int month = facultyScheduleList[i].schedule_Start_Time.month;
      int year = facultyScheduleList[i].schedule_Start_Time.year;

      int dayGiven = startTime.day;
      int monthGiven = startTime.month;
      int yearGiven = startTime.year;

      if (day == dayGiven && month == monthGiven && year == yearGiven) {
        if ((startTime.isAfter(sst) && startTime.isBefore(set)) ||
            (endTime.isAfter(sst) && endTime.isBefore(set))) {
          return false;
        }
      }
    }

    return true;
  }

  Future<void> addNewSchedule(
    String scheduleUniqueId,
    String facultyName,
    String facultyEmailId,
    String guestEmailId,
    String guestName,
    DateTime startTime,
    DateTime endTime,
  ) async {
    const facultyCollectionName = "Faculty-Schedule-List";
    const guestCollectionName = "Guest-Schedule-List";
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference facultyRef = db.collection('${facultyCollectionName}/${facultyEmailId}');
    CollectionReference guestRef = db.collection('${guestCollectionName}/${facultyEmailId}');

    try {
      await facultyRef.doc(scheduleUniqueId).set(
        {
          "schedule_Unque_Id": scheduleUniqueId,
          "schedule_Start_Time": startTime.toString(),
          "schedule_End_Time": endTime.toString(),
          "User_Email_Id": facultyEmailId,
          "User_Name": guestName,
        },
      );

      await guestRef.doc(scheduleUniqueId).set(
        {
          "schedule_Unque_Id": scheduleUniqueId,
          "schedule_Start_Time": startTime.toString(),
          "schedule_End_Time": endTime.toString(),
          "User_Email_Id": facultyEmailId,
          "User_Name": facultyName,
        },
      );
    } catch (error) {
      print(error);
    }
  }

  Future<void> fetchSchedules(
    BuildContext context,
    String userType,
    String collectionName,
    String userEmail,
  ) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference facultyRef =
        db.collection('${collectionName}/${userEmail}');

    List<CalendarScheduleServerInformation> list = [];
    try {
      await facultyRef.get().then(
        (ds) async {
          ds.docs.forEach(
            (scheduleDetails) async {
              final scheduleMapping =
                  scheduleDetails.data() as Map<String, dynamic>;

              CalendarScheduleServerInformation schedule =
                  new CalendarScheduleServerInformation(
                schedule_Unque_Id: scheduleMapping['schedule_Unque_Id'],
                schedule_Start_Time: DateTime.parse(
                    scheduleMapping['schedule_Start_Time'].toString()),
                schedule_End_Time: DateTime.parse(
                    scheduleMapping['schedule_End_Time'].toString()),
                User_Email_Id: scheduleMapping['User_Email_Id'],
                User_Name: scheduleMapping['User_Name'],
              );

              list.add(schedule);
            },
          );
        },
      );

      if (userType.toLowerCase() == "guest") {
        guestScheduleList = list;
      } else {
        facultyScheduleList = list;
      }

      notifyListeners();
    } catch (errorVal) {
      print(errorVal);
    }
  }

  List<AppointmentUtil> appointmentList = [];
  List<String> facultyList = [
    "subramanyam@iiitd.ac.in",
    "aasim@iiitd.ac.in",
    "abhijit@iiitd.ac.in",
    "aman@iiitd.ac.in",
    "anand@iiitd.ac.in",
    "angshul@iiitd.ac.in",
    "anmol@iiitd.ac.in",
    "anubha@iiitd.ac.in",
    "anuj@iiitd.ac.in",
    "anuradha@iiitd.ac.in",
    "arani@iiitd.ac.in",
    "arjun@iiitd.ac.in",
    "arunb@iiitd.ac.in",
    "ashish.pandey@iiitd.ac.in",
    "bapi@iiitd.ac.in",
    "prasad@iiitd.ac.in",
    "dbera@iiitd.ac.in",
    "debarka@iiitd.ac.in",
    "debika@iiitd.ac.in",
    "dhruv.kumar@iiitd.ac.in",
    "diptapriyo@iiitd.ac.in",
    "donghoon@iiitd.ac.in",
    "raghava@iiitd.ac.in",
    "bagler@iiitd.ac.in",
    "gaurav.ahuja@iiitd.ac.in",
    "gaurav@iiitd.ac.in",
    "gayatri@iiitd.ac.in",
    "jainendra@iiitd.ac.in",
    "jaspreet@iiitd.ac.in",
    "kaushik@iiitd.ac.in",
    "kanjilal@iiitd.ac.in",
    "koteswar@iiitd.ac.in",
    "manohar.kumar@iiitd.ac.in",
    "manuj@iiitd.ac.in",
    "shad.akhtar@iiitd.ac.in",
    "monika@iiitd.ac.in",
    "mrinmoy@iiitd.ac.in",
    "mukesh@iiitd.ac.in",
    "mukulika@iiitd.ac.in",
    "arul.murugan@iiitd.ac.in.",
    "nishad@iiitd.ac.in",
    "ojaswa@iiitd.ac.in",
    "jalote@iiitd.ac.in",
    "paro.mishra@iiitd.ac.in",
    "piyus@iiitd.ac.in",
    "praveen@iiitd.ac.in",
    "praveshb@iiitd.ac.in",
    "psingh@iiitd.ac.in",
    "rajiv@iiitd.ac.in",
    "rajivratn@iiitd.ac.in",
    "rakesh@iiitd.ac.in",
    "rkghosh@iiitd.ac.in",
    "bose@iiitd.ac.in",
    "ranjitha@iiitd.ac.in",
    "richa.gupta@iiitd.ac.in",
    "rinku@iiitd.ac.in",
    "anands@iiitd.ac.in",
    "sambuddho@iiitd.ac.in",
    "samrith@iiitd.ac.in",
    "sanat@iiitd.ac.in",
    "skkaul@iiitd.ac.in",
    "sankha@iiitd.ac.in",
    "sarthok@iiitd.ac.in",
    "satish@iiitd.ac.in",
    "sayak@iiitd.ac.in",
    "sayan@iiitd.ac.in",
    "shobha@iiitd.ac.in",
    "smriti@iiitd.ac.in",
    "sneh@iiitd.ac.in",
    "sneha@iiitd.ac.in",
    "sonia@iiitd.ac.in",
    "souvik@iiitd.ac.in",
    "sriramk@iiitd.ac.in",
    "subhabrata@iiitd.ac.in",
    "subhashree@iiitd.ac.in",
    "sdeb@iiitd.ac.in",
    "sumit@iiitd.ac.in",
    "syamantak@iiitd.ac.in",
    "tammam@iiitd.ac.in",
    "tanmoy@iiitd.ac.in",
    "tarini.ghosh@iiitd.ac.in",
    "tavpriteshsethi@iiitd.ac.in",
    "raghava.mutharaju@iiitd.ac.in",
    "ratan.suri@iiitd.ac.in",
    "vibhor@iiitd.ac.in",
    "vikram@iiitd.ac.in",
    "abrol@iiitd.ac.in",
    "vivek.b@iiitd.ac.in",
    "vivekk@iiitd.ac.in",
  ];

  addEvent(
      BuildContext context,
      String name,
      DateTime startTime,
      DateTime endTime,
      List<EventAttendee> attendeesList,
      String descp,
      String location) async {
    // TODO - get access token here
    GoogleSignIn? googleUser = await GoogleSignIn(
        scopes: ['https://www.googleapis.com/auth/calendar']);
    final GoogleSignInAccount = await googleUser.signInSilently();

    final googleAuth = await GoogleSignInAccount?.authentication;
    // final accessToken = "ya29.a0Ael9sCNTICz8w49X6vW0a0AU6Wp-iwpgKkenAhKCbc5vCKZRRzorJOfWVHYYv6gurmSlqu6TrDA8SWsspv7cOc83fYuKezNeuVq3twbwWu9iU1c3Q26EfH9rjWf5Q7nGNmia05Y6hl0W3WbF-Xf53fNjWCD4aCgYKAc0SARESFQF4udJhWdFfWnmxoPBKiidqvPkv-g0163";
    final accessToken = googleAuth?.accessToken;

    print("ACCESS TOKEN _> $accessToken");

    final httpClient = authenticatedClient(
      Client(),
      AccessCredentials(
        AccessToken(
          'Bearer',
          accessToken!,
          DateTime.now()
              .add(
                Duration(
                  minutes: 5,
                ),
              )
              .toUtc(),
        ),
        null,
        [],
      ),
    );
    final calendar = CalendarApi(httpClient);

    print("Start Time -> $startTime");
    print("Start Time -> $endTime");
    print("Start Time -> $name");
    print("Start Time -> $descp");

    final event = Event()
      ..summary = name
      ..attendees = attendeesList
      ..description = descp
      ..location = location
      ..start = (EventDateTime()..dateTime = startTime.toUtc())
      ..end = (EventDateTime()..dateTime = endTime.toUtc());

    print("Adding EVENT");

    try {
      print("Hello 1");
      await calendar.events.insert(event, 'primary',
          sendNotifications: true, sendUpdates: 'all');
      print("Hello 2");
    } catch (e) {
      print("Error -> $e");
    }
    ;
  }

  fetchEvent(BuildContext context) async {
    GoogleSignIn? googleUser = await GoogleSignIn(
        scopes: ['https://www.googleapis.com/auth/calendar']);
    final GoogleSignInAccount = await googleUser.signInSilently();

    final googleAuth = await GoogleSignInAccount?.authentication;
    // final accessToken = "ya29.a0Ael9sCNTICz8w49X6vW0a0AU6Wp-iwpgKkenAhKCbc5vCKZRRzorJOfWVHYYv6gurmSlqu6TrDA8SWsspv7cOc83fYuKezNeuVq3twbwWu9iU1c3Q26EfH9rjWf5Q7nGNmia05Y6hl0W3WbF-Xf53fNjWCD4aCgYKAc0SARESFQF4udJhWdFfWnmxoPBKiidqvPkv-g0163";
    final accessToken = googleAuth?.accessToken;

    print("ACCESS TOKEN _> $accessToken");

    final httpClient = authenticatedClient(
        Client(),
        AccessCredentials(
            AccessToken('Bearer', accessToken!,
                DateTime.now().add(Duration(minutes: 5)).toUtc()),
            null,
            []));
    final calendar = CalendarApi(httpClient);

    final events = await calendar.events.list(
      "primary",
    );

    if (events.items != null) {
      List<AppointmentUtil> tempList = [];
      for (int i = 0; i < events.items!.length; i++) {
        final tempEvent = events.items![i];

        if (tempEvent.start != null &&
            (tempEvent.summary.toString().toLowerCase().contains("riise") ||
                tempEvent.summary
                    .toString()
                    .toLowerCase()
                    .contains("guest-faculty interaction") ||
                tempEvent.description
                    .toString()
                    .toLowerCase()
                    .contains("riise") ||
                tempEvent.description
                    .toString()
                    .toLowerCase()
                    .contains("guest-faculty interaction"))) {
          // print("Hello There");
          // tempList.add(AppointmentUtil(tempEvent.summary.toString(), DateTime.now(), DateTime.now().add(Duration(minutes: 15)), tempEvent.description.toString(),"Temp",tempEvent.location.toString()));
          FacultyServerInformation faculty = FacultyServerInformation(
              faculty_Unique_Id: "Temp",
              faculty_Authorization: true,
              faculty_Mobile_Messaging_Token_Id: "Temp",
              faculty_Name: "Temp",
              faculty_Position: "Temp",
              faculty_College: "Temp",
              faculty_Department: "Temp",
              faculty_Mobile_Number: "Temp",
              faculty_Teaching_Interests: "Temp",
              faculty_Research_Interests: "Temp",
              faculty_Affiliated_Centers_And_Labs: "Temp",
              faculty_EmailId: "Temp",
              faculty_Gender: "Temp",
              faculty_Bio: "Temp",
              faculty_Image_Url: "Temp",
              faculty_LinkedIn_Url: "Temp",
              faculty_Website_Url: "Temp",
              faculty_Office_Navigation_Url: "Temp",
              faculty_Office_Address: "Temp",
              faculty_Office_Longitude: 0,
              faculty_Office_Latitude: 0);

          if (tempEvent.attendees != null &&
              tempEvent.attendees!.isNotEmpty &&
              facultyList.contains(tempEvent.attendees![0].email.toString())) {
            faculty = await getFacultyDetails(
                tempEvent.attendees![0].email.toString());
            // print(tempEvent.summary.toString()+" > "+tempEvent.attendees![0].email.toString());
          }

          tempList.add(AppointmentUtil(
              tempEvent.summary.toString(),
              DateTime.now(),
              DateTime.now().add(Duration(minutes: 15)),
              tempEvent.description.toString(),
              faculty,
              "Temp"));
        }
      }
      appointmentList = tempList;
      notifyListeners();
    }
  }

  Future<FacultyServerInformation> getFacultyDetails(
      String facultyDatabaseUniqueId) async {
    late FacultyServerInformation facultyInfo;

    await FirebaseFirestore.instance
        .collection('FacultiesInformationList')
        // .doc(facultyDatabaseUniqueId)
        .doc(facultyDatabaseUniqueId)
        .get()
        .then((DocumentSnapshot ds) {
      facultyInfo = new FacultyServerInformation(
        faculty_Unique_Id: ds.get('faculty_Unique_Id').toString(),
        faculty_Authorization:
            ds.get('faculty_Authorization').toString() == 'true',
        faculty_Mobile_Messaging_Token_Id:
            ds.get('faculty_Mobile_Messaging_Token_Id').toString(),
        faculty_Name: ds.get('faculty_Name').toString(),
        faculty_Position: ds.get('faculty_Position').toString(),
        faculty_College: ds.get('faculty_College').toString(),
        faculty_Department: ds.get('faculty_Department').toString(),
        faculty_Mobile_Number: ds.get('faculty_Mobile_Number').toString(),
        faculty_Teaching_Interests:
            ds.get('faculty_Teaching_Interests').toString(),
        faculty_Research_Interests:
            ds.get('faculty_Research_Interests').toString(),
        faculty_Affiliated_Centers_And_Labs:
            ds.get('faculty_Affiliated_Centers_And_Labs').toString(),
        faculty_EmailId: ds.get('faculty_EmailId').toString(),
        faculty_Gender: ds.get('faculty_Gender').toString(),
        faculty_Bio: ds.get('faculty_Bio').toString(),
        faculty_Image_Url: ds.get('faculty_Image_Url').toString(),
        faculty_LinkedIn_Url: ds.get('faculty_LinkedIn_Url').toString(),
        faculty_Website_Url: ds.get('faculty_Website_Url').toString(),
        faculty_Office_Navigation_Url:
            ds.get('faculty_Office_Navigation_Url').toString(),
        faculty_Office_Address: ds.get('faculty_Office_Address').toString(),
        faculty_Office_Longitude:
            checkIfDouble(ds.get('faculty_Office_Longitude').toString()),
        faculty_Office_Latitude:
            checkIfDouble(ds.get('faculty_Office_Latitude').toString()),
      );
    });

    return facultyInfo;
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

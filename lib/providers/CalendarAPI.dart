// ignore_for_file: unused_import, deprecated_member_use, unnecessary_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
import 'package:riise/providers/UserDetailsProvider.dart';
import 'package:riise/providers/UserLoginProvider.dart';

import '../models/CalendarSchedule.dart';
import 'FacultiesProvider.dart';

const FACULTY_SCHEDULE_COLLECTION_NAME = "Faculty-Schedule-List";
const GUEST_SCHEDULE_COLLECTION_NAME = "Guest-Schedule-List";

class CalenderAPI extends ChangeNotifier {
  List<CalendarScheduleServerInformation> facultyScheduleList = [];
  List<CalendarScheduleServerInformation> guestScheduleList = [];

  Future<bool> checkForFacultyScheduleConflicts(
    BuildContext context,
    DateTime startTime,
    DateTime endTime,
  ) async {
    print("Schedule LIST -> ");

    for (int i = 0; i < facultyScheduleList.length; i++) {
      print("${facultyScheduleList[i].User_Name}" +
          " - ${facultyScheduleList[i].User_Email_Id}" +
          "${facultyScheduleList[i].schedule_Start_Time}" +
          " - ${facultyScheduleList[i].schedule_End_Time}" +
          "${facultyScheduleList[i].schedule_Unque_Id}");

      DateTime sst =
      facultyScheduleList[i].schedule_Start_Time;
      DateTime set =
          facultyScheduleList[i].schedule_End_Time.add(Duration(minutes: 5));

      if (((startTime.isAfter(sst) && startTime.isBefore(set))||(endTime.isAfter(sst) && endTime.isBefore(set))) &&
          startTime.day == set.day &&
          startTime.month == set.month &&
          startTime.year == set.year) {
        return false;
      }
    }

    return true;
  }

  DateTime getForFacultyScheduleInterval(BuildContext context) {
    print("Schedule LIST -> ");

    List<CalendarScheduleServerInformation> tempFacultyScheduleList =
        facultyScheduleList;
    tempFacultyScheduleList
        .sort((a, b) => a.schedule_Start_Time.compareTo(b.schedule_Start_Time));

    for (int i = 1; i < tempFacultyScheduleList.length; i++) {
      print("${tempFacultyScheduleList[i].User_Name}" +
          " - ${tempFacultyScheduleList[i].User_Email_Id}" +
          "${tempFacultyScheduleList[i].schedule_Start_Time}" +
          " - ${tempFacultyScheduleList[i].schedule_End_Time}" +
          "${tempFacultyScheduleList[i].schedule_Unque_Id}");

      DateTime before = tempFacultyScheduleList[i - 1]
          .schedule_End_Time
          .add(Duration(minutes: 5));
      DateTime after = tempFacultyScheduleList[i]
          .schedule_Start_Time
          .subtract(Duration(minutes: 5));

      if (after.difference(before).inMinutes >= 20 && before.isAfter(DateTime.now().add(Duration(minutes: 5)))) {
        print("Setting Time to before");
        print(before);
        return before;
      }
    }
    print("Setting Time to");
    print(tempFacultyScheduleList.last.schedule_End_Time
        .add(Duration(minutes: 5)));
    return tempFacultyScheduleList.last.schedule_End_Time
        .add(Duration(minutes: 5));
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
    CollectionReference facultyRef = db
        .collection(facultyCollectionName)
        .doc(facultyEmailId)
        .collection("Schedule-List");
    CollectionReference guestRef = db
        .collection(guestCollectionName)
        .doc(guestEmailId)
        .collection("Schedule-List");

    try {
      await facultyRef.doc(scheduleUniqueId).set(
        {
          "schedule_Unque_Id": scheduleUniqueId,
          "schedule_Start_Time": startTime.toString(),
          "schedule_End_Time": endTime.toString(),
          "User_Email_Id": guestEmailId,
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
    CollectionReference facultyRef = db
        .collection(collectionName)
        .doc(userEmail)
        .collection("Schedule-List");
    facultyRef.orderBy("schedule_Start_Time", descending: true);

    List<CalendarScheduleServerInformation> list = [];
    try {
      await facultyRef.get().then(
        (ds) async {
          for (var scheduleDetails in ds.docs) {
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
          }
        },
      );

      print("UserType -> $userType");
      print(list);

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

  Future<List<CalendarScheduleServerInformation>> fetchFacultySchedules(
    BuildContext context,
  ) async {
    var currLoggedInUser = FirebaseAuth.instance.currentUser;
    var userEmailId = currLoggedInUser?.email as String;
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference facultyRef = db.collection(FACULTY_SCHEDULE_COLLECTION_NAME).doc(userEmailId).collection("Schedule-List");
    facultyRef.orderBy("schedule_Start_Time", descending: true);

    List<CalendarScheduleServerInformation> scheduleList = [];
    try {
      await facultyRef.get().then(
        (ds) async {
          for (var scheduleDetails in ds.docs) {
            final scheduleMapping = scheduleDetails.data() as Map<String, dynamic>;

            CalendarScheduleServerInformation schedule = new CalendarScheduleServerInformation(
              schedule_Unque_Id: scheduleMapping['schedule_Unque_Id'],
              schedule_Start_Time: DateTime.parse(scheduleMapping['schedule_Start_Time'].toString()),
              schedule_End_Time: DateTime.parse(scheduleMapping['schedule_End_Time'].toString()),
              User_Email_Id: scheduleMapping['User_Email_Id'],
              User_Name: scheduleMapping['User_Name'],
            );

            scheduleList.add(schedule);
          }
        },
      );
    } catch (errorVal) {
      print(errorVal);
    }
    
    return scheduleList;
  }

  Future<List<CalendarScheduleServerInformation>> fetchGuestSchedules(
    BuildContext context,
  ) async {
    var currLoggedInUser = FirebaseAuth.instance.currentUser;
    var userEmailId = currLoggedInUser?.email as String;
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference facultyRef = db.collection(GUEST_SCHEDULE_COLLECTION_NAME).doc(userEmailId).collection("Schedule-List");
    facultyRef.orderBy("schedule_Start_Time", descending: true);

    List<CalendarScheduleServerInformation> scheduleList = [];
    try {
      await facultyRef.get().then(
        (ds) async {
          for (var scheduleDetails in ds.docs) {
            final scheduleMapping = scheduleDetails.data() as Map<String, dynamic>;

            CalendarScheduleServerInformation schedule = new CalendarScheduleServerInformation(
              schedule_Unque_Id: scheduleMapping['schedule_Unque_Id'],
              schedule_Start_Time: DateTime.parse(scheduleMapping['schedule_Start_Time'].toString()),
              schedule_End_Time: DateTime.parse(scheduleMapping['schedule_End_Time'].toString()),
              User_Email_Id: scheduleMapping['User_Email_Id'],
              User_Name: scheduleMapping['User_Name'],
            );

            scheduleList.add(schedule);
          }
        },
      );
    } catch (errorVal) {
      print(errorVal);
    }

    return scheduleList;
  }

  Future<List<AppointmentUtil>> fetchListOfSchedules(
    BuildContext context,
  ) async {
    List<CalendarScheduleServerInformation> list = [];
    FirebaseFirestore db = FirebaseFirestore.instance;
    var facultyRef = await db.collection("FacultiesInformationList").doc(FirebaseAuth.instance.currentUser?.email).get();
    var guestRef = await db.collection("GuestsInformationList").doc(FirebaseAuth.instance.currentUser?.email).get();
    bool facultyExistance = facultyRef.exists;
    bool guestExistance = guestRef.exists;
    List<AppointmentUtil> retList = [];

    if(facultyExistance){
      list = await fetchFacultySchedules(context);
    }
    else if(guestExistance){
      list = await fetchGuestSchedules(context);
    }

    // if (Provider.of<UserDetailsProvider>(context, listen: false).userType == "Guest") {
    //   if(guestExistance){
    //     list = await fetchGuestSchedules(context);
    //   }
    // }
    // else {
    //   if(facultyExistance){
    //     list = await fetchFacultySchedules(context);
    //   }
    // }


    print("Appointment list : ");
    print(list);
    print("Fetching event");

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

    List<String> eventIds = [];

    for (int i = 0; i < list.length; i++) {
      print(list[i].schedule_Unque_Id);
      eventIds.add(list[i].schedule_Unque_Id);
    }

    if (events.items != null) {
      List<AppointmentUtil> tempList = [];
      for (int i = 0; i < events.items!.length; i++) {
        final tempEvent = events.items![i];

        if (tempEvent.start != null && (eventIds.contains(tempEvent.id))) {
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

          print("Event Details");
          print(tempEvent.attendees);

          if (tempEvent.attendees != null &&
              tempEvent.attendees!.isNotEmpty &&
              facultyList.contains(tempEvent.attendees![0].email.toString())) {
            faculty = await getFacultyDetails(
                tempEvent.attendees![0].email.toString());
          }


          print("Timermimriemieirm");
          print(tempEvent.summary.toString());
          print(tempEvent.start?.dateTime?.toLocal().toString());
          print(tempEvent.start?.dateTime);
          print(tempEvent.end?.dateTime);


          tempList.add(AppointmentUtil(
              tempEvent.summary.toString(),
              tempEvent.start?.dateTime?.toLocal() as DateTime,
              tempEvent.end?.dateTime?.toLocal() as DateTime,
              tempEvent.description.toString(),
              faculty,
              ""));

        }
      }
      retList = tempList;
    }
    print("Return List");
    print(retList[0].title);

    retList.sort((a, b) => a.starTime.compareTo(b.starTime));

    return retList;
  }

  //
  // Future<List<AppointmentUtil>> fetchListOfSchedules(
  //     BuildContext context,
  //     ) async {
  //   List<CalendarScheduleServerInformation> list = [];
  //   List<AppointmentUtil> retList = [];
  //   if (Provider.of<UserDetailsProvider>(context, listen: false).userType == "Guest") {
  //     list = await fetchGuestSchedules(context);
  //   }
  //   else {
  //     list = await fetchFacultySchedules(context);
  //   }
  //
  //
  //   print("Appointment list : ");
  //   print(list);
  //   print(list[0].schedule_Unque_Id);
  //
  //
  //
  //
  //
  //
  //
  //   // list.add(CalendarScheduleServerInformation(schedule_Unque_Id: "123", schedule_Start_Time: DateTime.now(), schedule_End_Time: DateTime.now().add(Duration(minutes: 50)), User_Email_Id: "henansh20065@iiitd.ac.in", User_Name: "Hello"));
  //
  //
  //
  //   // List<AppointmentUtil> list2 = [AppointmentUtil("Testing Appointment", DateTime.now(), DateTime.now().add(Duration(minutes: 50)), "Hello", FacultyServerInformation(
  //   //     faculty_Unique_Id: "null",
  //   //     faculty_Authorization: false,
  //   //     faculty_Mobile_Messaging_Token_Id: "null",
  //   //     faculty_Name: "null",
  //   //     faculty_Position: "null",
  //   //     faculty_College: "null",
  //   //     faculty_Department: "null",
  //   //     faculty_Mobile_Number: "null",
  //   //     faculty_Teaching_Interests: "null",
  //   //     faculty_Research_Interests: "null",
  //   //     faculty_Affiliated_Centers_And_Labs: "null",
  //   //     faculty_EmailId: "null",
  //   //     faculty_Gender: "null",
  //   //     faculty_Bio: "null",
  //   //     faculty_Image_Url: "null",
  //   //     faculty_LinkedIn_Url: "null",
  //   //     faculty_Website_Url: "null",
  //   //     faculty_Office_Navigation_Url: "null",
  //   //     faculty_Office_Address: "null",
  //   //     faculty_Office_Longitude: 0,
  //   //     faculty_Office_Latitude: 0), "Temp")];
  //   return retList;
  // }




  List<AppointmentUtil> appointmentList = [];
  List<String> facultyList = [
    "rahulsinghrs174326@gmail.com",
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
    "henansh20065@iiitd.ac.in"
  ];

  addEvent(
      BuildContext context,
      String name,
      DateTime startTime,
      DateTime endTime,
      List<EventAttendee> attendeesList,
      String descp,
      String location,
      String facultyName,
      String guestName) async {
    // fetchSchedules(context, "Faculty", "Faculty-Schedule-List", attendeesList[1].email.toString());

    GoogleSignIn? googleUser = await GoogleSignIn(
        scopes: ['https://www.googleapis.com/auth/calendar']);
    final GoogleSignInAccount = await googleUser.signInSilently();

    final googleAuth = await GoogleSignInAccount?.authentication;
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
      var tempEvent = await calendar.events.insert(event, 'primary',
          sendNotifications: true, sendUpdates: 'all');
      print("Hello 2");
      addNewSchedule(
          tempEvent.id.toString(),
          facultyName,
          attendeesList[1].email.toString(),
          attendeesList[0].email.toString(),
          guestName,
          startTime,
          endTime);
    } catch (e) {
      print("Error -> $e");
    }
    ;
  }

  fetchEvent(BuildContext context) async {
    print("Fetching event");

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

    List<String> eventIds = [];

    await fetchSchedules(
        context, "guest", "Guest-Schedule-List", "henanshtanwar21@gmail.com");
    print("GUEST SCHEDULE LIST");
    print(guestScheduleList);
    for (int i = 0; i < guestScheduleList.length; i++) {
      print(guestScheduleList[i].schedule_Unque_Id);
      eventIds.add(guestScheduleList[i].schedule_Unque_Id);
    }

    if (events.items != null) {
      List<AppointmentUtil> tempList = [];
      for (int i = 0; i < events.items!.length; i++) {
        final tempEvent = events.items![i];

        if (tempEvent.start != null && (eventIds.contains(tempEvent.id))) {
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

          print("Event Details");
          print(tempEvent.attendees);

          if (tempEvent.attendees != null &&
              tempEvent.attendees!.isNotEmpty &&
              facultyList.contains(tempEvent.attendees![0].email.toString())) {
            faculty = await getFacultyDetails(
                tempEvent.attendees![0].email.toString());
          }

          tempList.add(AppointmentUtil(
              tempEvent.summary.toString(),
              DateTime.now(),
              DateTime.now().add(Duration(minutes: 15)),
              tempEvent.description.toString(),
              faculty,
              ""));
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

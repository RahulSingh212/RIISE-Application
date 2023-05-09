// ignore_for_file: unused_import

import 'dart:ffi';
import 'dart:math';
import 'dart:ui' as ui;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:googleapis/calendar/v3.dart' as cal;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:riise/modules/AppointmentUtil.dart';
import 'package:riise/providers/FacultiesProvider.dart';
import 'package:riise/providers/UserDetailsProvider.dart';
import 'package:riise/screens/TabScreen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../components/SideNavBar.dart';
import '../../models/FacultyInfo.dart';
import '../../providers/CalendarAPI.dart';
import '../SingInScreen/LogInSignUpScreen.dart';

class FacultyDetailScreen extends StatefulWidget {
  static const routeName = '/riise-faculty-detail-screen';

  FacultyDetailScreen(
      {Key? key,
      // required this.position,
      required this.facultyDetails,
      this.qrIdentifier})
      : super(key: key);

  // late int position;
  late FacultyServerInformation facultyDetails;
  late String? qrIdentifier;

  @override
  State<FacultyDetailScreen> createState() => _FacultyDetailScreenState();
}

class _FacultyDetailScreenState extends State<FacultyDetailScreen> {
  String defaultProfileImage =
      "https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/DefaultImages%2Fdefault-profile-image.png?alt=media&token=b303ab47-2802-4000-bddc-2a024a6b2d24";

  late DateTime date = DateTime.now();
  late DateTime startTime = DateTime.now();
  late DateTime endTime = DateTime.now();

  bool isLoading = true;

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();

    if (widget.qrIdentifier != null) {
      widget.facultyDetails = await Provider.of<FacultiesProvider>(context)
          .getFacultyDetails(widget.qrIdentifier as String);
      isLoading = false;
    }
  }

  // late TextEditingController eventTitle = TextEditingController(text: "Guest-Faculty interaction");
  late TextEditingController eventTitle =
      TextEditingController(text: "Guest-Faculty interaction");
  late TextEditingController eventLocation =
      TextEditingController(text: widget.facultyDetails.faculty_Office_Address);
  late TextEditingController eventDescription = TextEditingController(
      text:
          "Hi, I would like to meet you to discuss your work. \n\n Thanks, \n ${FirebaseAuth.instance.currentUser?.displayName}");
  late TextEditingController eventGuest =
      TextEditingController(text: widget.facultyDetails.faculty_EmailId);
  late TextEditingController eventStartTime =
      TextEditingController(text: DateFormat("hh:mm a").format(DateTime.now()));
  late TextEditingController eventEndTime = TextEditingController(
      text: DateFormat("hh:mm a")
          .format(DateTime.now().add(Duration(minutes: 15))));

  late TextEditingController eventDate =
      TextEditingController(text: DateFormat("MMMEd").format(DateTime.now()));

  // Future loadingPopUp(BuildContext context0) async {
  //   return showDialog(
  //       context: context,
  //       builder: (ctx) => Padding(
  //         padding: EdgeInsets.fromLTRB(80.w, 80.h, 80.w, 80.h),
  //         child: AlertDialog(
  //           shape: const RoundedRectangleBorder(
  //               borderRadius: BorderRadius.all(Radius.circular(12))),
  //           contentPadding: EdgeInsets.fromLTRB(70.w, 80.h, 80.w, 0.h),
  //           content: Text("Next Available Slot has been Updated, Re-submit to book Appointment",style: TextStyle(fontSize: 40.sp),),
  //         ),
  //       ),
  //       barrierColor: Colors.black.withOpacity(0.75)
  //   );
  //
  //   // async {
  //   //   date_time temp = date_time();
  //   //   DateTime? selectedDate =
  //   //   await temp.selectDate(context);
  //   //   TimeOfDay? selectedTime =
  //   //   await temp.selectTime(context);
  //   //   setState(
  //   //         () {
  //   //       if (selectedDate == null ||
  //   //           selectedTime == null) {
  //   //         return;
  //   //       }
  //   //       Date_Time = DateTime(
  //   //         selectedDate.year,
  //   //         selectedDate.month,
  //   //         selectedDate.day,
  //   //         selectedTime.hour,
  //   //         selectedTime.minute,
  //   //       );
  //   //
  //   //       _DayDate_Controller.text =
  //   //           DateFormat('hh:mm a, MMM dd')
  //   //               .format(Date_Time);
  //   //       // print(_DayDate_Controller.text);
  //   //     },
  //   //   );
  //   // },
  // }

  Future showTimeConflictPopUp(BuildContext context0) async {
    return showDialog(
        context: context,
        builder: (ctx) => Padding(
              padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 20.h),
              child: AlertDialog(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                title: TextField(
                  controller: TextEditingController(text: "Book Appointment"),
                  style: TextStyle(fontSize: 55.sp),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Title",
                    suffixIcon: ClipOval(
                      child: Image.network(
                        widget.facultyDetails.faculty_Image_Url == ""
                            ? defaultProfileImage
                            : widget.facultyDetails.faculty_Image_Url,
                        width: 25.r,
                        height: 25.r,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  enabled: false,
                ),
                titlePadding: EdgeInsets.fromLTRB(60.w, 60.h, 80.w, 0.h),
                contentPadding: EdgeInsets.fromLTRB(70.w, 80.h, 80.w, 0.h),
                content: Text(
                  "Next Available Slot has been Updated, Re-submit to book Appointment",
                  style: TextStyle(fontSize: 40.sp),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      child: const Text("Okay"),
                    ),
                  ),
                ],
              ),
            ),
        barrierColor: Colors.black.withOpacity(0.75));

    // async {
    //   date_time temp = date_time();
    //   DateTime? selectedDate =
    //   await temp.selectDate(context);
    //   TimeOfDay? selectedTime =
    //   await temp.selectTime(context);
    //   setState(
    //         () {
    //       if (selectedDate == null ||
    //           selectedTime == null) {
    //         return;
    //       }
    //       Date_Time = DateTime(
    //         selectedDate.year,
    //         selectedDate.month,
    //         selectedDate.day,
    //         selectedTime.hour,
    //         selectedTime.minute,
    //       );
    //
    //       _DayDate_Controller.text =
    //           DateFormat('hh:mm a, MMM dd')
    //               .format(Date_Time);
    //       // print(_DayDate_Controller.text);
    //     },
    //   );
    // },
  }

  Future showPopUp(BuildContext context0) async {
    return await showDialog(
        context: context0,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return SimpleDialog(
              // elevation: 16,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    12,
                  ),
                ),
              ),
              title: TextField(
                controller: TextEditingController(text: "Book Appointment"),
                style: TextStyle(fontSize: 55.sp),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Title",
                  suffixIcon: ClipOval(
                    child: Image.network(
                      widget.facultyDetails.faculty_Image_Url == ""
                          ? defaultProfileImage
                          : widget.facultyDetails.faculty_Image_Url,
                      width: 25.r,
                      height: 25.r,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                enabled: false,
              ),
              titlePadding: EdgeInsets.fromLTRB(60.w, 60.h, 80.w, 0.h),
              contentPadding: EdgeInsets.fromLTRB(70.w, 40.h, 80.w, 60.h),
              children: [
                textFieldBuilder(
                    eventTitle, "Title", Icons.messenger, false, 1),
                InkWell(
                  onTap: () {
                    setState(() {
                      _presentDatePicker(context, eventDate, date);
                    });
                  },
                  child: textFieldBuilder(eventDate, "Date",
                      CupertinoIcons.calendar_badge_plus, true, 1),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      print("Before : $startTime");
                      _presentTimePicker(context, eventStartTime, eventEndTime,
                          startTime, endTime);
                      print("After : $startTime");
                      print("After END : $endTime");
                    });
                  },
                  child: textFieldBuilder(eventStartTime, "Start Time",
                      CupertinoIcons.clock, true, 1),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      print("Before : $endTime");
                      _presentTimePicker(
                          context, eventEndTime, null, endTime, null);
                      print("After : $endTime");
                    });
                  },
                  child: textFieldBuilder(
                      eventEndTime, "End Time", CupertinoIcons.clock, true, 1),
                ),
                // Center(
                //   child: Container(
                //     padding: EdgeInsets.only(
                //         left: 20.w, right: 20.w, top: 40.h, bottom: 40.h),
                //     width: 920.w,
                //     child: InkWell(
                //       onTap: () {
                //         _presentTimePicker(context, startTime);
                //       },
                //       child: TextField(
                //         controller: eventStartTime,
                //         enabled: false,
                //         maxLines: null,
                //         decoration: InputDecoration(
                //           // contentPadding: EdgeInsets.fromLTRB(0, 12, 0, 0),
                //           isDense: true,
                //           labelText: "Start Time",
                //           helperMaxLines: null,
                //           border: OutlineInputBorder(),
                //           enabledBorder: OutlineInputBorder(
                //             borderSide: const BorderSide(
                //               color: Colors.black38,
                //             ),
                //             borderRadius: BorderRadius.circular(8),
                //           ),
                //           disabledBorder: OutlineInputBorder(
                //             borderSide: const BorderSide(
                //               color: Colors.black38,
                //             ),
                //             borderRadius: BorderRadius.circular(8),
                //           ),
                //           focusedBorder: OutlineInputBorder(
                //             borderSide: const BorderSide(
                //               color: Colors.blue,
                //             ),
                //             borderRadius: BorderRadius.circular(8),
                //           ),
                //           labelStyle: TextStyle(
                //               fontFamily: 'Roboto',
                //               fontWeight: FontWeight.w400,
                //               fontSize: 50.sp,
                //               fontStyle: FontStyle.normal,
                //               color: Colors.black87),
                //           prefixIcon: IconButton(
                //             icon: Icon(CupertinoIcons.clock),
                //             color: Colors.blue,
                //             onPressed: () {
                //               // setState(() {
                //               //   recentSearch.insert(0, searchBarController.text);
                //               //   if (recentSearch.length > 5) {
                //               //     recentSearch.removeLast();
                //               //   }
                //               // });
                //               print("Search Pressed");
                //             },
                //           ),
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                // Text(
                //   "Select Appointment Duration",
                //   style: TextStyle(fontSize: 40.sp),
                // ),
                // Center(
                //   child: Row(
                //     mainAxisSize: MainAxisSize.max,
                //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                //     children: [
                //       Column(
                //         children: [
                //           Text("Start Time"),
                //
                //         ],
                //       ),
                //       Column(
                //         children: [
                //           Text("End Time"),
                //           OutlinedButton(
                //             child: Text(endTime.hour.toString() +
                //                 " : " +
                //                 endTime.minute.toString() +
                //                 " " +
                //                 endTime.period.name),
                //             onPressed: () {
                //               _presentTimePicker(context, startTime);
                //             },
                //           ),
                //         ],
                //       ),
                //     ],
                //   ),
                // ),
                // Center(
                //   child: ElevatedButton(
                //     child: Text("Date : ${DateFormat.yMd().format(date)}"),
                //     onPressed: () {
                //       setState(() {
                //         _presentDatePicker(context);
                //       });
                //     },
                //   ),
                // ),
                textFieldBuilder(eventGuest, "Guest", Icons.messenger, true, 1),
                textFieldBuilder(eventLocation, "Location",
                    Icons.location_on_outlined, true, 1),
                textFieldBuilder(eventDescription, "Description",
                    Icons.messenger, false, 10),
                Center(
                  child: OutlinedButton(
                    onPressed: () async {
                      print("Submit");
                      List<cal.EventAttendee> attendeeEmailList = [
                        cal.EventAttendee(
                            email: FirebaseAuth.instance.currentUser?.email
                                .toString()),
                        cal.EventAttendee(email: eventGuest.text)
                      ];
                      print("Hey its me, calling calendar event function");
                      DateTime tempDate01 =
                          DateFormat("MMMEd").parse(eventDate.text);
                      DateTime tempTime01 =
                          DateFormat("hh:mm a").parse(eventStartTime.text);
                      DateTime tempTime02 =
                          DateFormat("hh:mm a").parse(eventEndTime.text);
                      DateTime tempStartTime = DateTime(
                        2023,
                        tempDate01.month,
                        tempDate01.day,
                        tempTime01.hour,
                        tempTime01.minute,
                      );
                      DateTime tempEndTime = DateTime(
                        2023,
                        tempDate01.month,
                        tempDate01.day,
                        tempTime02.hour,
                        tempTime02.minute,
                      );
                      await Provider.of<CalenderAPI>(context0, listen: false)
                          .fetchSchedules(
                        context,
                        "Faculty",
                        "Faculty-Schedule-List",
                        widget.facultyDetails.faculty_EmailId,
                      );
                      if (await Provider.of<CalenderAPI>(context0,
                              listen: false)
                          .checkForFacultyScheduleConflicts(
                              context0, tempStartTime, tempEndTime)) {
                        await CalenderAPI().addEvent(
                            context,
                            eventTitle.text,
                            tempStartTime,
                            tempEndTime,
                            attendeeEmailList,
                            eventDescription.text,
                            eventLocation.text,
                            widget.facultyDetails.faculty_Name,
                            Provider.of<UserDetailsProvider>(context0,
                                    listen: false)
                                .userMapping['guest_Name']!);
                        Navigator.of(context).pop();
                        Navigator.of(context0).pushAndRemoveUntil(MaterialPageRoute(builder: (_)=>TabScreen()), (route) => false);
                      } else {
                        await Provider.of<CalenderAPI>(context0, listen: false)
                            .fetchSchedules(
                          context,
                          "Faculty",
                          "Faculty-Schedule-List",
                          widget.facultyDetails.faculty_EmailId,
                        );
                        print("Time Unavailable");
                        DateTime tempTime =
                            Provider.of<CalenderAPI>(context0, listen: false)
                                .getForFacultyScheduleInterval(context0);
                        print("Time set to - > ${tempTime}");
                        setState(() {
                          eventStartTime.text =
                              DateFormat("hh:mm a").format(tempTime);
                          eventDate.text = DateFormat("MMMEd").format(tempTime);
                          startTime = tempTime;
                          eventEndTime.text = DateFormat("hh:mm a")
                              .format(startTime.add(Duration(minutes: 15)));
                          startTime = startTime.add(Duration(minutes: 15));
                        });
                        showTimeConflictPopUp(context);
                      }

                      // await CalenderAPI().addEvent(context,"TEST 2",DateTime.now().add(Duration(hours: 3, minutes: 30)),DateTime.now().add(Duration(hours: 4, minutes: 30)));
                      // await CalenderAPI().addEvent(context,"TEST 3",DateTime.now().add(Duration(hours: 5, minutes: 30)),DateTime.now().add(Duration(hours: 6, minutes: 30)));
                      // final map = await Provider.of<SecureStorage>(context,listen: false).getFromStorage();
                    },
                    style: ButtonStyle(
                        padding: MaterialStatePropertyAll<EdgeInsetsGeometry>(
                            EdgeInsets.symmetric(
                                horizontal: 45.w, vertical: 25.h)),
                        shape: MaterialStatePropertyAll<OutlinedBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)))),
                    child: Container(
                      child: Text(
                        "Submit",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black, fontSize: 45.sp),
                      ),
                    ),
                  ),
                ),
              ],
            );
          });
        },
        barrierColor: Colors.black.withOpacity(0.75));

    // async {
    //   date_time temp = date_time();
    //   DateTime? selectedDate =
    //   await temp.selectDate(context);
    //   TimeOfDay? selectedTime =
    //   await temp.selectTime(context);
    //   setState(
    //         () {
    //       if (selectedDate == null ||
    //           selectedTime == null) {
    //         return;
    //       }
    //       Date_Time = DateTime(
    //         selectedDate.year,
    //         selectedDate.month,
    //         selectedDate.day,
    //         selectedTime.hour,
    //         selectedTime.minute,
    //       );
    //
    //       _DayDate_Controller.text =
    //           DateFormat('hh:mm a, MMM dd')
    //               .format(Date_Time);
    //       // print(_DayDate_Controller.text);
    //     },
    //   );
    // },
  }

  @override
  Widget build(BuildContext context) {
    print("QR IDENTIFIER = ${widget.qrIdentifier}");

    List<String> researchInterests =
        convertStrToList(widget.facultyDetails.faculty_Research_Interests);
    List<String> teachingInterests =
        convertStrToList(widget.facultyDetails.faculty_Teaching_Interests);
    List<String> centresLabs = convertStrToList(
        widget.facultyDetails.faculty_Affiliated_Centers_And_Labs);
    // print("RESEARCH INTERESTS -> " +researchInterests.length.toString());
    // print("TEACHING INTERESTS -> " +teachingInterests.length.toString());
    // print("CENTRES LABS -> " +centresLabs.length.toString());

    return Scaffold(
        backgroundColor: Colors.white,
        extendBodyBehindAppBar: true,
        // drawer: SideNavBar(),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text(
            "Faculty",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 60.sp,
            ),
            textAlign: TextAlign.center,
          ),
          iconTheme: IconThemeData(
            color: Colors.blue,
            size: 80.r,
          ),
          actions: [
            Container(
              padding: EdgeInsets.only(top: 15.h, bottom: 25.h, right: 20.w),
              child: Center(
                child: Image.network(
                  "https://www.iiitd.ac.in/sites/default/files/images/logo/style1colorlarge.jpg",
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
        body: Container(
          padding: EdgeInsets.only(top: 280.h, left: 20.w, right: 20.w),
          margin: EdgeInsets.symmetric(horizontal: 30.w),
          child: (isLoading && widget.qrIdentifier != null)
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 30.w),
                        alignment: Alignment.center,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(width: 3),
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.grey),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  widget.facultyDetails.faculty_Image_Url == ""
                                      ? defaultProfileImage
                                      : widget.facultyDetails.faculty_Image_Url,
                                  width: 450.r,
                                  height: 450.r,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Flexible(
                              child: Text(
                                widget.facultyDetails.faculty_Name,
                                style: TextStyle(fontSize: 70.sp),
                                softWrap: true,
                                textAlign: TextAlign.center,
                                // maxLines: 100,
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            widget.facultyDetails.faculty_Position == ""
                                ? Container()
                                : Flexible(
                                    child: Text(
                                      "${widget.facultyDetails.faculty_Position} (${widget.facultyDetails.faculty_Department})",
                                      style: TextStyle(
                                        fontSize: 40.sp,
                                      ),
                                      softWrap: true,
                                      textAlign: TextAlign.center,
                                      // maxLines: 100,
                                    ),
                                  ),
                            SizedBox(
                              height: 60.h,
                            ),

                            FirebaseAuth.instance.currentUser != null
                                ? StreamBuilder(
                                    stream: checkUserType().asStream(),
                                    builder: (BuildContext ctx,
                                        AsyncSnapshot snapshot) {
                                      if (!snapshot.hasData) {
                                        return CircularProgressIndicator();
                                      } else {
                                        if(snapshot.data){
                                          return ElevatedButton(
                                            onPressed: () async {
                                              showPopUp(context);
                                            },
                                            child: Text(
                                              "Book Appointment",
                                            ),
                                          );
                                        }
                                        else{
                                          return SizedBox();
                                        }
                                      }
                                    })
                                : ElevatedButton.icon(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              LogInSignUpScreen(),
                                        ),
                                      );
                                    },
                                    icon: Icon(
                                      Icons.login_rounded,
                                    ),
                                    label: Text("Login to book appointment"),
                                  ),

                            // Provider.of<UserDetailsProvider>(context,
                            //                 listen: false)
                            //             .userType !=
                            //         "Faculty"
                            //     ? FirebaseAuth.instance.currentUser != null
                            //         ? ElevatedButton(
                            //             onPressed: () async {
                            //               showPopUp(context);
                            //             },
                            //             child: Text(
                            //               "Book Appointment",
                            //             ),
                            //           )
                            //         : ElevatedButton.icon(
                            //             onPressed: () {
                            //               Navigator.of(context).push(
                            //                 MaterialPageRoute(
                            //                   builder: (context) =>
                            //                       LogInSignUpScreen(),
                            //                 ),
                            //               );
                            //             },
                            //             icon: Icon(
                            //               Icons.login_rounded,
                            //             ),
                            //             label:
                            //                 Text("Login to book appointment"),
                            //           )
                            //     : SizedBox(),
                            SizedBox(
                              height: 80.h,
                            ),
                            widget.facultyDetails.faculty_College == ""
                                ? Container()
                                : Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.cast_for_education,
                                        // size: ,
                                      ),
                                      SizedBox(
                                        width: 20.h,
                                      ),
                                      Flexible(
                                        child: Text(
                                          widget.facultyDetails.faculty_College,
                                          style: TextStyle(fontSize: 40.sp),
                                          softWrap: true,
                                          textAlign: TextAlign.center,
                                          // maxLines: 100,
                                        ),
                                      ),
                                    ],
                                  ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.email_outlined,
                                  // size: ,
                                ),
                                SizedBox(
                                  width: 20.w,
                                ),
                                Flexible(
                                  child: InkWell(
                                    onTap: () {
                                      launchUrlString(
                                          'https://calendar.google.com/calendar/u/0/r/eventedit?state=%5Bnull%2Cnull%2Cnull%2Cnull%2C%5B13%5D%5D&tab=wc',
                                          mode: LaunchMode.externalApplication);
                                      // https://calendar.google.com/calendar/r
                                      // print("Hello THERE");
                                      // launchUrlString(
                                      //     'https://calendar.google.com/calendar/r',
                                      //     mode: LaunchMode.externalApplication);
                                    },
                                    child: Text(
                                      widget.facultyDetails.faculty_EmailId,
                                      style: TextStyle(
                                          fontSize: 40.sp,
                                          color: Colors.blueAccent),
                                      softWrap: true,
                                      textAlign: TextAlign.center,
                                      // maxLines: 100,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 120.w,
                                ),
                                widget.facultyDetails.faculty_Mobile_Number ==
                                        ""
                                    ? Container()
                                    : Icon(
                                        Icons.call,
                                        // size: ,
                                      ),
                                SizedBox(
                                  width: 20.w,
                                ),
                                widget.facultyDetails.faculty_Mobile_Number ==
                                        ""
                                    ? Container()
                                    : Flexible(
                                        child: InkWell(
                                          onTap: () {
                                            launchUrlString(
                                                'tel:${widget.facultyDetails.faculty_Mobile_Number}',
                                                mode: LaunchMode
                                                    .externalApplication);
                                          },
                                          child: Text(
                                            widget.facultyDetails
                                                .faculty_Mobile_Number,
                                            style: TextStyle(
                                                fontSize: 40.sp,
                                                color: Colors.blueAccent),
                                            softWrap: true,
                                            textAlign: TextAlign.center,
                                            // maxLines: 100,
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                widget.facultyDetails.faculty_Website_Url == ""
                                    ? Container()
                                    : Icon(
                                        CupertinoIcons.globe,
                                        // size: ,
                                      ),
                                widget.facultyDetails.faculty_Website_Url == ""
                                    ? Container()
                                    : Flexible(
                                        child: InkWell(
                                          onTap: () {
                                            launchUrlString(
                                                widget.facultyDetails
                                                    .faculty_Website_Url,
                                                mode: LaunchMode
                                                    .externalApplication);
                                          },
                                          child: Text(
                                            "WebPage",
                                            style: TextStyle(
                                                fontSize: 40.sp,
                                                color: Colors.blueAccent),
                                            softWrap: true,
                                            textAlign: TextAlign.center,
                                            // maxLines: 100,
                                          ),
                                        ),
                                      ),
                                SizedBox(
                                  width: 120.w,
                                ),
                                widget.facultyDetails.faculty_Office_Latitude ==
                                        0.0
                                    ? Container()
                                    : Icon(
                                        Icons.location_on_outlined,
                                        // size: ,
                                      ),
                                widget.facultyDetails.faculty_Office_Latitude ==
                                        0.0
                                    ? Container()
                                    : Flexible(
                                        child: InkWell(
                                          onTap: () {
                                            _launchDirectionsUrl(
                                                widget.facultyDetails
                                                    .faculty_Office_Latitude
                                                    .toString(),
                                                widget.facultyDetails
                                                    .faculty_Office_Longitude
                                                    .toString());
                                          },
                                          child: Text(
                                            widget.facultyDetails
                                                .faculty_Office_Address,
                                            style: TextStyle(
                                                fontSize: 40.sp,
                                                color: Colors.blueAccent),
                                            softWrap: true,
                                            textAlign: TextAlign.center,
                                            // maxLines: 100,
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 60.h,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          widget.facultyDetails.faculty_Bio == ""
                              ? Container()
                              : Text(
                                  "About",
                                  style: TextStyle(fontSize: 60.sp),
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                ),
                          SizedBox(
                            height: 40.h,
                          ),
                          widget.facultyDetails.faculty_Bio == ""
                              ? Container()
                              : Flexible(
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 45.w),
                                    child: Text(
                                      widget.facultyDetails.faculty_Bio,
                                      style: TextStyle(fontSize: 33.sp),
                                      softWrap: true,
                                      textAlign: TextAlign.justify,
                                      // maxLines: 100,
                                    ),
                                  ),
                                ),
                        ],
                      ),
                      SizedBox(
                        height: 60.h,
                      ),
                      Container(
                        alignment: Alignment.topCenter,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            researchInterests.length == 1
                                ? Container()
                                : Text(
                                    "Research Interests",
                                    style: TextStyle(fontSize: 60.sp),
                                    softWrap: true,
                                    textAlign: TextAlign.center,
                                  ),
                            researchInterests.length == 1
                                ? Container()
                                : ListView.builder(
                                    shrinkWrap: true,
                                    padding:
                                        EdgeInsets.symmetric(vertical: 40.h),
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, position) {
                                      return Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 50.w),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Icon(CupertinoIcons
                                                .hand_point_right),
                                            SizedBox(
                                              width: 50.w,
                                            ),
                                            Flexible(
                                                child: Text(
                                              researchInterests[position],
                                              style: TextStyle(fontSize: 40.sp),
                                              softWrap: true,
                                            ))
                                          ],
                                        ),
                                      );
                                    },
                                    itemCount: researchInterests.length,
                                  ),
                            teachingInterests.length == 1
                                ? Container()
                                : Text(
                                    "Teaching Interests",
                                    style: TextStyle(fontSize: 60.sp),
                                    softWrap: true,
                                    textAlign: TextAlign.center,
                                  ),
                            teachingInterests.length == 1
                                ? Container()
                                : ListView.builder(
                                    shrinkWrap: true,
                                    padding:
                                        EdgeInsets.symmetric(vertical: 40.h),
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, position) {
                                      return Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 50.w),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Icon(CupertinoIcons
                                                .hand_point_right),
                                            SizedBox(
                                              width: 50.w,
                                            ),
                                            Flexible(
                                                child: Text(
                                              teachingInterests[position],
                                              style: TextStyle(fontSize: 40.sp),
                                              softWrap: true,
                                            ))
                                          ],
                                        ),
                                      );
                                    },
                                    itemCount: teachingInterests.length,
                                  ),
                            centresLabs.length == 1
                                ? Container()
                                : Text(
                                    "Affiliated Centres & Labs",
                                    style: TextStyle(fontSize: 60.sp),
                                    softWrap: true,
                                    textAlign: TextAlign.center,
                                  ),
                            centresLabs.length == 1
                                ? Container()
                                : ListView.builder(
                                    shrinkWrap: true,
                                    padding:
                                        EdgeInsets.symmetric(vertical: 40.h),
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, position) {
                                      return Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 50.w),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Icon(CupertinoIcons
                                                .hand_point_right),
                                            SizedBox(
                                              width: 50.w,
                                            ),
                                            Flexible(
                                                child: Text(
                                              centresLabs[position],
                                              style: TextStyle(fontSize: 40.sp),
                                              softWrap: true,
                                            ))
                                          ],
                                        ),
                                      );
                                    },
                                    itemCount: centresLabs.length,
                                  ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
        ));
  }

  convertStrToList(String str) {
    return str.split(',');
  }

  Future<void> _launchDirectionsUrl(
      String coordinateLatitude, String coordinateLongitude) async {
    Uri url = Uri.parse(
        'https://www.google.com/maps/dir/?api=1&destination=$coordinateLatitude,$coordinateLongitude&travelmode=walking');

    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  Widget textFieldBuilder(TextEditingController controller, String label,
      IconData icon, bool enabled, int maxLines) {
    return Center(
      child: Container(
        padding:
            EdgeInsets.only(left: 20.w, right: 20.w, top: 40.h, bottom: 40.h),
        width: 920.w,
        child: TextField(
          controller: controller,
          onChanged: (value) => {
            setState(() {
              // filterValue = value;
              print(value);
            })
          },
          minLines: label == "Description" ? 3 : 1,
          enabled: !enabled,
          maxLines: !enabled ? null : 1,
          decoration: InputDecoration(
            // contentPadding: EdgeInsets.fromLTRB(0, 12, 0, 0),
            isDense: true,
            labelText: label,
            helperMaxLines: null,
            border: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.black38,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.black38,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.blue,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            labelStyle: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                fontSize: 50.sp,
                fontStyle: FontStyle.normal,
                color: Colors.black87),
            prefixIcon: IconButton(
              icon: Icon(icon),
              color: Colors.blue,
              onPressed: () {
                // setState(() {
                //   recentSearch.insert(0, searchBarController.text);
                //   if (recentSearch.length > 5) {
                //     recentSearch.removeLast();
                //   }
                // });
                print("Search Pressed");
              },
            ),
          ),
        ),
      ),
    );
  }

  void _presentTimePicker(
      BuildContext context,
      TextEditingController controller,
      TextEditingController? controller2,
      DateTime time,
      DateTime? time2) async {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }

    TimeOfDay timeChosen = TimeOfDay.now();
    TimeOfDay? temptime = await showTimePicker(
      context: context,
      initialTime: timeChosen,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData(primaryColor: Color(0xff42CCC3)),
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(
              alwaysUse24HourFormat: false,
            ),
            child: Directionality(
              textDirection: ui.TextDirection.ltr,
              child: child!,
            ),
          ),
        );
      },
    );
    if (temptime != null) {
      setState(() {
        print("TIME -> $temptime");
        DateTime tempTime2 = DateTime(0)
            .add(Duration(hours: temptime.hour, minutes: temptime.minute));
        controller.text = DateFormat("hh:mm a").format(tempTime2);
        print(controller.text);
        time = tempTime2;
        print("Inside : $time");

        if (time2 != null) {
          time2 = time.add(Duration(minutes: 15));
          controller2!.text = DateFormat("hh:mm a").format(time2!);
          print("Inside 2  : $time2");
        }
      });
    }
  }

  void _presentDatePicker(BuildContext context,
      TextEditingController controller, DateTime date) async {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }

    DateTime lastPickingDate = DateTime.now().add(new Duration(days: 365));

    await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      initialDate: DateTime.now(),
      lastDate: lastPickingDate,
    ).then((pickedDate) {
      if (pickedDate != null) {
        setState(() {
          controller.text = DateFormat("MMMEd").format(pickedDate);
          date = pickedDate;
        });
      }
    });
  }

  Future<bool> checkUserType() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    var facultyRef = await db
        .collection("FacultiesInformationList")
        .doc(FirebaseAuth.instance.currentUser?.email)
        .get();
    var guestRef = await db
        .collection("GuestsInformationList")
        .doc(FirebaseAuth.instance.currentUser?.email)
        .get();
    bool facultyExistance = facultyRef.exists;
    bool guestExistance = guestRef.exists;

    return guestExistance;
  }
}

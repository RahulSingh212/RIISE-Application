// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, unused_import, unnecessary_import, duplicate_import, unused_local_variable, deprecated_member_use, file_names, unnecessary_new, unnecessary_this, unused_field, prefer_final_fields, sized_box_for_whitespace, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, avoid_print, unused_element

import 'dart:async';
import 'dart:math';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import "../../providers/AddSectionsProvider.dart";
import '../../models/SpeakerInfo.dart';
import './AddNewSpeakerForEventScreen.dart';

class AddNewKeyNoteSpeakerScreen extends StatefulWidget {
  const AddNewKeyNoteSpeakerScreen({super.key});
  static const routeName = '/rise-add-new-key-note-speaker-screen';

  @override
  State<AddNewKeyNoteSpeakerScreen> createState() =>
      _AddNewKeyNoteSpeakerScreenState();
}

class _AddNewKeyNoteSpeakerScreenState
    extends State<AddNewKeyNoteSpeakerScreen> {
  bool _isDateSelected = false;
  Map<String, dynamic> speakerProfileMapping = {
    "speaker_Unique_Id": "Unique_Id",
    "speaker_Name": TextEditingController(),
    "speaker_Position": TextEditingController(),
    "speaker_Talk_Title": TextEditingController(),
    "speaker_Abstract": TextEditingController(),
    "speaker_Bio": TextEditingController(),
    "speaker_Start_Time": TimeOfDay.now(),
    "speaker_End_Time": TimeOfDay.now(),
    "speaker_Date": DateTime.now(),
    "speaker_Image_File": File(""),
    "speaker_LinkedIn_Url": TextEditingController(),
    "speaker_Website_Url": TextEditingController(),
  };

  Map<String, bool> speakerInfoCheckMapping = {
    "speaker_Image_File": false,
    "speaker_Date": false,
    "speaker_Start_Time": false,
    "speaker_End_Time": false,
    "speaker_Name": false,
    "speaker_Position": false,
    "speaker_Talk_Title": false,
    "speaker_Abstract": false,
    "speaker_Bio": false,
  };

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;
    var minDimension = min(screenWidth, screenHeight);
    var maxDimension = max(screenWidth, screenHeight);

    return Scaffold(
      backgroundColor: Color(0xFFf2f3f4),
      appBar: AppBar(
        elevation: 5,
        leading: IconButton(
          enableFeedback: false,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_circle_left,
            color: Color(0xff42ccc3),
            size: 35,
          ),
        ),
        title: Text(
          "Keynote Speaker Details",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 22,
          ),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          Align(
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: 15,
              ),
              height: minDimension * 0.4,
              width: minDimension * 0.35,
              // decoration: BoxDecoration(
              //   color: Colors.yellow,
              // ),
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: screenWidth,
                child: CircleAvatar(
                  radius: screenWidth * 0.6,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      screenWidth * 0.2,
                    ),
                    child: ClipOval(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: speakerInfoCheckMapping["speaker_Image_File"] ==
                                false
                            ? Image.asset(
                                "assets/images/icons/profile.png",
                              )
                            : Image.file(
                                speakerProfileMapping["speaker_Image_File"],
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Align(
            child: InkWell(
              onTap: () async {
                FocusScopeNode currentFocus = FocusScope.of(context);

                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
                final picker = ImagePicker();
                final imageFile = await picker.getImage(
                  source: ImageSource.gallery,
                  imageQuality: 80,
                  maxHeight: 650,
                  maxWidth: 650,
                );

                if (imageFile == null) {
                  return;
                }

                setState(() {
                  speakerProfileMapping["speaker_Image_File"] =
                      File(imageFile.path);
                  // _isProfilePicTaken = true;
                  speakerInfoCheckMapping["speaker_Image_File"] = true;
                });
              },
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(12.5),
                width: minDimension * 0.55,
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  speakerInfoCheckMapping["speaker_Image_File"] == false
                      ? "Add Speaker Image"
                      : "Change Speaker Image",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.05,
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: screenWidth * 0.95,
              child: Text(
                "Speaker's Time Interval:",
                style: TextStyle(
                  fontWeight: ui.FontWeight.bold,
                  fontSize: screenWidth * 0.05,
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.025,
              vertical: screenHeight * 0.0125,
            ),
            height: screenHeight * 0.125,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: screenHeight * 0.1,
                  child: Column(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          _presentTimePicker(context, 0);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: screenWidth * 0.325,
                          height: screenHeight * 0.06,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              width: 2,
                              color: Color(0xffCDCDCD),
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: screenWidth * 0.025,
                            horizontal: screenWidth * 0.05,
                          ),
                          child: Text(
                            "${speakerProfileMapping["speaker_Start_Time"].format(context)}",
                          ),
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.004,
                      ),
                      Container(
                        child: Text("Start"),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 1,
                  width: 20,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xffCDCDCD),
                      width: 1.5,
                    ),
                  ),
                ),
                Container(
                  height: screenHeight * 0.1,
                  child: Column(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          _presentTimePicker(context, 1);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: screenWidth * 0.325,
                          height: screenHeight * 0.06,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              width: 2,
                              color: Color(0xffCDCDCD),
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: screenWidth * 0.025,
                            horizontal: screenWidth * 0.05,
                          ),
                          child: Text(
                            "${speakerProfileMapping["speaker_End_Time"].format(context)}",
                          ),
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.004,
                      ),
                      Container(
                        child: Text("End"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: screenHeight * 0.01,
          ),
          Align(
            child: Container(
              width: screenWidth * 0.95,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    !_isDateSelected
                        ? "Select event date: "
                        : "Change event date: ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17.5,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      _presentDatePicker(context);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.0025,
                      ),
                      height: screenHeight * 0.04,
                      width: screenHeight * 0.04,
                      decoration: BoxDecoration(
                          // color: Color.fromRGBO(66, 204, 195, 1),
                          ),
                      child: Image(
                        fit: BoxFit.fill,
                        image: AssetImage(
                          "assets/images/icons/Calendar.png",
                        ),
                        // color: Color.fromRGBO(66, 204, 195, 1),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.005,
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: screenWidth * 0.95,
              child: Text.rich(
                TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Selected Date: ',
                      style: TextStyle(
                        color: Color.fromRGBO(108, 117, 125, 1),
                      ),
                    ),
                    TextSpan(
                      text: _isDateSelected
                          ? '${DateFormat.yMMMMd('en_US').format(speakerProfileMapping["speaker_Date"] as DateTime)}'
                          : "No Date Selected",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(108, 117, 125, 1),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.015,
          ),
          TextFieldContainer(
            context,
            "Name",
            "Enter speaker's name",
            1,
            1,
            speakerProfileMapping,
            "speaker_Name",
            TextInputType.name,
          ),
          TextFieldContainer(
            context,
            "Position",
            "Enter speaker's position",
            1,
            1,
            speakerProfileMapping,
            "speaker_Position",
            TextInputType.name,
          ),
          TextFieldContainer(
            context,
            "Talk Title",
            "Enter speaker's talk title",
            1,
            1,
            speakerProfileMapping,
            "speaker_Talk_Title",
            TextInputType.name,
          ),
          TextFieldContainer(
            context,
            "Abstract",
            "Enter speaker's abstract",
            3,
            4,
            speakerProfileMapping,
            "speaker_Abstract",
            TextInputType.name,
          ),
          TextFieldContainer(
            context,
            "Bio",
            "Enter speaker's bio",
            4,
            6,
            speakerProfileMapping,
            "speaker_Bio",
            TextInputType.name,
          ),
          TextFieldContainer(
            context,
            "LinkedIn Url",
            "Enter speaker's LinkedIn URL",
            1,
            1,
            speakerProfileMapping,
            "speaker_LinkedIn_Url",
            TextInputType.name,
          ),
          TextFieldContainer(
            context,
            "Speaker Website Url",
            "Enter speaker's Website URL",
            1,
            1,
            speakerProfileMapping,
            "speaker_Website_Url",
            TextInputType.name,
          ),
          SizedBox(
            height: screenHeight * 0.025,
          ),
          Align(
            child: InkWell(
              onTap: () {
                if (speakerInfoCheckMapping["speaker_Image_File"] == false) {
                  String titleText = "Invalid speaker image";
                  String contextText = "Select a speaker's image";
                  _checkForError(
                    context,
                    titleText,
                    contextText,
                  );
                } else if (speakerProfileMapping["speaker_Name"].text.length <
                    5) {
                  String titleText = "Invalid speaker name";
                  String contextText =
                      "Spaker's name must be at least 5 characters";
                  _checkForError(
                    context,
                    titleText,
                    contextText,
                  );
                } 
                else if (speakerProfileMapping["speaker_Position"]
                        .text
                        .length <
                    5) {
                  String titleText = "Invalid speaker position";
                  String contextText =
                      "Spaker's position must be at least 5 characters";
                  _checkForError(
                    context,
                    titleText,
                    contextText,
                  );
                }
                // else if (speakerProfileMapping["speaker_Talk_Title"]
                //         .text
                //         .length <
                //     5) {
                //   String titleText = "Invalid speaker talk title";
                //   String contextText =
                //       "Spaker's talk title must be at least 5 characters";
                //   _checkForError(
                //     context,
                //     titleText,
                //     contextText,
                //   );
                // }
                // else if (speakerProfileMapping["speaker_Abstract"]
                //         .text
                //         .length <
                //     5) {
                //   String titleText = "Invalid speaker abstract";
                //   String contextText =
                //       "Spaker's abstract must be at least 5 characters";
                //   _checkForError(
                //     context,
                //     titleText,
                //     contextText,
                //   );
                // } 
                else if (speakerProfileMapping["speaker_Bio"].text.length <
                    5) {
                  String titleText = "Invalid speaker bio";
                  String contextText =
                      "Spaker's bio must be at least 5 characters";
                  _checkForError(
                    context,
                    titleText,
                    contextText,
                  );
                } 
                else if (speakerInfoCheckMapping["speaker_Start_Time"] ==
                    false) {
                  String titleText = "Invalid start time";
                  String contextText = "Select the start time";
                  _checkForError(
                    context,
                    titleText,
                    contextText,
                  );
                } 
                else if (speakerInfoCheckMapping["speaker_End_Time"] ==
                    false) {
                  String titleText = "Invalid end time";
                  String contextText = "Select the end time";
                  _checkForError(
                    context,
                    titleText,
                    contextText,
                  );
                } 
                else if (speakerInfoCheckMapping["speaker_Date"] ==
                    false) {
                  String titleText = "Invalid Date";
                  String contextText = "Select date for keynote speaker";
                  _checkForError(
                    context,
                    titleText,
                    contextText,
                  );
                } 
                else {
                  SpeakerLocalInformation speakerDetails = new SpeakerLocalInformation(
                    speaker_Unique_Id: "unique_id",
                    speaker_Name: speakerProfileMapping["speaker_Name"].text,
                    speaker_Position: speakerProfileMapping["speaker_Position"].text,
                    speaker_Talk_Title: speakerProfileMapping["speaker_Talk_Title"].text,
                    speaker_Abstract: speakerProfileMapping["speaker_Abstract"].text,
                    speaker_Bio: speakerProfileMapping["speaker_Bio"].text,
                    speaker_Start_Time: speakerProfileMapping["speaker_Start_Time"],
                    speaker_End_Time: speakerProfileMapping["speaker_End_Time"],
                    speaker_Image_File: speakerProfileMapping["speaker_Image_File"],
                    speaker_LinkedIn_Url: speakerProfileMapping["speaker_LinkedIn_Url"].text,
                    speaker_Website_Url: speakerProfileMapping["speaker_Website_Url"].text,
                  );

                  Provider.of<AddSectionsProvider>(context, listen: false).addNewKeyNoteSpeaker(context, speakerProfileMapping,);
                  // setState(() {
                  //   widget.speakerList.add(speakerDetails);
                  // });
                  // Navigator.pop(context);
                }
              },
              child: Container(
                width: screenWidth * 0.95,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.greenAccent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  "Add Keynote Speaker",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.035,
          ),
        ],
      ),
    );
  }

  Widget TextFieldContainer(
    BuildContext context,
    String eventHeading,
    String eventHintText,
    int minRows,
    int maxRows,
    Map<String, dynamic> userMapping,
    String mappingName,
    TextInputType keyBoardType,
  ) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;
    var minDimension = min(screenWidth, screenHeight);
    var maxDimension = max(screenWidth, screenHeight);

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 7.5,
        horizontal: 5,
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              width: screenWidth * 0.95,
              child: Text(
                eventHeading,
                style: TextStyle(
                  fontWeight: ui.FontWeight.bold,
                  fontSize: screenWidth * 0.05,
                ),
              ),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.0075,
          ),
          Align(
            child: Container(
              width: screenWidth * 0.95,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  width: 2,
                  color: Color.fromRGBO(205, 205, 205, 1),
                ),
              ),
              child: TextField(
                onTap: () {
                  // FocusScopeNode currentFocus = FocusScope.of(context);

                  // if (!currentFocus.hasPrimaryFocus) {
                  //   currentFocus.unfocus();
                  // }
                },
                controller: userMapping[mappingName],
                onChanged: ((value) {
                  setState(() {
                    userMapping[mappingName].selection =
                        TextSelection.collapsed(
                            offset: userMapping[mappingName].text.length);
                    userMapping[mappingName].text = value;
                    userMapping[mappingName].text = value;
                    userMapping[mappingName].selection =
                        TextSelection.collapsed(
                            offset: userMapping[mappingName].text.length);
                  });
                }),
                keyboardType: keyBoardType,
                decoration: InputDecoration(
                  hintText: eventHintText,
                  focusedBorder: InputBorder.none,
                ),
                autocorrect: true,
                minLines: minRows,
                maxLines: maxRows,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _presentTimePicker(
    BuildContext context,
    int bitVal,
  ) async {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;

    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }

    TimeOfDay timechosen = TimeOfDay.now();
    TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: timechosen,
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
    if (time != null) {
      setState(() {
        timechosen = time;
        if (bitVal == 0) {
          speakerProfileMapping["speaker_Start_Time"] = timechosen;
          speakerProfileMapping["speaker_End_Time"] = timechosen;
          speakerInfoCheckMapping["speaker_Start_Time"] = true;
        } else if (bitVal == 1) {
          int t1 = speakerProfileMapping["speaker_Start_Time"].hour * 60 +
              speakerProfileMapping["speaker_Start_Time"].minute;
          int t2 = timechosen.hour * 60 + timechosen.minute;

          if (t1 <= t2) {
            speakerProfileMapping["speaker_End_Time"] = timechosen;
            speakerInfoCheckMapping["speaker_End_Time"] = true;
          } else {
            String titleText = "In-Valid Time Interval!";
            String contextText =
                "Ending time cannot be before the starging time...";
            _checkForError(context, titleText, contextText);
          }
        }
      });
    }
  }

  void _presentDatePicker(
    BuildContext context,
  ) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;

    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }

    DateTime lastPickingDate = DateTime.now().add(new Duration(days: 365));

    showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      initialDate: DateTime.now(),
      lastDate: lastPickingDate,
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      } else {
        setState(() {
          speakerProfileMapping["speaker_Date"] = pickedDate;
          speakerInfoCheckMapping["speaker_Date"] = true;
          _isDateSelected = true;
        });
      }
    });
  }

  Future<void> _checkForError(
      BuildContext context, String titleText, String contextText,
      {bool popVal = false}) async {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }

    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('$titleText'),
        content: Text('$contextText'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.check_circle_rounded,
              color: Color(0xff42ccc3),
            ),
            iconSize: 50,
            color: Colors.brown,
            onPressed: () {
              setState(() {
                if (popVal == false) {
                  Navigator.pop(ctx);
                }
              });
            },
          ),
        ],
      ),
    );
  }
}

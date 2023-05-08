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

class AddNewEventScreen extends StatefulWidget {
  const AddNewEventScreen({super.key});
  static const routeName = '/rise-add-new-event-section-screen';

  @override
  State<AddNewEventScreen> createState() => _AddNewEventScreenState();
}

class _AddNewEventScreenState extends State<AddNewEventScreen> {
  // File _profilePicture = new File("");
  bool _isProfilePicTaken = false;
  bool _isDateSelected = false;
  bool _isSaveButtonPressed = false;
  bool _isFetchLocationButtonPressed = false;

  List<DropdownMenuItem<String>> eventTypeList = [
    DropdownMenuItem(
      child: Text("RnD Showcases & Demos"),
      value: "RNDShowcasesAndDemos",
    ),
    DropdownMenuItem(
      child: Text("Forward Looking Panels"),
      value: "ForwardLookingPanels",
    ),
    DropdownMenuItem(
      child: Text("Beyond College Panels"),
      value: "BeyondCollegePanels",
    ),
    DropdownMenuItem(
      child: Text("Start-Up Showcase"),
      value: "StartUpShowcase",
    ),
    DropdownMenuItem(
      child: Text("Demos & Research Highlights"),
      value: "DemosAndResearchesHighlights",
    ),
    DropdownMenuItem(
      child: Text("Research Showcases"),
      value: "ResearchShowcases",
    ),
    DropdownMenuItem(
      child: Text("Panel Discussion"),
      value: "PanelDiscussion",
    ),
    DropdownMenuItem(
      child: Text("Extra Events"),
      value: "Extra-Events",
    ),
  ];

  List<SpeakerLocalInformation> speakerList = [];

  Map<String, dynamic> profileInfoMapping = {
    "Event_Image_File": File(""),
    "Event_Type": "SpeakerTracks",
    "Event_Name": TextEditingController(),
    "Event_Info": TextEditingController(),
    "Event_Address": TextEditingController(),
    "Event_Longitude": TextEditingController(),
    "Event_Latitude": TextEditingController(),
    "Event_Date": DateTime.now(),
    "Event_Start_Time": TimeOfDay.now(),
    "Event_End_Time": TimeOfDay.now(),
  };

  Map<String, bool> profileInfoCheckMapping = {
    "Event_Image_File": false,
    "Event_Date": false,
    "Event_Start_Time": false,
    "Event_End_Time": false,
    "Event_Name": false,
    "Event_Info": false,
    "Event_Address": false,
    "Event_Longitude": false,
    "Event_Latitude": false,
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
          "New Event",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 24,
          ),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.save,
              color: Colors.black,
              size: 30,
            ),
            onPressed: _isSaveButtonPressed
                ? null
                : () {
                    if (profileInfoCheckMapping["Event_Image_File"] == false) {
                      String titleText = "Invalid event image";
                      String contextText = "Select an event's image";
                      _checkForError(
                        context,
                        titleText,
                        contextText,
                      );
                    } else if (profileInfoCheckMapping["Event_Start_Time"] ==
                        false) {
                      String titleText = "Invalid start time";
                      String contextText = "Select the start time of the event";
                      _checkForError(
                        context,
                        titleText,
                        contextText,
                      );
                    } else if (profileInfoCheckMapping["Event_End_Time"] ==
                        false) {
                      String titleText = "Invalid end time";
                      String contextText = "Select the end time of the event";
                      _checkForError(
                        context,
                        titleText,
                        contextText,
                      );
                    } else if (profileInfoCheckMapping["Event_Date"] == false) {
                      String titleText = "Invalid date";
                      String contextText = "Select the date the event";
                      _checkForError(
                        context,
                        titleText,
                        contextText,
                      );
                    } else if (profileInfoCheckMapping["Event_Name"] == false) {
                      String titleText = "Invalid name";
                      String contextText = "Enter the name of the event";
                      _checkForError(
                        context,
                        titleText,
                        contextText,
                      );
                    } else if (profileInfoCheckMapping["Event_Info"] == false) {
                      String titleText = "Invalid Info";
                      String contextText = "Enter the info of the event";
                      _checkForError(
                        context,
                        titleText,
                        contextText,
                      );
                    } else if (profileInfoCheckMapping["Event_Address"] ==
                        false) {
                      String titleText = "Invalid Address";
                      String contextText = "Enter the address of the event";
                      _checkForError(
                        context,
                        titleText,
                        contextText,
                      );
                    } 
                    // else if (speakerList.isEmpty) {
                    //   String titleText = "No speaker available";
                    //   String contextText =
                    //       "Select atleast one speaker for the event";
                    //   _checkForError(
                    //     context,
                    //     titleText,
                    //     contextText,
                    //   );
                    // }
                     else {
                      setState(() {
                        _isSaveButtonPressed = true;
                      });

                      Provider.of<AddSectionsProvider>(
                        context,
                        listen: false,
                      ).addNewEvent(
                        context,
                        profileInfoMapping,
                        speakerList,
                      );
                    }
                  },
          )
        ],
      ),
      body: _isSaveButtonPressed
          ? ListView(
              children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: screenWidth * 0.35,
                  height: screenWidth * 0.35,
                  child: CircularProgressIndicator(),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Creation of event in progress.\nPlease wait for a while...",
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            )
          : ListView(
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
                        radius: screenWidth,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                            screenWidth * 0.2,
                          ),
                          child: ClipOval(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: !_isProfilePicTaken
                                  ? Image.asset(
                                      "assets/images/icons/event.png",
                                    )
                                  : Image.file(
                                      profileInfoMapping["Event_Image_File"],
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                    ),
                              // _isProfilePicTaken
                              //     ? Image.file(
                              //         _profilePicture,
                              //         fit: BoxFit.cover,
                              //         width: double.infinity,
                              //       )
                              //     : imageNetworkUrl == ""
                              //         ? Image.asset(
                              //             "assets/images/Nurse.png",
                              //           )
                              //         : Image.network(
                              //             imageNetworkUrl,
                              //             fit: BoxFit.cover,
                              //             width: double.infinity,
                              //           ),
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

                      setState(
                        () {
                          profileInfoMapping["Event_Image_File"] =
                              File(imageFile.path);
                          _isProfilePicTaken = true;
                          profileInfoCheckMapping["Event_Image_File"] = true;
                        },
                      );
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
                        !_isProfilePicTaken
                            ? "Add Event Icon"
                            : "Change Event Icon",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.025,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: screenWidth * 0.9,
                    child: Text(
                      "Select Event Type:",
                      style: TextStyle(
                        fontWeight: ui.FontWeight.bold,
                        fontSize: screenWidth * 0.05,
                      ),
                    ),
                  ),
                ),
                Align(
                  child: Container(
                    width: screenWidth * 0.9,
                    padding: EdgeInsets.symmetric(
                      vertical: 5,
                    ),
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.green.shade600,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.green.shade600,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        fillColor: Colors.green.shade200,
                      ),
                      items: eventTypeList,
                      dropdownColor: Colors.green.shade200,
                      value: eventTypeList[0].value,
                      onChanged: (String? value) {
                        setState(() {
                          profileInfoMapping["Event_Type"] = value.toString();
                        });
                      },
                    ),
                    // DropdownButton(
                    //   // value: selectedEventType,
                    //   dropdownColor: Colors.green,
                    //   items: eventTypeList,
                    //   onChanged: (String? value) {
                    //     setState(() {
                    //       profileInfoMapping["Event_Type"].text = value.toString();
                    //       print(profileInfoMapping["Event_Type"].text);
                    //       selectedEventType = value.toString();
                    //     });
                    //   },
                    // ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.025,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: screenWidth * 0.9,
                    child: Text(
                      "Set Event Time Interval:",
                      style: TextStyle(
                        fontWeight: ui.FontWeight.bold,
                        fontSize: screenWidth * 0.05,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.05,
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
                                  "${profileInfoMapping["Event_Start_Time"].format(context)}",
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
                                  "${profileInfoMapping["Event_End_Time"].format(context)}",
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
                    width: screenWidth * 0.9,
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
                  height: screenHeight * 0.01,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: screenWidth * 0.9,
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
                                ? '${DateFormat.yMMMMd('en_US').format(profileInfoMapping["Event_Date"] as DateTime)}'
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
                  height: screenHeight * 0.025,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: screenWidth * 0.9,
                    child: Text(
                      "Enter the Event Name:",
                      style: TextStyle(
                        fontWeight: ui.FontWeight.bold,
                        fontSize: screenWidth * 0.05,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.005,
                ),
                Align(
                  child: Container(
                    width: screenWidth * 0.9,
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
                      onChanged: ((value) {
                        profileInfoMapping["Event_Name"].text = value;

                        setState(
                          () {
                            if (value.length >= 5) {
                              profileInfoCheckMapping["Event_Name"] = true;
                            } else {
                              profileInfoCheckMapping["Event_Name"] = false;
                            }
                          },
                        );
                      }),
                      decoration: InputDecoration(
                        hintText: 'Event name',
                        focusedBorder: InputBorder.none,
                      ),
                      autocorrect: true,
                      minLines: 1,
                      maxLines: 1,
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.025,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: screenWidth * 0.9,
                    child: Text(
                      "Enter the Event Info:",
                      style: TextStyle(
                        fontWeight: ui.FontWeight.bold,
                        fontSize: screenWidth * 0.05,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.005,
                ),
                Align(
                  child: Container(
                    width: screenWidth * 0.9,
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
                      onChanged: ((value) {
                        profileInfoMapping["Event_Info"].text = value;
                        if (value.length >= 5) {
                          profileInfoCheckMapping["Event_Info"] = true;
                        } else {
                          profileInfoCheckMapping["Event_Info"] = false;
                        }
                      }),
                      decoration: InputDecoration(
                        hintText: 'Event info',
                        focusedBorder: InputBorder.none,
                      ),
                      autocorrect: true,
                      minLines: 3,
                      maxLines: 5,
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.025,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: screenWidth * 0.9,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            _isFetchLocationButtonPressed
                                ? "Fetching location..."
                                : "Fetch Current Location 👉🏻 ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          child: IconButton(
                            onPressed: () async {
                              setState(() {
                                _isFetchLocationButtonPressed = true;
                              });
                              Position currPosition = await _determinePosition();
                              Placemark currAddress = await getCurrentAddress(
                                currPosition.longitude,
                                currPosition.latitude,
                              );

                              setState(() {
                                _isFetchLocationButtonPressed = false;
                                // profileInfoMapping["Event_Address"].text = "Name: ${currAddress.name},\nStreet: ${currAddress.street},\nPostal Code: ${currAddress.postalCode},\nAdm Area: ${currAddress.administrativeArea},\nSub-Adm Area: ${currAddress.subAdministrativeArea}.";
                                profileInfoMapping["Event_Address"].text = currAddress.name;
                                profileInfoMapping["Event_Longitude"].text =
                                    currPosition.longitude.toString();
                                profileInfoMapping["Event_Latitude"].text =
                                    currPosition.latitude.toString();

                                profileInfoCheckMapping["Event_Address"] = true;
                                profileInfoCheckMapping["Event_Longitude"] =
                                    true;
                                profileInfoCheckMapping["Event_Latitude"] =
                                    true;
                              });
                            },
                            icon: Icon(
                              Icons.my_location,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.025,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: screenWidth * 0.9,
                    child: Text(
                      "Enter the Event Address:",
                      style: TextStyle(
                        fontWeight: ui.FontWeight.bold,
                        fontSize: screenWidth * 0.05,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.005,
                ),
                Align(
                  child: Container(
                    width: screenWidth * 0.9,
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
                      onChanged: ((value) {
                        profileInfoMapping["Event_Address"].selection =
                            TextSelection.collapsed(
                          offset:
                              profileInfoMapping["Event_Address"].text.length,
                        );
                        profileInfoMapping["Event_Address"].text = value;
                        profileInfoCheckMapping["Event_Address"] = true;
                        profileInfoMapping["Event_Address"].selection =
                            TextSelection.collapsed(
                          offset:
                              profileInfoMapping["Event_Address"].text.length,
                        );
                      }),
                      controller: profileInfoMapping["Event_Address"],
                      decoration: InputDecoration(
                        hintText: 'Event Address',
                        focusedBorder: InputBorder.none,
                      ),
                      autocorrect: true,
                      minLines: 3,
                      maxLines: 5,
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.025,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: screenWidth * 0.9,
                    child: Text(
                      "Enter Location Longitude:",
                      style: TextStyle(
                        fontWeight: ui.FontWeight.bold,
                        fontSize: screenWidth * 0.05,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.005,
                ),
                Align(
                  child: Container(
                    width: screenWidth * 0.9,
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
                      onChanged: ((value) {
                        profileInfoMapping["Event_Longitude"].selection =
                            TextSelection.collapsed(
                          offset:
                              profileInfoMapping["Event_Longitude"].text.length,
                        );
                        profileInfoMapping["Event_Longitude"].text = value;
                        profileInfoCheckMapping["Event_Longitude"] = true;
                        profileInfoMapping["Event_Longitude"].selection =
                            TextSelection.collapsed(
                          offset:
                              profileInfoMapping["Event_Longitude"].text.length,
                        );
                      }),
                      controller: profileInfoMapping["Event_Longitude"],
                      decoration: InputDecoration(
                        hintText: 'Event longitude',
                        focusedBorder: InputBorder.none,
                      ),
                      autocorrect: true,
                      minLines: 1,
                      maxLines: 1,
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.025,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: screenWidth * 0.9,
                    child: Text(
                      "Enter Location Latitude:",
                      style: TextStyle(
                        fontWeight: ui.FontWeight.bold,
                        fontSize: screenWidth * 0.05,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.005,
                ),
                Align(
                  child: Container(
                    width: screenWidth * 0.9,
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
                      onChanged: ((value) {
                        profileInfoMapping["Event_Latitude"].selection =
                            TextSelection.collapsed(
                          offset:
                              profileInfoMapping["Event_Latitude"].text.length,
                        );
                        profileInfoMapping["Event_Latitude"].text = value;
                        profileInfoCheckMapping["Event_Latitude"] = true;
                        profileInfoMapping["Event_Latitude"].selection =
                            TextSelection.collapsed(
                          offset:
                              profileInfoMapping["Event_Latitude"].text.length,
                        );
                      }),
                      controller: profileInfoMapping["Event_Latitude"],
                      decoration: InputDecoration(
                        hintText: 'Event latitude',
                        focusedBorder: InputBorder.none,
                      ),
                      autocorrect: true,
                      minLines: 1,
                      maxLines: 1,
                    ),
                  ),
                ),
                // SizedBox(
                //   height: screenHeight * 0.025,
                // ),
                // Align(
                //   child: Container(
                //     child: Row(
                //       children: [],
                //     ),
                //   ),
                // ),
                SizedBox(
                  height: screenHeight * 0.005,
                ),
                speakerList.isEmpty
                    ? SizedBox(
                        height: 0,
                      )
                    : Align(
                        child: Container(
                          width: screenWidth * 0.9,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "List of Speakers: ",
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                speakerList.isEmpty
                    ? Align(
                        child: Container(
                          child: Text(
                            "No speaker added",
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      )
                    : Align(
                        child: Container(
                          width: screenWidth * 0.9,
                          height: maxDimension * 0.19,
                          alignment: Alignment.centerLeft,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemCount: speakerList.length,
                            itemBuilder: (ctx, index) {
                              return InkWell(
                                onTap: () {
                                  print("pressed");
                                  setState(() {});
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 5,
                                  ),
                                  margin: EdgeInsets.only(
                                    right: 5,
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 5,
                                        ),
                                        height: minDimension * 0.3,
                                        width: minDimension * 0.25,
                                        child: CircleAvatar(
                                          backgroundColor: Colors.transparent,
                                          radius: screenWidth,
                                          child: CircleAvatar(
                                            radius: screenWidth * 0.6,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                screenWidth * 0.2,
                                              ),
                                              child: ClipOval(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      100,
                                                    ),
                                                  ),
                                                  child: Image.file(
                                                    speakerList[index]
                                                        .speaker_Image_File,
                                                    fit: BoxFit.cover,
                                                    width: double.infinity,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      FittedBox(
                                        fit: BoxFit.fill,
                                        child: Container(
                                          child: Text(
                                            speakerList[index]
                                                .speaker_Name
                                                .toString(),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                SizedBox(
                  height: screenHeight * 0.025,
                ),
                Align(
                  child: InkWell(
                    onTap: () {
                      FocusScopeNode currentFocus = FocusScope.of(context);
                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.unfocus();
                      }
                      if (profileInfoCheckMapping["Event_Image_File"] ==
                          false) {
                        String titleText = "Invalid Event Icon";
                        String contextText = "Please select the event icon";
                        _checkForError(
                          context,
                          titleText,
                          contextText,
                        );
                      } else if (profileInfoCheckMapping["Event_Start_Time"] ==
                          false) {
                        String titleText = "Invalid start event time";
                        String contextText =
                            "Please select the event start time";
                        _checkForError(
                          context,
                          titleText,
                          contextText,
                        );
                      } else if (profileInfoCheckMapping["Event_End_Time"] ==
                          false) {
                        String titleText = "Invalid end event time";
                        String contextText = "Please select the event end time";
                        _checkForError(
                          context,
                          titleText,
                          contextText,
                        );
                      } else if (profileInfoCheckMapping["Event_Date"] ==
                          false) {
                        String titleText = "Invalid event date";
                        String contextText = "Please select the event date";
                        _checkForError(
                          context,
                          titleText,
                          contextText,
                        );
                      } else if (profileInfoCheckMapping["Event_Name"] ==
                          false) {
                        String titleText = "Invalid Event name";
                        String contextText =
                            "Length of Event name should be atleast of 5 characters";
                        _checkForError(
                          context,
                          titleText,
                          contextText,
                        );
                      } else if (profileInfoCheckMapping["Event_Info"] ==
                          false) {
                        String titleText = "Invalid Event info";
                        String contextText =
                            "Length of Event info should be atleast of 10 characters";
                        _checkForError(
                          context,
                          titleText,
                          contextText,
                        );
                      } else {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => AddNewSpeakerForEventScreen(
                              this.speakerList,
                              1,
                            ),
                          ),
                        );
                      }

                      // Navigator.of(context).push(
                      //   MaterialPageRoute(
                      //     builder: (context) => AddNewSpeakerForEventScreen(
                      //       this.speakerList,
                      //     ),
                      //   ),
                      // );
                    },
                    child: Container(
                      width: screenWidth * 0.9,
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.greenAccent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "Add Speaker",
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
                  height: screenHeight * 0.025,
                ),
              ],
            ),
    );
  }

  void _presentDatePicker(BuildContext context) {
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
          profileInfoMapping["Event_Date"] = pickedDate;
          profileInfoCheckMapping["Event_Date"] = true;
          _isDateSelected = true;
        });
      }
    });
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
          profileInfoMapping["Event_Start_Time"] = timechosen;
          profileInfoMapping["Event_End_Time"] = timechosen;
          profileInfoCheckMapping["Event_Start_Time"] = true;
        } else if (bitVal == 1) {
          int t1 = profileInfoMapping["Event_Start_Time"].hour * 60 +
              profileInfoMapping["Event_Start_Time"].minute;
          int t2 = timechosen.hour * 60 + timechosen.minute;

          if (t1 <= t2) {
            profileInfoMapping["Event_End_Time"] = timechosen;
            profileInfoCheckMapping["Event_End_Time"] = true;
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

  // Widget TextFieldContainer(
  //   BuildContext context,
  //   String labelText,
  //   String contentText,
  //   Map<String, String> userMapping,
  //   TextInputType keyBoardType,
  // ) {
  //   var screenHeight = MediaQuery.of(context).size.height;
  //   var screenWidth = MediaQuery.of(context).size.width;
  //   var topInsets = MediaQuery.of(context).viewInsets.top;
  //   var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
  //   var useableHeight = screenHeight - topInsets - bottomInsets;
  //   var minDimension = min(screenWidth, screenHeight);
  //   var maxDimension = max(screenWidth, screenHeight);

  //   TextEditingController existingText = TextEditingController();
  //   existingText.text = userMapping[contentText] ?? "";

  //   existingText.selection = TextSelection.fromPosition(
  //       TextPosition(offset: existingText.text.length));

  //   return Align(
  //     alignment: Alignment.center,
  //     child: Container(
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(10),
  //         // color: Colors.white70,
  //         color: Color.fromRGBO(66, 204, 195, 0.1),
  //       ),
  //       margin: EdgeInsets.symmetric(
  //         vertical: screenHeight * 0.0015,
  //         // horizontal: screenWidth * 0.00125,
  //       ),
  //       padding: EdgeInsets.symmetric(
  //         horizontal: minDimension * 0.04,
  //         vertical: maxDimension * 0.01,
  //       ),
  //       height: maxDimension * 0.125,
  //       width: screenWidth * 0.95,
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: <Widget>[
  //           Container(
  //             width: screenWidth * 0.775,
  //             child: TextFormField(
  //               autocorrect: true,
  //               autofocus: true,
  //               enabled: editBtnMapping[contentText],
  //               controller: existingText,
  //               keyboardType: keyBoardType,
  //               style: TextStyle(
  //                 fontWeight: FontWeight.w500,
  //                 fontSize: 18,
  //               ),
  //               decoration: InputDecoration(
  //                 border: UnderlineInputBorder(),
  //                 labelText: labelText,
  //               ),
  //             ),
  //           ),
  //           ClipOval(
  //             child: Material(
  //               color: Color.fromRGBO(220, 229, 228, 1), // Button color
  //               child: InkWell(
  //                 splashColor: Color.fromRGBO(120, 158, 156, 1), // Splash color
  //                 onTap: () {
  //                   setState(() {
  //                     if (editBtnMapping[contentText] == true) {
  //                       Provider.of<SwasthyaMitraUserDetails>(context,
  //                               listen: false)
  //                           .updateSwasthyaMitraUserPersonalInformation(context,
  //                               contentText, existingText.text.toString());

  //                       userMapping[contentText] = existingText.text.toString();
  //                     }
  //                     isSaveChangesBtnActive = true;

  //                     if (editBtnMapping[contentText] == true) {
  //                       editBtnMapping[contentText] = false;
  //                     } else {
  //                       editBtnMapping[contentText] = true;
  //                     }
  //                   });
  //                 },
  //                 child: Padding(
  //                   padding: EdgeInsets.all(2),
  //                   child: SizedBox(
  //                     width: screenWidth * 0.075,
  //                     height: screenWidth * 0.075,
  //                     child: Icon(
  //                       editBtnMapping[contentText] == false
  //                           ? Icons.edit_rounded
  //                           : Icons.save_rounded,
  //                       size: 21,
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Future<void> _seclectImageUploadingType(
    BuildContext context,
    String titleText,
    String contextText,
    String imageNetworkUrl,
  ) async {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;

    String str1 = "Pick From Galary";
    String str2 = "Click a Picture";

    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(titleText),
        content: Text(contextText),
        actions: <Widget>[
          InkWell(
            onTap: () async {
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
                profileInfoMapping["Event_Image_File"] = File(imageFile.path);
                _isProfilePicTaken = true;
              });
              Navigator.pop(ctx);
              // // _saveUploadedImage(context, imageNetworkUrl);
              // Navigator.of(context).pop(true);
            },
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(220, 229, 228, 1),
              ),
              margin: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05,
                vertical: screenWidth * 0.025,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.075,
                vertical: screenWidth * 0.05,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.photo_size_select_actual_rounded,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      str1,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
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
          InkWell(
            onTap: () async {
              final picker = ImagePicker();
              final imageFile = await picker.getImage(
                source: ImageSource.camera,
                imageQuality: 80,
                maxHeight: 650,
                maxWidth: 650,
              );

              if (imageFile == null) {
                return;
              }
              setState(() {
                profileInfoMapping["Event_Image_File"] = File(imageFile.path);
                _isProfilePicTaken = true;
                // Navigator.of(context).pop(false);
              });
              Navigator.pop(ctx);
              // // _saveUploadedImage(ctx, imageNetworkUrl);
            },
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(220, 229, 228, 1),
              ),
              margin: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05,
                vertical: screenWidth * 0.025,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.075,
                vertical: screenWidth * 0.05,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.camera_alt_rounded,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      str2,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
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

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  Future<Placemark> getCurrentAddress(
    double longitude,
    double latitude,
  ) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
      latitude,
      longitude,
    );

    return placemarks[0];
  }
}

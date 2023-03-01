// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, unused_import, unnecessary_import, duplicate_import, unused_local_variable, deprecated_member_use, file_names

import 'dart:async';
import 'dart:math';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class AddnewEventScreen extends StatefulWidget {
  const AddnewEventScreen({super.key});
  static const routeName = '/rise-add-new-event-section-screen';

  @override
  State<AddnewEventScreen> createState() => _AddnewEventScreenState();
}

class _AddnewEventScreenState extends State<AddnewEventScreen> {
  File _profilePicture = new File("");
  bool _isProfilePicTaken = false;

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
      ),
      body: ListView(
        children: [
          Align(
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: 15,
              ),
              height: maxDimension * 0.225,
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
                        child: Image.asset(
                          "assets/images/icons/event.png",
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
                  _profilePicture = File(imageFile.path);
                  _isProfilePicTaken = true;
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
                  !_isProfilePicTaken ? "Add Event Icon" : "Change Event Icon",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

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
        title: Text('${titleText}'),
        content: Text('${contextText}'),
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
                _profilePicture = File(imageFile.path);
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
                _profilePicture = File(imageFile.path);
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
}

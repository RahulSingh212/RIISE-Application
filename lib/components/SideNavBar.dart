// ignore_for_file: unnecessary_this, use_key_in_widget_constructors, unused_field, prefer_final_fields, prefer_const_constructors, use_build_context_synchronously, deprecated_member_use, prefer_const_literals_to_create_immutables, unused_import, must_be_immutable, unused_local_variable, duplicate_import, unused_element, unnecessary_import, no_leading_underscores_for_local_identifiers, file_names, sized_box_for_whitespace, avoid_unnecessary_containers

import 'dart:async';
import 'dart:math';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "package:flutter/services.dart";
import 'package:riise/screens/TabScreen.dart';

class SideNavBar extends StatefulWidget {
  static const routeName = '/rise-side-nav-screen';

  const SideNavBar({super.key});

  @override
  State<SideNavBar> createState() => _SideNavBarState();
}

class _SideNavBarState extends State<SideNavBar> {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;

    return Drawer(
      child: ListView(
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            height: screenHeight * 0.175,
            width: screenWidth * 0.35,
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
                          "assets/images/icons/profile.png",
                        )
                        // _isProfilePicTaken
                        //     ? Image.file(
                        //         _profilePicture,
                        //         fit: BoxFit.cover,
                        //         width: double.infinity,
                        //       )
                        //     : imageNetworkUrl == ""
                        //         ? Image.asset(
                        //             "assets/images/surgeon.png",
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
          SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.green.shade200,
            ),
            padding: EdgeInsets.only(
              top: 12.5,
              bottom: 12.5,
            ),
            margin: EdgeInsets.only(
              bottom: 30,
              left: 40,
              right: 40,
            ),
            child: Text(
              "My Profile",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17.5,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          sideBarTile(
            context,
            "Home",
            Icons.home_filled,
          ),
          sideBarTile(
            context,
            "Faculties",
            Icons.person_rounded,
          ),
          sideBarTile(
            context,
            "Schedule",
            Icons.schedule,
          ),
          sideBarTile(
            context,
            "Directions",
            Icons.map_rounded,
          ),
          sideBarTile(
            context,
            "Appointments",
            Icons.meeting_room_rounded,
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 10,
            ),
            margin: EdgeInsets.only(
              top: 12.5,
              bottom: 17.5,
            ),
            child: Divider(
              color: Colors.green.shade500,
            ),
          ),
          sideBarTile(
            context,
            "About RIISE",
            Icons.star_outlined,
          ),
          sideBarTile(
            context,
            "Themes",
            Icons.event_note_rounded,
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 10,
            ),
            margin: EdgeInsets.only(
              top: 12.5,
              bottom: 17.5,
            ),
            child: Divider(
              color: Colors.green.shade500,
            ),
          ),
          sideBarTile(
            context,
            "Keynote Speaker",
            Icons.person_pin_rounded,
          ),
          sideBarTile(
            context,
            "Speaker Tracks",
            Icons.multitrack_audio_rounded,
          ),
          sideBarTile(
            context,
            "Poster Tracks",
            Icons.podcasts_rounded,
          ),
          sideBarTile(
            context,
            "Panel Discussion",
            Icons.people_alt_rounded,
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 10,
            ),
            margin: EdgeInsets.only(
              top: 12.5,
              bottom: 47.5,
            ),
            child: Divider(
              color: Colors.green.shade500,
            ),
          ),
          sideBarTile(
            context,
            "Logout",
            Icons.logout,
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 10,
            ),
            margin: EdgeInsets.only(
              top: 12.5,
              bottom: 7.5,
            ),
            // child: Divider(
            //   color: Colors.green.shade500,
            // ),
          ),
        ],
      ),
    );
  }

  Widget sideBarTile(
    BuildContext context,
    String tileText,
    IconData tileIconData,
  ) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;

    return Container(
      margin: EdgeInsets.only(
        left: 5,
        right: 5,
        bottom: 2.5,
      ),
      padding: EdgeInsets.all(18.5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.green.shade100,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.only(
              right: 20,
            ),
            child: Icon(tileIconData),
          ),
          Container(
            child: Text(
              tileText,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ignore_for_file: unnecessary_this, use_key_in_widget_constructors, unused_field, prefer_final_fields, prefer_const_constructors, use_build_context_synchronously, deprecated_member_use, prefer_const_literals_to_create_immutables, unused_import, must_be_immutable, unused_local_variable, duplicate_import, unused_element, unnecessary_import, no_leading_underscores_for_local_identifiers, file_names, sized_box_for_whitespace, avoid_unnecessary_containers

import 'dart:async';
import 'dart:math';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import "package:flutter/services.dart";
import 'package:riise/providers/UserLoginProvider.dart';

import '../providers/ScreenControllerProvider.dart';
import '../screens/Profile/ProfileScreen.dart';
import '../screens/SingInScreen/LogInSignUpScreen.dart';
import '../screens/TabScreen.dart';
import '../screens/Home/HomeScreen.dart';
import '../screens/Faculty/FacultyScreen.dart';
import '../screens/Schedules/ScheduleScreen.dart';
import '../screens/Directions/DirectionScreen.dart';
import '../screens/Appointments/AppointmentScreen.dart';

import '../screens/About/AboutScreen.dart';
import '../screens/Themes/ThemesScreen.dart';

import '../screens/Keynote/KeynoteSpeakersScreen.dart';
import '../screens/SpeakerTracks/SpeakerTracksScreen.dart';
import '../screens/Posters/PosterTracks.dart';
import '../screens/RNDShowcase/RnDShowcaseAndDemoScreen.dart';
import '../screens/ForwardPannel/ForwardLookingPannelScreen.dart';
import '../screens/BeyondPannel/BeyondCollegePannelScreen.dart';
import '../screens/StartupShowcase/StartUpShowcase.dart';
import '../screens/DemosAndResearchs/DemosAndResearchsHighLightScreen.dart';
import '../screens/ResearchShowcase/ResearchShowcaseScreen.dart';
import '../screens/GuestFacultyInteraction/GuestFacultyInteractionScreen.dart';
import '../screens/Pannel/PannelDiscussionScreen.dart';

class SideNavBar extends StatefulWidget {
  static const routeName = '/rise-side-nav-screen';

  const SideNavBar({super.key});

  @override
  State<SideNavBar> createState() => _SideNavBarState();
}

class _SideNavBarState extends State<SideNavBar> {
  final _auth = FirebaseAuth.instance;

  Map<String, dynamic> screenMapping = {
    "tab": TabScreen(),
    "home": HomeScreen(),
    "faculty": FacultyScreen(),
    "schedule": ScheduleScreen(),
    "direction": DirectionScreen(),
    "appointment": AppointmentScreen(),
    "about": AboutScreen(),
    "theme": ThemesScreen(),
    "keynote-speakers": KeynoteSpeakersScreen(),
    "speaker-tracks": SpeakerTracksScreen(),
    "poster-tracks": PosterTracksScreen(),
    "rnd-showcase-and-demos": RNDShowcaseAndDemoScreen(),
    "forward-looking-panels": ForwardLookingPannelScreen(),
    "beyond-college-panels": BeyondCollegePannelScreen(),
    "start-up-showcase": StartUpShowcaseScreen(),
    "demos-n-research-highlights": DemosAndResearchHighlightScreen(),
    "research-showcase": ResearchShowcaseScreen(),
    "guest-faculty-interactions": GuestFacultyInteractionScreen(),
    "pannel-discussion": PannelDiscussionScreen(),
  };

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;

    return Drawer(
      // backgroundColor: Colors.black.withOpacity(0.75),
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
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(),
                ),
              );
            },
            child: Container(
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
          ),
          SizedBox(
            height: 10,
          ),
          sideTabBarTile(
            context,
            "Home",
            Icons.home_filled,
            "tab",
            0,
          ),
          sideTabBarTile(
            context,
            "Faculty",
            Icons.person_rounded,
            "tab",
            1,
          ),
          sideTabBarTile(
            context,
            "Schedule",
            Icons.schedule,
            "tab",
            2,
          ),
          sideTabBarTile(
            context,
            "Directions",
            Icons.map_rounded,
            "tab",
            3,
          ),
          sideTabBarTile(
            context,
            "Appointments",
            Icons.meeting_room_rounded,
            "tab",
            4,
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
            "about",
            5,
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
            "Keynote Address",
            Icons.person_pin_rounded,
            "keynote-speakers",
            6,
          ),
          sideBarTile(
            context,
            "RnD Showcases",
            Icons.apartment_rounded,
            "rnd-showcase-and-demos",
            7,
          ),
          sideBarTile(
            context,
            "Forward Panels",
            Icons.people_alt_rounded,
            "forward-looking-panels",
            8,
          ),
          sideBarTile(
            context,
            "Beyond Panels",
            Icons.people_rounded,
            "beyond-college-panels",
            9,
          ),
          sideBarTile(
            context,
            "Start-Up Showcases",
            Icons.construction_rounded,
            "start-up-showcase",
            10,
          ),
          sideBarTile(
            context,
            "Demos & Researches",
            Icons.find_in_page_rounded,
            "demos-n-research-highlights",
            11,
          ),
          sideBarTile(
            context,
            "Research Showcases",
            Icons.find_replace_rounded,
            "research-showcase",
            12,
          ),
          // sideBarTile(
          //   context,
          //   "Speaker Tracks",
          //   Icons.multitrack_audio_rounded,
          //   "speaker-tracks",
          //   8,
          // ),
          // sideBarTile(
          //   context,
          //   "Poster Tracks",
          //   Icons.podcasts_rounded,
          //   "poster-tracks",
          //   9,
          // ),
          // sideBarTile(
          //   context,
          //   "Panel Discussion",
          //   Icons.people_alt_rounded,
          //   "pannel-discussion",
          //   10,
          // ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 10,
            ),
            margin: EdgeInsets.only(
              top: 12.5,
              bottom: 24.5,
            ),
            child: Divider(
              color: Colors.green.shade500,
            ),
          ),
          InkWell(
            onTap: () async {
              await GoogleSignIn().signOut();
              await _auth.signOut();
              // Navigator.of(context).pushNamedAndRemoveUntil(
              //   LogInSignUpScreen.routeName,
              //   (route) => false,
              // );
            },
            child: Container(
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
                    child: Icon(Icons.logout_rounded),
                  ),
                  Container(
                    child: Text(
                      "Logout",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
    String screenPushName,
    int pageIndex,
  ) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;

    return InkWell(
      onTap: () {
        Provider.of<ScreenControllerProvider>(context, listen: false)
            .selectedPageIndex = pageIndex;
        Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => screenMapping[screenPushName],
            ));
      },
      child: Container(
        margin: EdgeInsets.only(
          left: 5,
          right: 5,
          bottom: 2.5,
        ),
        padding: EdgeInsets.all(18.5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Provider.of<ScreenControllerProvider>(context, listen: false)
                      .selectedPageIndex ==
                  pageIndex
              ? Colors.green.shade300
              : Colors.green.shade100,
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
      ),
    );
  }

  Widget sideTabBarTile(
    BuildContext context,
    String tileText,
    IconData tileIconData,
    String screenPushName,
    int pageIndex,
  ) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;

    return InkWell(
      onTap: () {
        Provider.of<ScreenControllerProvider>(context, listen: false)
            .selectedPageIndex = pageIndex;
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => screenMapping[screenPushName],
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(
          left: 5,
          right: 5,
          bottom: 2.5,
        ),
        padding: EdgeInsets.all(18.5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Provider.of<ScreenControllerProvider>(context, listen: false)
                      .selectedPageIndex ==
                  pageIndex
              ? Colors.green.shade300
              : Colors.green.shade100,
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
      ),
    );
  }
}

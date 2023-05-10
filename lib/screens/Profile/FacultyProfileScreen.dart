// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, unused_import, unnecessary_import, duplicate_import, unused_local_variable, deprecated_member_use, file_names, unnecessary_new, sized_box_for_whitespace, avoid_unnecessary_containers, non_constant_identifier_names

import 'dart:async';
import 'dart:math';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:riise/providers/ScreenControllerProvider.dart';
import 'package:riise/providers/UserDetailsProvider.dart';
import 'package:riise/screens/QrCode/QrCodeGenerator.dart';
import 'package:riise/screens/SingInScreen/LogInSignUpScreen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../TabScreen.dart';

const FACULTY_USERTYPE = "Faculty";
const GUEST_USERTYPE = "Guest";
const FACULTY_COLLECTION_NAME = "FacultiesInformationList";
const GUEST_COLLECTION_NAME = "GuestsInformationList";

class FacultyProfileScreen extends StatefulWidget {
  static const routeName = '/rise-faculty-user-profile-screen';
  const FacultyProfileScreen({super.key});

  @override
  State<FacultyProfileScreen> createState() => _FacultyProfileScreenState();
}

class _FacultyProfileScreenState extends State<FacultyProfileScreen> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  bool isLangEnglish = true;
  File _profilePicture = new File("");
  bool _isProfilePicTaken = false;

  File _prescriptionFile = new File("");
  bool _isDocumentFileTaken = false;
  String docFileName = "";
  String docFileBytes = "";
  String docFileSize = "";
  String docFileExtentionType = "";
  String docFileLocation = "";

  bool isSaveChangesBtnActive = false;

  String defaultProfileImage =
      "https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/DefaultImages%2Fdefault-profile-image.png?alt=media&token=b303ab47-2802-4000-bddc-2a024a6b2d24";

  Map<String, bool> editBtnMapping = {
    'faculty_Unique_Id': false,
    'faculty_Authorization': false,
    'faculty_Name': false,
    'faculty_EmailId': false,
    'faculty_Department': false,
    'faculty_Position': false,
    'faculty_Gender': false,
    'faculty_Affiliated_Centers_And_Labs': false,
    'faculty_Bio': false,
    'faculty_College': false,
    'faculty_Image_Url': false,
    'faculty_LinkedIn_Url': false,
    'faculty_Website_Url': false,
    'faculty_Mobile_Messaging_Token_Id': false,
    'faculty_Mobile_Number': false,
    'faculty_Office_Address': false,
    'faculty_Office_Latitude': false,
    'faculty_Office_Longitude': false,
    'faculty_Office_Navigation_Url': false,
    'faculty_Research_Interests': false,
    'faculty_Teaching_Interests': false,
    'faculty_Dynamic_Links': false,
    'faculty_Website_Page': false,
    'faculty_QR_Code_Image_Url': false,
    "faculty_Google_Auth_Token_Id": false,
  };

  Future showPopUp(
    BuildContext context,
    Map<String, String> userMapping,
  ) async {
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return SimpleDialog(
              // elevation: 16,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              title: TextField(
                controller: TextEditingController(text: "QR Code"),
                style: TextStyle(fontSize: 55.sp),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "OR Code",
                  suffixIcon: ClipOval(
                    child: Image.network(
                      userMapping['faculty_Image_Url']! == ""
                          ? defaultProfileImage
                          : userMapping['faculty_Image_Url']!,
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
                Center(
                  child:
                      Image.network(userMapping['faculty_QR_Code_Image_Url']!),
                )
              ],
            );
          });
        },
        barrierColor: Colors.black.withOpacity(0.75));
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;
    var maxDimension = max(screenHeight, screenWidth);
    var minDimension = min(screenHeight, screenWidth);

    bool isImageAvailable = false;
    const defaultImg = 'assets/images/icons/profile.png';

    return StreamBuilder(
        stream: Provider.of<UserDetailsProvider>(context, listen: false)
            .getFacultyProfileDetails(context)
            .asStream(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                width: screenWidth,
                height: screenHeight,
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: screenHeight * 0.35,
                      ),
                      Center(child: CircularProgressIndicator()),
                      Container(
                          child: Text(
                        "Loading your profile...",
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                        ),
                        textAlign: TextAlign.center,
                      )),
                    ],
                  ),
                ),
              ),
            );
          } else {
            // print(snapshot.data);
            return Scaffold(
              // backgroundColor: Color.fromRGBO(66, 204, 195, 0.84),
              backgroundColor: Colors.white,
              body: ListView(
                children: <Widget>[
                  Container(
                    alignment: Alignment.topCenter,
                    color: Color.fromRGBO(66, 204, 195, 0.84),
                    // color: Colors.amber,
                    // height: maxDimension * 0.245,
                    height: 450.spMin,
                    padding: EdgeInsets.only(
                      left: screenWidth * 0.015,
                      right: screenWidth * 0.015,
                      top: screenHeight * 0.0075,
                      bottom: screenHeight * 0.001,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        IconButton(
                          onPressed: () {
                            // Navigator.of(context).pushReplacementNamed(TabScreen.routeName);
                            Navigator.of(context).pop(context);
                          },
                          iconSize: 30,
                          icon: Icon(
                            Icons.arrow_back_rounded,
                            color: Colors.white,
                          ),
                        ),
                        Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            alignment: Alignment.center,
                            // color: Colors.grey,
                            height: screenHeight * 0.235,
                            width: screenWidth * 0.45,
                            padding: EdgeInsets.symmetric(
                              // vertical: screenHeight * 0.005,
                              horizontal: screenWidth * 0.01,
                            ),
                            margin: EdgeInsets.only(
                              top: maxDimension * 0.0025,
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: screenWidth * 0.025,
                                ),
                                Container(
                                  height: screenWidth * 0.315,
                                  width: screenWidth * 0.315,
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
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                            ),
                                            child: _isProfilePicTaken
                                                ? Image.file(
                                                    _profilePicture,
                                                    fit: BoxFit.cover,
                                                    width: double.infinity,
                                                  )
                                                : snapshot.data[
                                                            "faculty_Image_Url"] ==
                                                        ""
                                                    ? Image.asset(
                                                        "assets/images/icons/profile.png",
                                                      )
                                                    : Image.network(
                                                        snapshot.data[
                                                            "faculty_Image_Url"],
                                                        fit: BoxFit.cover,
                                                        width: double.infinity,
                                                      ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            // Navigator.of(context).pushNamed(MySettingsScreen.routeName);
                            showPopUp(
                              context,
                              snapshot.data,
                            );
                          },
                          iconSize: 30,
                          icon: const Icon(
                            Icons.qr_code,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Container(
                        width: screenWidth,
                        color: Color.fromRGBO(66, 204, 195, 0.84),
                        alignment: Alignment.center,
                        child: Text(
                          '${snapshot.data['faculty_Name']}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: minDimension * 0.015,
                        ),
                        width: screenWidth,
                        color: Color.fromRGBO(66, 204, 195, 0.84),
                        alignment: Alignment.center,
                        child: Text(
                          '${snapshot.data['faculty_EmailId']}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 17.5,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.0065,
                  ),
                  TextFieldContainer(
                    context,
                    "Faculty Name",
                    'faculty_Name',
                    "Enter your Name...",
                    snapshot.data,
                    TextInputType.name,
                  ),
                  TextFieldContainer(
                    context,
                    "Faculty Email",
                    'faculty_EmailId',
                    "Enter your Email...",
                    snapshot.data,
                    TextInputType.name,
                  ),
                  TextFieldContainer(
                    context,
                    "Mobile Number",
                    'faculty_Mobile_Number',
                    "Enter your Mobile Number...",
                    snapshot.data,
                    TextInputType.number,
                  ),
                  TextFieldContainer(
                    context,
                    "Department Name",
                    'faculty_Department',
                    "Enter your Deparment...",
                    snapshot.data,
                    TextInputType.name,
                  ),
                  TextFieldContainer(
                    context,
                    "Position",
                    'faculty_Position',
                    "Enter your Position...",
                    snapshot.data,
                    TextInputType.name,
                  ),
                  TextFieldContainer(
                    context,
                    "Affiliated Centers & Labs",
                    'faculty_Affiliated_Centers_And_Labs',
                    "Enter your Centers and Labs...",
                    snapshot.data,
                    TextInputType.name,
                  ),
                  TextFieldContainer(
                    context,
                    "Bio",
                    'faculty_Bio',
                    "Enter your bio...",
                    snapshot.data,
                    TextInputType.name,
                  ),
                  TextFieldContainer(
                    context,
                    "Faculty College",
                    'faculty_College',
                    "Enter your college...",
                    snapshot.data,
                    TextInputType.name,
                  ),
                  TextFieldContainer(
                    context,
                    "Office Address",
                    'faculty_Office_Address',
                    "Enter your full address...",
                    snapshot.data,
                    TextInputType.name,
                  ),
                  TextFieldContainer(
                    context,
                    "Research Interests",
                    'faculty_Research_Interests',
                    "Enter your research address...",
                    snapshot.data,
                    TextInputType.name,
                  ),
                  TextFieldContainer(
                    context,
                    "Teaching Interests",
                    'faculty_Teaching_Interests',
                    "Enter your teaching interests...",
                    snapshot.data,
                    TextInputType.name,
                  ),
                  SizedBox(
                    height: screenHeight * 0.05,
                  ),
                  Align(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          15,
                        ),
                      ),
                      width: screenWidth * 0.9,
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          FirebaseAuth.instance.signOut().then((value) {
                            // Navigator.pushNamedAndRemoveUntil(
                            //     context,
                            //     TabScreen.routeName,
                            //     (Route<dynamic> route) => false);

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TabScreen(),
                              ),
                            );
                          });
                        },
                        icon: Icon(Icons.logout),
                        label: Text("Log out"),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.025,
                  ),

                  // ElevatedButton(
                  //   onPressed: () {
                  //     Navigator.of(context).push(
                  //       MaterialPageRoute(
                  //         builder: (context) => QrCodeGenerator(),
                  //       ),
                  //     );
                  //     print("Button Pressed");
                  //   },
                  //   child: Text(
                  //     "Qr Code",
                  //   ),
                  // )
                  // Container(
                  //   child: TextButton(
                  //     onPressed: !isSaveChangesBtnActive ? null : () {},
                  //     child: Container(
                  //       width: screenWidth * 0.95,
                  //       padding: EdgeInsets.symmetric(
                  //         vertical: screenHeight * 0.025,
                  //         horizontal: screenWidth * 0.01,
                  //       ),
                  //       decoration: BoxDecoration(
                  //         color: !isSaveChangesBtnActive
                  //             ? Color.fromRGBO(220, 229, 228, 1)
                  //             : Color(0xff42CCC3),
                  //         borderRadius: BorderRadius.circular(10),
                  //         border: Border.all(
                  //           width: 2,
                  //           color: Color(0xffCDCDCD),
                  //         ),
                  //       ),
                  //       child: Center(
                  //         child: Text(
                  //           "Save Changes",
                  //           style: TextStyle(
                  //             color: Colors.black,
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: screenHeight * 0.0125,
                  // ),
                ],
              ),
            );
          }
        });
  }

  Widget imageContainer(BuildContext context, String imgUrl) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;

    const defaultImg = 'assets/images/icons/profile.png';
    bool isImageAvailable = false;
    if (imgUrl.isNotEmpty) isImageAvailable = true;

    return Container(
      height: useableHeight * 0.3,
      padding: EdgeInsets.symmetric(
        vertical: useableHeight * 0.010,
        horizontal: screenWidth * 0.015,
      ),
      margin: EdgeInsets.symmetric(
        vertical: useableHeight * 0.0025,
      ),
      child: Card(
        elevation: 15,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey.shade100,
          ),
          padding: EdgeInsets.symmetric(vertical: useableHeight * 0.01),
          alignment: Alignment.center,
          child: CircleAvatar(
            radius: screenWidth * 0.4,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(screenWidth * 0.4),
              child: ClipOval(
                child: isImageAvailable
                    ? Image.network(imgUrl)
                    : Image.asset(defaultImg),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget TextShowingFieldContainer(
    BuildContext context,
    String labelText,
    String contentText,
    Map<String, String> userMapping,
  ) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;

    TextEditingController existingText = TextEditingController();
    existingText.text = userMapping[contentText] ?? "";

    existingText.selection = TextSelection.fromPosition(
      TextPosition(
        offset: existingText.text.length,
      ),
    );

    return Align(
      alignment: Alignment.center,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white70,
          // color: Color.fromRGBO(66, 204, 195, 1),
        ),
        margin: EdgeInsets.symmetric(
          vertical: screenHeight * 0.0015,
          // horizontal: screenWidth * 0.00125,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.04,
          vertical: screenHeight * 0.01,
        ),
        height: screenHeight * 0.1,
        width: screenWidth * 0.95,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              width: screenWidth * 0.775,
              child: TextFormField(
                autocorrect: true,
                autofocus: true,
                enabled: false,
                controller: existingText,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: labelText,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget TextFieldContainer(
    BuildContext context,
    String labelText,
    String contentText,
    String hintTextMsg,
    Map<String, String> userMapping,
    TextInputType keyBoardType,
  ) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;

    TextEditingController existingText = TextEditingController();
    existingText.text = userMapping[contentText] ?? "";

    existingText.selection = TextSelection.fromPosition(
      TextPosition(
        offset: existingText.text.length,
      ),
    );

    return Align(
      alignment: Alignment.center,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white70,
          // color: Color.fromRGBO(66, 204, 195, 1),
        ),
        margin: EdgeInsets.symmetric(
          vertical: screenHeight * 0.00125,
          // horizontal: screenWidth * 0.00125,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.02,
          vertical: screenHeight * 0.00125,
        ),
        height: screenHeight * 0.1125,
        // width: screenWidth * 0.95,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: screenWidth * 0.85,
              child: TextFormField(
                autocorrect: true,
                autofocus: true,
                enabled: editBtnMapping[contentText],
                controller: existingText,
                keyboardType: keyBoardType,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
                decoration: InputDecoration(
                  hintText: hintTextMsg,
                  hintStyle: TextStyle(
                    color: Color.fromRGBO(8, 255, 198, 1),
                    overflow: TextOverflow.ellipsis,
                    fontSize: 15,
                  ),
                  border: UnderlineInputBorder(),
                  labelText: labelText,
                ),
              ),
            ),
            ClipOval(
              child: Material(
                color: Color.fromRGBO(220, 229, 228, 1), // Button color
                child: InkWell(
                  splashColor: Color.fromRGBO(120, 158, 156, 1), // Splash color
                  onTap: () {
                    setState(() {
                      if (editBtnMapping[contentText] == true) {
                        Provider.of<UserDetailsProvider>(context, listen: false)
                            .updateUserPersonalInformation(
                          context,
                          FACULTY_COLLECTION_NAME,
                          contentText,
                          existingText.text.toString(),
                        );

                        userMapping[contentText] = existingText.text.toString();
                      }
                      isSaveChangesBtnActive = true;

                      if (editBtnMapping[contentText] == true) {
                        editBtnMapping[contentText] = false;
                      } else {
                        editBtnMapping[contentText] = true;
                      }
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.all(2),
                    child: SizedBox(
                      width: screenWidth * 0.075,
                      height: screenWidth * 0.075,
                      child: Icon(
                        editBtnMapping[contentText] == false
                            ? Icons.edit_rounded
                            : Icons.save_rounded,
                        size: 21,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
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
        title: Text('$titleText'),
        content: Text('$contextText'),
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
              // _saveUploadedImage(context, imageNetworkUrl);
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
              });
              Navigator.pop(ctx);
              // _saveUploadedImage(context, imageNetworkUrl);
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

  // void openSingleDocumentFile(PlatformFile file) {
  //   OpenFile.open(file.path!);
  // }

  // void openMultipleDocumentFiles(List<PlatformFile> files) {}

  // Future<File> saveFilePermanently(PlatformFile file) async {
  //   final appStorage = await getApplicationDocumentsDirectory();
  //   final newFile = File('${appStorage.path}/${file.name}');

  //   return File(file.path!).copy(newFile.path);
  // }

  // Future<void> _seclectDocumentUploadingType(
  //   BuildContext context,
  //   String titleText,
  //   String contextText,
  // ) async {
  //   var screenHeight = MediaQuery.of(context).size.height;
  //   var screenWidth = MediaQuery.of(context).size.width;
  //   var topInsets = MediaQuery.of(context).viewInsets.top;
  //   var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
  //   var useableHeight = screenHeight - topInsets - bottomInsets;

  //   String str1 = "Upload from Local Storage";
  //   String str2 = "Click a Picture";

  //   return showDialog(
  //     context: context,
  //     builder: (ctx) => AlertDialog(
  //       title: Text('${titleText}'),
  //       content: Text('${contextText}'),
  //       actions: <Widget>[
  //         InkWell(
  //           onTap: () async {
  //             // // For Selecting, Opening, and Saving only one single file
  //             // final result = await FilePicker.platform.pickFiles(); // will select only one file at a time
  //             final result = await FilePicker.platform.pickFiles(
  //                 type: FileType.custom, allowedExtensions: ['pdf', 'doc']);
  //             if (result == null) {
  //               return;
  //             }

  //             setState(() {
  //               _isDocumentFileTaken = true;
  //             });

  //             // // Open Single File
  //             final file = result.files.first;
  //             openSingleDocumentFile(file);

  //             print('Name: ${file.name}');
  //             print('Bytes: ${file.bytes}');
  //             print('Size: ${file.size}');
  //             print('Extension: ${file.extension}');
  //             print('Path: ${file.path}');

  //             final newFile = await saveFilePermanently(file);

  //             print('From Path: ${file.path!}');
  //             print('To Path: ${newFile.path}');

  //             // // // For Selecting, Opening, and Saving Multiple files at the same time
  //             // final result = await FilePicker.platform.pickFiles(allowMultiple: true); // will select multiple files at a time
  //             // openMultipleDocumentFiles(result!.files);

  //             // // For Selecting, Opening, and Saving files of specific type at the same time
  //             // final result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf', 'doc']);
  //           },
  //           child: Container(
  //             decoration: BoxDecoration(
  //               color: Color.fromRGBO(220, 229, 228, 1),
  //             ),
  //             margin: EdgeInsets.symmetric(
  //               horizontal: screenWidth * 0.05,
  //               vertical: screenWidth * 0.025,
  //             ),
  //             padding: EdgeInsets.symmetric(
  //               horizontal: screenWidth * 0.075,
  //               vertical: screenWidth * 0.05,
  //             ),
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: <Widget>[
  //                 Container(
  //                   alignment: Alignment.center,
  //                   child: Icon(
  //                     Icons.photo_size_select_actual_rounded,
  //                   ),
  //                 ),
  //                 Container(
  //                   alignment: Alignment.center,
  //                   child: Text(
  //                     str1,
  //                     style: TextStyle(
  //                       fontWeight: FontWeight.bold,
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Future<void> _saveUploadedImage(
      BuildContext context, String imageNetworkUrl) async {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;

    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        actions: <Widget>[
          Container(
            // height: 0.3 * screenHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey.shade100,
            ),
            padding: EdgeInsets.symmetric(
              vertical: screenHeight * 0.025,
            ),
            alignment: Alignment.center,
            child: Container(
              child: CircleAvatar(
                backgroundColor: Colors.black,
                radius: screenWidth * 0.25,
                child: ClipOval(
                  child: _isProfilePicTaken
                      ? Image.file(
                          _profilePicture,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        )
                      : Image.asset("assets/images/healthy.png"),
                ),
              ),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.01,
          ),
          InkWell(
            onTap: () async {
              // Provider.of<PatientUserDetails>(context, listen: false)
              //     .updatePatientProfilePicture(context, _profilePicture);

              // Navigator.pop(ctx);
              // setState(() {
              //   _isProfilePicTaken = false;
              // });
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
                      Icons.save_rounded,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Save Image",
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
            height: screenHeight * 0.01,
          ),
          InkWell(
            onTap: () async {
              imageNetworkUrl == ""
                  ? Image.asset(
                      "assets/images/healthy.png",
                    )
                  : Image.network(
                      imageNetworkUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    );
              Navigator.pop(ctx);

              setState(() {
                _isProfilePicTaken = false;
              });
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
                      Icons.delete_rounded,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Discard Image",
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

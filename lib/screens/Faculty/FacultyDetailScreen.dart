// ignore_for_file: unused_import

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:riise/modules/AppointmentUtil.dart';
import 'package:riise/providers/FacultiesProvider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../components/SideNavBar.dart';
import '../../models/FacultyInfo.dart';


class FacultyDetailScreen extends StatefulWidget {
  FacultyDetailScreen({
    Key? key,
    // required this.position,
    required this.facultyDetails,
    this.qrIdentifier
  }) : super(key: key);

  // late int position;
  late FacultyServerInformation facultyDetails;
  late String? qrIdentifier;

  @override
  State<FacultyDetailScreen> createState() => _FacultyDetailScreenState();
}

class _FacultyDetailScreenState extends State<FacultyDetailScreen> {

  String defaultProfileImage = "https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/DefaultImages%2Fdefault-profile-image.png?alt=media&token=b303ab47-2802-4000-bddc-2a024a6b2d24";


  @override
  Widget build(BuildContext context) {

    print("QR IDENTIFIER = ${widget.qrIdentifier}");


    List<String> researchInterests = convertStrToList(widget.facultyDetails.faculty_Research_Interests);
    List<String> teachingInterests = convertStrToList(widget.facultyDetails.faculty_Teaching_Interests);
    List<String> centresLabs = convertStrToList(
        widget.facultyDetails.faculty_Affiliated_Centers_And_Labs);
    // print("RESEARCH INTERESTS -> " +researchInterests.length.toString());
    // print("TEACHING INTERESTS -> " +teachingInterests.length.toString());
    // print("CENTRES LABS -> " +centresLabs.length.toString());


    return Scaffold(
        backgroundColor: Colors.white,
        extendBodyBehindAppBar: true,
        drawer: SideNavBar(),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          //TODO - Make it flexible
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
          // actions: [
          //   Container(
          //     child: IconButton(
          //       onPressed: () {},
          //       icon: Icon(
          //         Icons.person,
          //       ),
          //     ),
          //   ),
          // ],
        ),
        body: Container(
          padding: EdgeInsets.only(top: 280.h, left: 20.w, right: 20.w),
          margin: EdgeInsets.symmetric(horizontal: 30.w),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
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
                          color: Colors.grey
                        ),
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
                      widget.facultyDetails.faculty_Position ==""?Container():
                      Flexible(
                        child: Text(
                          "${widget.facultyDetails.faculty_Position} (${widget.facultyDetails.faculty_Department})",
                          style: TextStyle(fontSize: 40.sp),
                          softWrap: true,
                          textAlign: TextAlign.center,
                          // maxLines: 100,
                        ),
                      ),
                      SizedBox(
                        height: 80.h,
                      ),
                      widget.facultyDetails.faculty_College ==""?Container():
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
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
                      // TODO - Add Department in FIREBASE
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
                              onTap: (){
                                launchUrlString('mailto:${widget.facultyDetails.faculty_EmailId}',mode: LaunchMode.externalApplication);
                              },
                              child: Text(
                                widget.facultyDetails.faculty_EmailId,
                                style: TextStyle(fontSize: 40.sp,color: Colors.blueAccent),
                                softWrap: true,
                                textAlign: TextAlign.center,
                                // maxLines: 100,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 120.w,
                          ),
                          widget.facultyDetails.faculty_Mobile_Number ==""?Container():
                          Icon(
                            Icons.call,
                            // size: ,
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          widget.facultyDetails.faculty_Mobile_Number ==""?Container():
                          Flexible(
                            child: InkWell(
                              onTap: (){
                                launchUrlString('tel:${widget.facultyDetails.faculty_Mobile_Number}',mode: LaunchMode.externalApplication);
                              },
                              child: Text(
                                widget.facultyDetails.faculty_Mobile_Number,
                                style: TextStyle(fontSize: 40.sp,color: Colors.blueAccent),
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
                          widget.facultyDetails.faculty_Website_Url ==""?Container():
                          Icon(
                            CupertinoIcons.globe,
                            // size: ,
                          ),
                          widget.facultyDetails.faculty_Website_Url ==""?Container():
                          Flexible(
                            child: InkWell(
                              onTap: () {
                                launchUrlString(
                                    widget.facultyDetails.faculty_Website_Url,
                                    mode: LaunchMode.externalApplication);
                              },
                              child: Text(
                                "WebPage",
                                style: TextStyle(
                                    fontSize: 40.sp, color: Colors.blueAccent),
                                softWrap: true,
                                textAlign: TextAlign.center,
                                // maxLines: 100,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 120.w,
                          ),
                          widget.facultyDetails.faculty_Office_Latitude == 0.0?Container():
                          Icon(
                            Icons.location_on_outlined,
                            // size: ,
                          ),
                          widget.facultyDetails.faculty_Office_Latitude == 0.0?Container():
                          Flexible(
                            child: InkWell(
                              onTap: (){
                                _launchDirectionsUrl(widget.facultyDetails.faculty_Office_Latitude.toString(),widget.facultyDetails.faculty_Office_Longitude.toString());
                              },
                              child: Text(
                                widget.facultyDetails.faculty_Office_Address,
                                style: TextStyle(fontSize: 40.sp,color:  Colors.blueAccent),
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
                    widget.facultyDetails.faculty_Bio ==""?Container():
                    Text(
                      "About",
                      style: TextStyle(fontSize: 60.sp),
                      softWrap: true,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    widget.facultyDetails.faculty_Bio ==""?Container():
                    Flexible(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 45.w),
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
                      researchInterests.length == 1?Container():
                      Text(
                        "Research Interests",
                        style: TextStyle(fontSize: 60.sp),
                        softWrap: true,
                        textAlign: TextAlign.center,
                      ),
                      researchInterests.length == 1?Container():
                      ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.symmetric(vertical: 40.h),
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, position) {
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: 50.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(CupertinoIcons.hand_point_right),
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
                      teachingInterests.length == 1?Container():
                      Text(
                        "Teaching Interests",
                        style: TextStyle(fontSize: 60.sp),
                        softWrap: true,
                        textAlign: TextAlign.center,
                      ),
                      teachingInterests.length == 1?Container():
                      ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.symmetric(vertical: 40.h),
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, position) {
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: 50.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(CupertinoIcons.hand_point_right),
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
                      centresLabs.length == 1?Container():
                      Text(
                        "Affiliated Centres & Labs",
                        style: TextStyle(fontSize: 60.sp),
                        softWrap: true,
                        textAlign: TextAlign.center,
                      ),
                      centresLabs.length == 1?Container():
                      ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.symmetric(vertical: 40.h),
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, position) {
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: 50.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(CupertinoIcons.hand_point_right),
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

  Future<void> _launchDirectionsUrl(String coordinateLatitude, String coordinateLongitude) async {
    Uri url = Uri.parse(
        'https://www.google.com/maps/dir/?api=1&destination=$coordinateLatitude,$coordinateLongitude&travelmode=walking');

    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }


}

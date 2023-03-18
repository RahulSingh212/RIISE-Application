// ignore_for_file: unused_import

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:riise/modules/AppointmentUtil.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../components/SideNavBar.dart';
import '../../models/FacultyInfo.dart';
import '../../modules/ThemeUtil.dart';

class FacultyDetailScreen extends StatefulWidget {
  FacultyDetailScreen({
    Key? key,
    // required this.position,
    required this.facultyDetails,
  }) : super(key: key);

  // late int position;
  late FacultyServerInformation facultyDetails;

  @override
  State<FacultyDetailScreen> createState() => _FacultyDetailScreenState();
}

class _FacultyDetailScreenState extends State<FacultyDetailScreen> {
  @override
  Widget build(BuildContext context) {
    List<String> researchInterests =
        convertStrToList(widget.facultyDetails.faculty_Research_Interests);
    List<String> teachingInterests =
        convertStrToList(widget.facultyDetails.faculty_Research_Interests);
    List<String> centresLabs = convertStrToList(
        widget.facultyDetails.faculty_Affiliated_Centers_And_Labs);

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
                            widget.facultyDetails.faculty_Image_Url,
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
                      Flexible(
                        child: Text(
                          widget.facultyDetails.faculty_Position + " (ECE,CSE)",
                          style: TextStyle(fontSize: 40.sp),
                          softWrap: true,
                          textAlign: TextAlign.center,
                          // maxLines: 100,
                        ),
                      ),
                      SizedBox(
                        height: 80.h,
                      ),
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
                          Icon(
                            Icons.call,
                            // size: ,
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
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
                          Icon(
                            CupertinoIcons.globe,
                            // size: ,
                          ),
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
                          Icon(
                            Icons.location_on_outlined,
                            // size: ,
                          ),
                          Flexible(
                            child: Text(
                              widget.facultyDetails.faculty_Office_Address,
                              style: TextStyle(fontSize: 40.sp),
                              softWrap: true,
                              textAlign: TextAlign.center,
                              // maxLines: 100,
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
                    Text(
                      "About",
                      style: TextStyle(fontSize: 60.sp),
                      softWrap: true,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
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
                      Text(
                        "Research Interests",
                        style: TextStyle(fontSize: 60.sp),
                        softWrap: true,
                        textAlign: TextAlign.center,
                      ),
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
                      Text(
                        "Research Interests",
                        style: TextStyle(fontSize: 60.sp),
                        softWrap: true,
                        textAlign: TextAlign.center,
                      ),
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
                      Text(
                        "Research Interests",
                        style: TextStyle(fontSize: 60.sp),
                        softWrap: true,
                        textAlign: TextAlign.center,
                      ),
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
}

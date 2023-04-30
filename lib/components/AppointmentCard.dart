import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:riise/modules/AppointmentUtil.dart';
import 'package:riise/providers/CalendarAPI.dart';

import '../models/FacultyInfo.dart';
import '../providers/FacultiesProvider.dart';

//ignore: must_be_immutable
class AppointmentCard extends StatefulWidget {
  AppointmentCard({Key? key, required this.appointment}) : super(key: key);

  late AppointmentUtil appointment;

  @override
  State<AppointmentCard> createState() => _AppointmentCardState();
}

class _AppointmentCardState extends State<AppointmentCard> {

  //Temp Faculty details, need to changed with class
  String facName = "Henansh";
  String facImage = "assets/images/icons/profile.png";
  String backImage = "https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/DefaultImages%2Fbackground.jpg?alt=media&token=876903fd-25f4-40b8-9c9b-2ab4bddce3d2";
  String defaultProfileImage =
      "https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/DefaultImages%2Fdefault-profile-image.png?alt=media&token=b303ab47-2802-4000-bddc-2a024a6b2d24";

  // Text(
  //   "${DateFormat("MMMMEEEEd").format(widget.appointment.starTime)}, ${DateFormat("hh:mm a").format(widget.appointment.starTime)} - ${DateFormat("hh:mm a").format(widget.appointment.endTime)}",
  //   style: TextStyle(fontSize: 30.sp),
  //   softWrap: true,
  // ),
  // SizedBox(height: 20.h,),
  // Row(
  //   mainAxisSize: MainAxisSize.min,
  //   mainAxisAlignment: MainAxisAlignment.start,
  //   crossAxisAlignment: CrossAxisAlignment.center,
  //   children: [
  //     // Icon(
  //     //   CupertinoIcons.time,
  //     //   // size: ,
  //     // ),
  //     // SizedBox(width: 20.w),
  //     Flexible(
  //       child: Text(
  //         "${DateFormat("MMMMEEEEd").format(widget.appointment.starTime)}, ${DateFormat("hh:mm a").format(widget.appointment.starTime)} - ${DateFormat("hh:mm a").format(widget.appointment.endTime)}",
  //         style: TextStyle(fontSize: 30.sp),
  //         softWrap: true,
  //       ),
  //     ),
  //   ],
  // ),

  // late FacultyServerInformation faculty;
  // bool isLoading = true;


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (context) => FacultyDetailScreen(
        //       // position: widget.position,
        //       facultyDetails: widget.facultyDetails,
        //     ),
        //   ),
        // );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.8.w, vertical: 20.h),
        // height: 700.h,
        // width: double.infinity,
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.s,
          // mainAxisSize: MainAxisSize.min,
          children: [


            Row(
              // mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon(
                //   CupertinoIcons.time,
                //   // size: ,
                // ),
                // SizedBox(width: 20.w),
                Flexible(
                  child: Text(
                    "${DateFormat("MMMMEEEEd").format(widget.appointment.starTime)}, ${DateFormat("hh:mm a").format(widget.appointment.starTime)} - ${DateFormat("hh:mm a").format(widget.appointment.endTime)}",
                    style: TextStyle(fontSize: 35.sp),
                    softWrap: true,
                  ),
                ),
              ],
            ),
            SizedBox(height: 40.h,),
            Expanded(
              child: Card(
                elevation: 1,
                // color: Colors.red,
                child: Container(
                  //BackGround Image
                  decoration: BoxDecoration(

                      image: DecorationImage(
                        //TODO - Change background image
                          image: NetworkImage(backImage,),
                          fit: BoxFit.cover
                      ),
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(25),bottomRight: Radius.circular(25))
                  ),

                  child: Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 30.42.h,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              height: 250.r,
                              width: 250.r,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: NetworkImage(
                                      widget.appointment.attendee.faculty_Image_Url == "Temp"?defaultProfileImage:widget.appointment.attendee.faculty_Image_Url

                                  ),
                                  fit: BoxFit.cover,
                                  scale: 0.4,
                                ),
                                border: Border.all(width: 2),
                                // borderRadius: BorderRadius.circular(12)
                              ),
                            ),
                            SizedBox(
                              width: 54.w,
                            ),
                            SizedBox(
                              width: 550.w,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Flexible(
                                    child: Text(
                                      widget.appointment.title,
                                      style: TextStyle(fontSize: 40.sp),
                                      softWrap: true,
                                      // overflow: TextOverflow.fade,
                                    ),
                                  ),
                                  SizedBox(height: 40.h,),
                                  // Row(
                                  //   mainAxisSize: MainAxisSize.min,
                                  //   mainAxisAlignment: MainAxisAlignment.start,
                                  //   crossAxisAlignment: CrossAxisAlignment.center,
                                  //   children: [
                                  //     Icon(
                                  //       Icons.calendar_month,
                                  //       // size: ,
                                  //     ),
                                  //     SizedBox(width: 20.w),
                                  //     Flexible(
                                  //       child: Text(
                                  //         "${DateFormat("MMMMEEEEd").format(widget.appointment.starTime)}",
                                  //         style: TextStyle(fontSize: 40.sp),
                                  //         softWrap: true,
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                  // Row(
                                  //   mainAxisSize: MainAxisSize.min,
                                  //   mainAxisAlignment: MainAxisAlignment.start,
                                  //   crossAxisAlignment: CrossAxisAlignment.center,
                                  //   children: [
                                  //     Icon(
                                  //       CupertinoIcons.time,
                                  //       // size: ,
                                  //     ),
                                  //     SizedBox(width: 20.w),
                                  //     Flexible(
                                  //       child: Text(
                                  //           "${DateFormat("hh:mm a").format(widget.appointment.starTime)} - ${DateFormat("hh:mm a").format(widget.appointment.endTime)}",
                                  //         style: TextStyle(fontSize: 40.sp),
                                  //         softWrap: true,
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),

                                  widget.appointment.attendee.faculty_Name != "Temp"
                                      ? Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        CupertinoIcons.person,
                                        // size: ,
                                      ),
                                      SizedBox(width: 20.w),
                                      Flexible(
                                        child: Text(
                                          widget.appointment.attendee.faculty_Name,
                                          style: TextStyle(fontSize: 40.sp),
                                        ),
                                      ),
                                    ],
                                  )
                                      : Container(),

                                  widget.appointment.attendee.faculty_Office_Address != "Temp"
                                      ? Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.location_on_outlined,
                                        // size: ,
                                      ),
                                      SizedBox(width: 20.w),
                                      Flexible(
                                        child: Text(
                                          widget.appointment.attendee.faculty_Office_Address,
                                          style: TextStyle(fontSize: 40.sp),
                                        ),
                                      ),
                                    ],
                                  )
                                      : Container(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
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
}

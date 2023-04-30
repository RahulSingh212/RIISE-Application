import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:riise/modules/AppointmentUtil.dart';
import '../models/FacultyInfo.dart';
import '../providers/FacultiesProvider.dart';
import '../screens/Faculty/FacultyDetailScreen.dart';

//ignore: must_be_immutable
class FacultyCard extends StatefulWidget {
  FacultyCard({
    Key? key,
    required this.facultyDetails,
  }) : super(key: key);

  late FacultyServerInformation facultyDetails;

  @override
  State<FacultyCard> createState() => _FacultyCardState();
}

class _FacultyCardState extends State<FacultyCard> {
  String backImage = "https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/DefaultImages%2Fbackground.jpg?alt=media&token=876903fd-25f4-40b8-9c9b-2ab4bddce3d2";
  String defaultProfileImage =
      "https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/DefaultImages%2Fdefault-profile-image.png?alt=media&token=b303ab47-2802-4000-bddc-2a024a6b2d24";

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => FacultyDetailScreen(
              // position: widget.position,
              facultyDetails: widget.facultyDetails,
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.8.w, vertical: 26.h),
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
                              widget.facultyDetails.faculty_Image_Url == ""
                                  ? defaultProfileImage
                                  : widget.facultyDetails.faculty_Image_Url,
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
                        width: 600.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              child: Text(
                                widget.facultyDetails.faculty_Name,
                                style: TextStyle(fontSize: 40.sp),
                                softWrap: true,
                                // overflow: TextOverflow.fade,
                              ),
                            ),
                            SizedBox(
                              height: 50.h,
                            ),
                            widget.facultyDetails.faculty_Position != ""
                                ? SizedBox(
                                    width: 500.w,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.work_outline,
                                          // size: ,
                                        ),
                                        SizedBox(width: 20.w),
                                        Flexible(
                                          child: Text(
                                            ("${widget.facultyDetails.faculty_Position} (${widget.facultyDetails.faculty_Department})"),
                                            style: TextStyle(fontSize: 40.sp),
                                            softWrap: true,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Container(),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.email_outlined,
                                  // size: ,
                                ),
                                SizedBox(width: 20.w),
                                Flexible(
                                  child: Text(
                                    widget.facultyDetails.faculty_EmailId,
                                    style: TextStyle(fontSize: 40.sp),
                                    softWrap: true,
                                  ),
                                ),
                              ],
                            ),
                            widget.facultyDetails.faculty_Office_Address != ""
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
                                          widget.facultyDetails
                                              .faculty_Office_Address,
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
    );
  }
}

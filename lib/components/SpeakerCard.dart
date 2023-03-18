import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:riise/modules/AppointmentUtil.dart';
import 'package:riise/modules/SpeakerUtil.dart';
import 'package:riise/screens/SpeakerDetailScreen.dart';
import '../models/FacultyInfo.dart';
import '../modules/EventUtil.dart';
import '../providers/FacultiesProvider.dart';
import '../screens/Faculty/FacultyDetailScreen.dart';

//ignore: must_be_immutable
class SpeakerCard extends StatefulWidget {
  SpeakerCard({
    Key? key,
    // required this.position,
    required this.speakerDetails,
  }) : super(key: key);

  // late int position;
  late SpeakerUtil speakerDetails;

  @override
  State<SpeakerCard> createState() => _SpeakerCardState();
}

class _SpeakerCardState extends State<SpeakerCard> {
  // AppointmentListUtil appointments = AppointmentListUtil();

  //Temp Faculty details, need to changed with class
  // String facName = "Henansh";
  // String facImage = "assets/images/icons/profile.png";
  // late var facultyProider = Provider.of<FacultiesProvider>(context, listen: false);
  String backImage = "assets/images/background/artificial-intelligence.jpg";



  @override
  Widget build(BuildContext context) {
    // var padding = MediaQuery.of(context).padding;
    // double width = (MediaQuery.of(context).size.width);
    // double height =
    //     (MediaQuery.of(context).size.height) - padding.top - padding.bottom;
    //
    // double minDimension = min(width, height);
    // double maxDimension = max(width, height);

    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => SpeakerDetailScreen(speakerDetails: widget.speakerDetails,
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.8.w, vertical: 11.7.h),
        child: Card(
          elevation: 1,
          // color: Colors.red,
          child: Container(
            //BackGround Image
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  backImage,
                ),
                fit: BoxFit.cover,
              ),
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
                              widget.speakerDetails.image,
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
                                widget.speakerDetails.name,
                                style: TextStyle(fontSize: 40.sp),
                                softWrap: true,
                                // overflow: TextOverflow.fade,
                              ),
                            ),
                            SizedBox(
                              height: 50.h,
                            ),
                            SizedBox(
                              width: 500.w,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.access_time,
                                    // size: ,
                                  ),
                                  SizedBox(width: 20.w),
                                  Flexible(
                                    child: Text(
                                      "${widget.speakerDetails.getStartTime()} - ${widget.speakerDetails.getEndTime()}",
                                      style: TextStyle(fontSize: 40.sp),
                                      softWrap: true,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // SizedBox(height: 0.005*height,),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  CupertinoIcons.speaker_1,
                                  // size: ,
                                ),
                                SizedBox(width: 20.w),
                                Flexible(
                                  child: Text(
                                    widget.speakerDetails.talkTitle,
                                    style: TextStyle(fontSize: 40.sp),
                                    softWrap: true,
                                  ),
                                ),
                              ],
                            ),
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

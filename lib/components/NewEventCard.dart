// ignore_for_file: unnecessary_import, unused_local_variable, avoid_print, file_names

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:riise/models/EventInfo.dart';
import 'package:riise/screens/EventDetailScreen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../helper/HexagonClipper.dart';
import '../models/ThemeInfo.dart';
import '../screens/Themes/ThemeDetailScreen.dart';

//ignore: must_be_immutable
class NewEventCard extends StatefulWidget {
  NewEventCard({Key? key, required this.eventDetails}) : super(key: key);

  // late int position;
  late EventServerInformation eventDetails;

  @override
  State<NewEventCard> createState() => _NewEventCardState();
}

class _NewEventCardState extends State<NewEventCard> {
  // ThemeListUtil themes = ThemeListUtil();

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
      onTap: (){
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => EventDetailScreen(
              // position: widget.position,
              eventDetails: widget.eventDetails,
            ),
          ),
        );
      },
      child: Card(
        elevation: 8,
        // semanticContainer: false,
        child: Container(
          // color: Colors.redAccent,
          margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipPath(
                clipper: HexagonClipper(),
                child: Container(
                  color: Color(0xff3faea8),
                  child: Image.network(
                    widget.eventDetails.Event_Image_Url,
                    width: 400.r,
                    height: 500.r,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              //
              // Image.network(
              //   widget.eventDetails.Event_Image_Url,
              //   width: 400.r,
              //   height: 400.r,
              //   fit: BoxFit.cover,
              // ),
              Flexible(
                child: Container(
                  // color: Colors.blueAccent,
                  padding: EdgeInsets.symmetric(vertical: 23.h),
                  margin: EdgeInsets.symmetric(vertical: 23.h),
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          widget.eventDetails.Event_Name,
                          style: TextStyle(fontSize:50.sp),
                          softWrap: true,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          textScaleFactor: 1.0,
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 5.spMin,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        // padding: EdgeInsets.zero,
                        // margin: EdgeInsets.zero,
                        // color: Colors.red,
                        child: IconButton(onPressed: (){
                          _launchDirectionsUrl(widget.eventDetails.Event_Latitude,widget.eventDetails.Event_Longitude);
                        }, icon: Icon(CupertinoIcons.location_solid,color: Colors.blueAccent,)),
                      ),
                      Flexible(
                        child: InkWell(
                          onTap: (){
                            _launchDirectionsUrl(widget.eventDetails.Event_Latitude,widget.eventDetails.Event_Longitude);
                          },
                          child: Container(
                            // color: Colors.blueAccent,
                            padding: EdgeInsets.only(top: 0.h),
                            margin: EdgeInsets.only(top: 0.h),
                            width: 250.spMin,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Flexible(
                                  child: Text(
                                    widget.eventDetails.Event_Address,
                                    style: TextStyle(fontSize:35.sp),
                                    softWrap: true,
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // SizedBox(width: 10.w,),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        // padding: EdgeInsets.zero,
                        // margin: EdgeInsets.zero,
                        // color: Colors.red,
                        child: IconButton(onPressed: (){

                        },
                            icon: Icon(CupertinoIcons.clock,color: Colors.blueAccent,)),
                      ),
                      Flexible(
                        child: Container(
                          // color: Colors.blueAccent,
                          padding: EdgeInsets.only(top: 0.h),
                          margin: EdgeInsets.only(top: 0.h),
                          width: 250.spMin,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Flexible(
                                child: Text(
                                  "${DateFormat("MMMMEEEEd").format(widget.eventDetails.Event_Date)}, ${widget.eventDetails.Event_Start_Time.format(context)} - ${widget.eventDetails.Event_End_Time.format(context)}",
                                  // widget.eventDetails.Event_Date.toString(),
                                  style: TextStyle(fontSize:35.sp),
                                  softWrap: true,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Flexible(
                  //   child: Container(
                  //     // color: Colors.blueAccent,
                  //     padding: EdgeInsets.only(top: 23.h),
                  //     margin: EdgeInsets.only(top: 23.h),
                  //     width: 300.r,
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       children: [
                  //         Flexible(
                  //           child: Text(
                  //             widget.eventDetails.Event_Date.toString(),
                  //             style: TextStyle(fontSize:40.sp),
                  //             softWrap: true,
                  //             textAlign: TextAlign.center,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // )
                ],

              )
            ],
          ),
        ),
      ),
    );
  }


  Future<void> _launchDirectionsUrl(
      String coordinateLatitude, String coordinateLongitude) async {
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

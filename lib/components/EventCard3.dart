// ignore_for_file: file_names, unused_local_variable, avoid_unnecessary_containers, prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:riise/models/EventInfo.dart';
import 'package:url_launcher/url_launcher.dart';


//ignore: must_be_immutable
class EventCard3 extends StatefulWidget {
  EventCard3({Key? key, required this.eventDetails}) : super(key: key);

  // late int position;
  late EventServerInformation eventDetails;

  @override
  State<EventCard3> createState() => _EventCard3State();
}

class _EventCard3State extends State<EventCard3> {

  String backImage = "https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/DefaultImages%2Fbackground.jpg?alt=media&token=876903fd-25f4-40b8-9c9b-2ab4bddce3d2";
  // EventListUtil events = EventListUtil();
  @override
  Widget build(BuildContext context) {

    return Card(
      elevation: 16,
      semanticContainer: false,
      shape: RoundedRectangleBorder(
        borderRadius:
        BorderRadius.only(topLeft: Radius.circular(25),bottomRight: Radius.circular(25)) ,
      ),
      // color: Colors.red,
      child: Container(

        padding: EdgeInsets.symmetric(vertical: 30.h),
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
              horizontal: 54.w, vertical: 23.4.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      widget.eventDetails.Event_Name,
                      style: TextStyle(fontSize: 40.sp),
                      softWrap: true,
                      textAlign: TextAlign.center,
                      // maxLines: 100,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 60.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    // size: ,
                  ),
                  Flexible(
                    child: InkWell(
                      onTap: (){
                        _launchDirectionsUrl(widget.eventDetails.Event_Latitude, widget.eventDetails.Event_Longitude);
                      },
                      child: Text(
                        widget.eventDetails.Event_Address,
                        style: TextStyle(fontSize: 40.sp,
                          color: Colors.blueAccent
                        ),
                        softWrap: true,
                        // textAlign: TextAlign.center,
                        // maxLines: 100,
                        // overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 120.w,
                  ),
                  Icon(
                    Icons.access_time_rounded,
                    // size: ,
                  ),
                  Flexible(
                    child: Text(
                      widget.eventDetails.Event_Start_Time.format(context),
                      style: TextStyle(fontSize: 40.sp,
                      ),
                      softWrap: true,
                      // textAlign: TextAlign.center,
                      // maxLines: 100,
                      // overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );

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

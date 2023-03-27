// ignore_for_file: file_names, unused_local_variable, avoid_unnecessary_containers, prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:riise/models/EventInfo.dart';
import 'package:url_launcher/url_launcher.dart';


//ignore: must_be_immutable
class EventCard extends StatefulWidget {
  EventCard({Key? key, required this.eventDetails}) : super(key: key);

  // late int position;
  late EventServerInformation eventDetails;

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {

  String backImage = "https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/DefaultImages%2Fbackground.jpg?alt=media&token=876903fd-25f4-40b8-9c9b-2ab4bddce3d2";

  @override
  Widget build(BuildContext context) {
    // var padding = MediaQuery.of(context).padding;
    // double width = (MediaQuery.of(context).size.width);
    // double height =
    //     (MediaQuery.of(context).size.height) - padding.top - padding.bottom;
    //
    // double minDimension = min(width, height);
    // double maxDimension = max(width, height);

    return Container(
      // margin: EdgeInsets.only(right: 0.008 * width),
      child: Card(
        elevation: 8,
        // color: Colors.red,
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(backImage,),
                  fit: BoxFit.cover
              )
          ),
          child: Container(
            margin: EdgeInsets.symmetric(
                horizontal: 54.w, vertical: 23.h),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Text(
                        widget.eventDetails.Event_Name,
                        style: TextStyle(fontSize: 40.sp),
                        softWrap: true,
                      ),
                    ),
                    Flexible(
                      child: Text(
                        //TODO - Ask if endTime is required to Show
                        widget.eventDetails.Event_Start_Time.format(context),
                        style: TextStyle(fontSize: 40.sp),
                        softWrap: true,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 46.8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  // crossAxisAlignment: CrossAxisAlignment.start,
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
                          style: TextStyle(fontSize: 35.sp,
                            color: Colors.blueAccent
                          ),
                          softWrap: true,
                          // maxLines: 100,
                          // overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
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

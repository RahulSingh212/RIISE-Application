// ignore_for_file: file_names, unused_local_variable, avoid_unnecessary_containers, prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../modules/EventUtil.dart';
import '../modules/EventUtil.dart';

//ignore: must_be_immutable
class EventCard3 extends StatefulWidget {
  EventCard3({Key? key, required this.position}) : super(key: key);

  late int position;

  @override
  State<EventCard3> createState() => _EventCard3State();
}

class _EventCard3State extends State<EventCard3> {
  EventListUtil events = EventListUtil();
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
                image: AssetImage(events.getEventsList()[widget.position].iconImage,),
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
                      events.getEventsList()[widget.position].name,
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
                    child: Text(
                      events.getEventsList()[widget.position].location,
                      style: TextStyle(fontSize: 40.sp,
                      ),
                      softWrap: true,
                      // textAlign: TextAlign.center,
                      // maxLines: 100,
                      // overflow: TextOverflow.ellipsis,
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
                      events.getEventsList()[widget.position].getTime(),
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
}
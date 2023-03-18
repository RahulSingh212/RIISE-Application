// ignore_for_file: file_names, unused_local_variable, avoid_unnecessary_containers, prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../modules/EventUtil.dart';
import '../modules/EventUtil.dart';

//ignore: must_be_immutable
class EventCard2 extends StatefulWidget {
  EventCard2({Key? key, required this.position,required this.eventDetails}) : super(key: key);

  late int position;
  late EventUtil eventDetails;

  @override
  State<EventCard2> createState() => _EventCard2State();
}

class _EventCard2State extends State<EventCard2> {
  EventListUtil events = EventListUtil();
  @override
  Widget build(BuildContext context) {
    // var padding = MediaQuery.of(context).padding;
    // double width = (MediaQuery.of(context).size.width);
    // double height =
    //     (MediaQuery.of(context).size.height) - padding.top - padding.bottom;
    //
    // double minDimension = min(width, height);
    // double maxDimension = max(width, height);

    return Card(
      elevation: 16,
      semanticContainer: false,
      shape: RoundedRectangleBorder(
        //TODO - Ask for same shape or different
        borderRadius: widget.position % 2 == 0 ?BorderRadius.only(topLeft: Radius.circular(35),bottomRight: Radius.circular(35)) : BorderRadius.only(topRight: Radius.circular(35),bottomLeft: Radius.circular(35)),
      ),
      // color: Colors.red,
      child: Container(
        //BackGround Image
        decoration: BoxDecoration(
          
            image: DecorationImage(
              //TODO - Change background image
                image: AssetImage(widget.eventDetails.iconImage,),
                fit: BoxFit.cover
            ),
          borderRadius: widget.position % 2 == 0 ?BorderRadius.only(topLeft: Radius.circular(35),bottomRight: Radius.circular(35)) : BorderRadius.only(topRight: Radius.circular(35),bottomLeft: Radius.circular(35)),
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
                      widget.eventDetails.name,
                      style: TextStyle(fontSize: 40.sp),
                      softWrap: true,
                      textAlign: TextAlign.center,
                      // maxLines: 100,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 46.8.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    // size: ,
                  ),
                  Flexible(
                    child: Text(
                      widget.eventDetails.location,
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

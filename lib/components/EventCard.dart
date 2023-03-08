// ignore_for_file: file_names, unused_local_variable, avoid_unnecessary_containers, prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../modules/EventUtil.dart';
import '../modules/EventUtil.dart';

//ignore: must_be_immutable
class EventCard extends StatefulWidget {
  EventCard({Key? key, required this.position}) : super(key: key);

  late int position;

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
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

    return Container(
      // margin: EdgeInsets.only(right: 0.008 * width),
      child: Card(
        elevation: 8,
        // color: Colors.red,
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(events.getEventsList()[widget.position].iconImage,),
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
                        events.getEventsList()[widget.position].name,
                        style: TextStyle(fontSize: 40.sp),
                        softWrap: true,
                      ),
                    ),
                    Flexible(
                      child: Text(
                        events.getEventsList()[widget.position].getTime(),
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
                      child: Text(
                        events.getEventsList()[widget.position].location,
                        style: TextStyle(fontSize: 35.sp,
                        ),
                        softWrap: true,
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
      ),
    );

  }
}

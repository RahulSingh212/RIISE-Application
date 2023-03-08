// ignore_for_file: file_names, unused_local_variable, avoid_unnecessary_containers, prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';
import '../modules/EventUtil.dart';
import '../modules/EventUtil.dart';

//ignore: must_be_immutable
class EventCard2 extends StatefulWidget {
  EventCard2({Key? key, required this.position}) : super(key: key);

  late int position;

  @override
  State<EventCard2> createState() => _EventCard2State();
}

class _EventCard2State extends State<EventCard2> {
  EventListUtil events = EventListUtil();
  @override
  Widget build(BuildContext context) {
    var padding = MediaQuery.of(context).padding;
    double width = (MediaQuery.of(context).size.width);
    double height =
        (MediaQuery.of(context).size.height) - padding.top - padding.bottom;

    double minDimension = min(width, height);
    double maxDimension = max(width, height);

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
                image: AssetImage(events.getEventsList()[widget.position].iconImage,),
                fit: BoxFit.cover
            ),
          borderRadius: widget.position % 2 == 0 ?BorderRadius.only(topLeft: Radius.circular(35),bottomRight: Radius.circular(35)) : BorderRadius.only(topRight: Radius.circular(35),bottomLeft: Radius.circular(35)),
        ),
        child: Container(
          margin: EdgeInsets.symmetric(
              horizontal: 0.05 * width, vertical: 0.01 * height),
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
                      style: TextStyle(fontSize: 15),
                      softWrap: true,
                      textAlign: TextAlign.center,
                      // maxLines: 100,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 0.02*height,),
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
                      events.getEventsList()[widget.position].location,
                      style: TextStyle(fontSize: 15,
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

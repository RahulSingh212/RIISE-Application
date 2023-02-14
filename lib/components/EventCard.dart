import 'dart:math';

import 'package:flutter/material.dart';
import '../modules/EventCardUtil.dart';

//ignore: must_be_immutable
class EventCard extends StatefulWidget {
  EventCard({Key? key, required this.position}) : super(key: key);

  late int position;

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  EventCardListUtil events = EventCardListUtil();
  @override
  Widget build(BuildContext context) {
    var padding = MediaQuery.of(context).padding;
    double width = (MediaQuery.of(context).size.width);
    double height =
        (MediaQuery.of(context).size.height) - padding.top - padding.bottom;

    double minDimension = min(width, height);
    double maxDimension = max(width, height);

    return Container(
      // margin: EdgeInsets.only(right: 0.008 * width),
      child: Card(
        elevation: 1,
        // color: Colors.red,
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(events.getThemesList()[widget.position].iconImage,),
                  fit: BoxFit.cover
              )
          ),
          child: Container(
            margin: EdgeInsets.symmetric(
                horizontal: 0.05 * width, vertical: 0.01 * height),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      events.getThemesList()[widget.position].name,
                      style: TextStyle(fontSize: 15),
                    ),
                    Text(
                      events.getThemesList()[widget.position].time,
                      style: TextStyle(fontSize: 15),
                    )
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(top: height*0.025),
                  child: Text(
                    "Location: ${events.getThemesList()[widget.position].location}",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    // return Card(
    //   margin: EdgeInsets.only(right: 0.07*width),
    //   child: Container(
    //     alignment: Alignment.center,
    //     // padding: const EdgeInsets.all(15.0),
    //     color: Colors.yellow,
    //     width: 0.3*width,
    //     child: Text(
    //         "Hello ${themes.getThemesList()[widget.position].name}"
    //     ),
    //   ),
    // );
  }
}

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:riise/modules/AppointmentUtil.dart';
import '../modules/EventUtil.dart';

//ignore: must_be_immutable
class AppointmentCard extends StatefulWidget {
  AppointmentCard({Key? key, required this.position}) : super(key: key);

  late int position;

  @override
  State<AppointmentCard> createState() => _AppointmentCardState();
}

class _AppointmentCardState extends State<AppointmentCard> {
  AppointmentListUtil appointments = AppointmentListUtil();

  //Temp Faculty details, need to changed with class
  String facName = "Henansh";
  String facImage = "assets/images/icons/profile.png";





  @override
  Widget build(BuildContext context) {
    var padding = MediaQuery.of(context).padding;
    double width = (MediaQuery.of(context).size.width);
    double height =
        (MediaQuery.of(context).size.height) - padding.top - padding.bottom;

    double minDimension = min(width, height);
    double maxDimension = max(width, height);

    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: 0.05 * width, vertical: 0.02* height),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${appointments.getThemesList()[widget.position].getTime()}, ${appointments.getThemesList()[widget.position].getDate()}",
            style: TextStyle(fontSize: 15),
          ),
          SizedBox(height: 0.010*height,),
          Card(
            elevation: 16,
            // color: Colors.red,
            child: Container(
              //BackGround Image
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(appointments.getThemesList()[widget.position].iconImage,),
                      fit: BoxFit.cover
                  )
              ),

              child: Container(
                margin: EdgeInsets.symmetric(
                    horizontal: 0.04 * width, vertical: 0.013 * height),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 0.11*height,
                          width: 0.2*width,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(facImage),
                                  fit: BoxFit.cover
                              ),
                            border: Border.all(
                              width: 2
                            ),
                            borderRadius: BorderRadius.circular(12)
                          ),
                        ),
                        SizedBox(width: 0.05*width),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              facName,
                              style: TextStyle(fontSize: 15),
                            ),
                            SizedBox(height: 0.022*height,),
                            Row(
                              children: [
                                Icon(
                                  Icons.topic_outlined,
                                  // size: ,
                                ),
                                SizedBox(width: 0.02*width),
                                Text(
                                  appointments.getThemesList()[widget.position].title,
                                  style: TextStyle(fontSize: 15),
                                ),
                              ],
                            ),
                            // SizedBox(height: 0.005*height,),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on_outlined,
                                  // size: ,
                                ),
                                SizedBox(width: 0.02*width),
                                Text(
                                  appointments.getThemesList()[widget.position].location,
                                  style: TextStyle(fontSize: 15),
                                ),
                              ],
                            ),
                            // SizedBox(height: 0.010*height,),
                            // Text(
                            //   "Location: ${appointments.getThemesList()[widget.position].location}",
                            //   style: TextStyle(fontSize: 15),
                            // ),
                            // SizedBox(height: 0.010*height,),
                            // Text(
                            //   appointments.getThemesList()[widget.position].getDate(),
                            //   style: TextStyle(fontSize: 15),
                            // ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(width: 0.05*width),
                    Icon(
                      CupertinoIcons.right_chevron,
                      size: 30,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );

  }
}

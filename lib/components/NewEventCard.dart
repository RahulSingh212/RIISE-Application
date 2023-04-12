// ignore_for_file: unnecessary_import, unused_local_variable, avoid_print, file_names

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:riise/models/EventInfo.dart';

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
        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (context) => ThemeDetailScreen(
        //       // position: widget.position,
        //       themeDetails: widget.eventDetails,
        //     ),
        //   ),
        // );
      },
      child: Container(
        margin: EdgeInsets.only(right: 86.w),
        child: Card(
          elevation: 8,
          // semanticContainer: false,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 27.w, vertical: 23.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  widget.eventDetails.Event_Image_Url,
                  width: 300.r,
                  height: 300.r,
                  fit: BoxFit.cover,
                ),
                Flexible(
                  child: Container(
                    padding: EdgeInsets.only(top: 23.h),
                    margin: EdgeInsets.only(top: 23.h),
                    width: 500.r,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(
                            widget.eventDetails.Event_Name,
                            style: TextStyle(fontSize:50.sp),
                            softWrap: true,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

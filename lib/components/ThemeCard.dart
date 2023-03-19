// ignore_for_file: unnecessary_import, unused_local_variable, avoid_print, file_names

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../models/ThemeInfo.dart';
import '../screens/Themes/ThemeDetailScreen.dart';

//ignore: must_be_immutable
class ThemeCard extends StatefulWidget {

  ThemeCard({
    Key? key,
    // required this.position,
    required this.themeDetails,
  }) : super(key: key);

  // late int position;
  late ThemeServerInformation themeDetails;

  @override
  State<ThemeCard> createState() => _ThemeCardState();
}

class _ThemeCardState extends State<ThemeCard> {
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

    return Container(
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
              InkWell(
                onTap: () {
                  // print("${widget.position} clicked");
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ThemeDetailScreen(
                        // position: widget.position,
                        themeDetails: widget.themeDetails,
                      ),
                    ),
                  );
                },
                child: Image.network(
                  widget.themeDetails.Theme_Image_Url,
                  width: 200.r,
                  height: 200.r,
                ),
              ),
              Flexible(
                child: Container(
                  padding: EdgeInsets.only(top: 23.h),
                  margin: EdgeInsets.only(top: 23.h),
                  width: 300.r,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          widget.themeDetails.Theme_Name,
                          style: TextStyle(fontSize: 40.sp),
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
    );
  }
}

// ignore_for_file: unnecessary_import, unused_local_variable, avoid_print, file_names

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../models/ThemeInfo.dart';
import '../screens/Themes/ThemeDetailScreen.dart';

//ignore: must_be_immutable
class CategoryEventCard extends StatefulWidget {
  CategoryEventCard({
    Key? key,
    // required this.position,
    required this.eventDetail,
  }) : super(key: key);

  // late int position;
  late dynamic eventDetail;

  @override
  State<CategoryEventCard> createState() => _CategoryEventCardState();
}

class _CategoryEventCardState extends State<CategoryEventCard> {
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
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => widget.eventDetail[2],
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(right: 86.w),
        child: Card(
          elevation: 8,
          // semanticContainer: false,
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: 27.w,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  widget.eventDetail[1],
                  fit: BoxFit.contain,
                  width: 200.spMin,
                  height: 200.spMin,
                ),
                Flexible(
                  child: Container(
                    padding: EdgeInsets.only(top: 15.h),
                    width: 300.r,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(
                            widget.eventDetail[0],
                            style: TextStyle(
                              fontSize: 40.sp,
                              fontWeight: FontWeight.w500,
                            ),
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

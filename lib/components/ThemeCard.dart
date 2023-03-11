// ignore_for_file: unnecessary_import, unused_local_variable, avoid_print, file_names

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:riise/modules/ThemeUtil.dart';

//ignore: must_be_immutable
class ThemeCard extends StatefulWidget {
  ThemeCard({Key? key, required this.position}) : super(key: key);

  late int position;

  @override
  State<ThemeCard> createState() => _ThemeCardState();
}

class _ThemeCardState extends State<ThemeCard> {
  ThemeListUtil themes = ThemeListUtil();

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
              ClipOval(
                child: InkWell(
                  onTap: () {
                    print("${widget.position} clicked");
                  },
                  child: Image.asset(
                    themes.getThemesList()[widget.position].iconImage,
                    width: 200.r,
                    height: 200.r,
                  ),
                ),
              ),
              Flexible(
                child: Container(
                  margin: EdgeInsets.only(top: 23.h),
                  width: 300.r,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          themes.getThemesList()[widget.position].name,
                          style: TextStyle(fontSize: 35.sp),
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
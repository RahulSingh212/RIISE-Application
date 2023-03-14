// ignore_for_file: unnecessary_import, unused_local_variable, avoid_print, file_names

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:riise/modules/ThemeUtil.dart';

//ignore: must_be_immutable
class ThemeCard2 extends StatefulWidget {
  ThemeCard2({Key? key, required this.position}) : super(key: key);

  late int position;

  @override
  State<ThemeCard2> createState() => _ThemeCard2State();
}

class _ThemeCard2State extends State<ThemeCard2> {
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
              InkWell(
                onTap: () {
                  print("${widget.position} clicked");
                },
                child: Image.asset(
                  themes.getThemesList()[widget.position].iconImage,
                  width: 300.r,
                  height: 300.r,
                  fit: BoxFit.cover,
                ),
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
                          themes.getThemesList()[widget.position].name,
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
    );
  }
}

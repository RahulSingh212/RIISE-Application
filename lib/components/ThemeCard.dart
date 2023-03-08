// ignore_for_file: unnecessary_import, unused_local_variable, avoid_print, file_names

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    var padding = MediaQuery.of(context).padding;
    double width = (MediaQuery.of(context).size.width);
    double height =
        (MediaQuery.of(context).size.height) - padding.top - padding.bottom;

    double minDimension = min(width, height);
    double maxDimension = max(width, height);

    return Container(
      margin: EdgeInsets.only(right: 0.08 * width),
      child: Card(
        elevation: 8,
        // color: Colors.red,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 0.025 * width,vertical: 0.01 * height),
          child: Column(
            children: [
              ClipOval(
                child: InkWell(
                  onTap: () {
                    print("${widget.position} clicked");
                  },
                  child: Image.asset(
                      themes.getThemesList()[widget.position].iconImage,width: minDimension*0.2),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 0.010 * height),
                child:Text(
                    themes.getThemesList()[widget.position].name,
                  style: const TextStyle(
                    fontSize: 15
                  ),
                )
                ,)
            ],
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

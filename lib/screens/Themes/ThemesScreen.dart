// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, unused_import, unnecessary_import, duplicate_import, unused_local_variable, deprecated_member_use, file_names

import 'dart:async';
import 'dart:math';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:riise/components/ThemeCard.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../components/SideNavBar.dart';
import '../../components/ThemeCard2.dart';
import '../../modules/ThemeUtil.dart';
import '../../providers/EventsProvider.dart';
import 'ThemeDetailScreen.dart';

class ThemesScreen extends StatefulWidget {
  static const routeName = '/rise-themes-screen';

  const ThemesScreen({super.key});

  @override
  State<ThemesScreen> createState() => _ThemesScreenState();
}

class _ThemesScreenState extends State<ThemesScreen> {
  ThemeListUtil themes = ThemeListUtil();

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    Provider.of<EventProvider>(context, listen: false).fetchThemes(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        extendBodyBehindAppBar: true,
        drawer: SideNavBar(),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text(
            "Themes",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 60.sp,
            ),
            textAlign: TextAlign.center,
          ),
          iconTheme: IconThemeData(
            color: Colors.blue,
            size: 80.r,
          ),
          // actions: [
          //   Container(
          //     child: IconButton(
          //       onPressed: () {},
          //       icon: Icon(
          //         Icons.person,
          //       ),
          //     ),
          //   ),
          // ],
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 220.h),
          child: ListView.builder(
            itemCount: themes.getThemesList().length,
            scrollDirection: Axis.vertical,
            shrinkWrap: false,
            // physics: NeverScrollableScrollPhysics(),
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(vertical: 83.h, horizontal: 20.w),
            itemBuilder: (context, position) {
              return InkWell(
                onTap: () {
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (context) => ThemeDetailScreen(
                  //       position: position,
                  //       themeDetails: Provider.of<EventProvider>(context, listen: false).themesList[position],
                  //     ),
                  //   ),
                  // );
                },
                child: Container(
                  height: 700.h,
                  // color: Colors.redAccent,
                  padding: EdgeInsets.only(left: 86.w, top: 80.h),
                  child: ThemeCard2(
                    position: position,
                  ),
                ),
              );
            },
          ),
        ));
  }
}

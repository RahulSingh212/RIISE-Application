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
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../components/SideNavBar.dart';

class AboutScreen extends StatefulWidget {
  static const routeName = '/rise-about-screen';

  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    // var screenHeight = MediaQuery.of(context).size.height;
    // var screenWidth = MediaQuery.of(context).size.width;
    // var topInsets = MediaQuery.of(context).viewInsets.top;
    // var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    // var useableHeight = screenHeight - topInsets - bottomInsets;

    return Scaffold(
      backgroundColor: Colors.white,
      // drawer: SideNavBar(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "About RIISE",
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
      body: ListView(
        children: [
          Align(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 60.w,
                vertical: 80.h,
              ),
              // width: 1080.w,
              // height: 2106.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.green.shade300,
              ),
              child: RichText(
                textAlign: TextAlign.justify,
                text: TextSpan(
                  children: const [
                    TextSpan(
                      text:
                          "We are excited to announce Research and Innovation Incubation Showcase 2023 featuring a panel discussion and research poster presentations on below eight themes. The event will be a platform for discussing cutting-edge technologies and research opportunities. It will feature experts and thought leaders from academia and industry. The discussion aims to provide insights into these technologies and their potential impact on society. The poster presentations will showcase the latest research findings, technological advancements, and future opportunities.The event will also provide networking and knowledge-sharing opportunities among the attendees. Participants can connect with experts and peers, exchange ideas, and explore potential collaborations. The event is open to students, researchers, academicians, and industry professionals interested in the latest trends and opportunities. It is an excellent opportunity to stay updated on these fields' latest research and technological advancements and these eight themes' latest trends and opportunities. We look forward to your participation in this exciting event and hope to see you there!",
                    )
                  ],
                  style: TextStyle(
                    fontSize: 65.sp,
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

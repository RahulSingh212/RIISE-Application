// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, unused_import, unnecessary_import, duplicate_import, unused_local_variable, deprecated_member_use, file_names, must_be_immutable

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
import 'package:url_launcher/url_launcher.dart';

import '../../models/EventInfo.dart';

class PosterDetailTracks extends StatefulWidget {
  static const routeName = '/rise-poster-detail-tracks-screen';

  PosterDetailTracks({
    Key? key,
    required this.position,
    required this.posterTrackDetails,
  }) : super(key: key);

  late int position;
  late EventServerInformation posterTrackDetails;

  @override
  State<PosterDetailTracks> createState() => _PosterDetailTracksState();
}

class _PosterDetailTracksState extends State<PosterDetailTracks> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}